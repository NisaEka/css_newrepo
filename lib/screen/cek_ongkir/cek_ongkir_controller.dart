import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_city_model.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CekOngkirController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final searchCity = TextEditingController();
  final kotaPengirim = TextEditingController();
  final kotaTujuan = TextEditingController();
  final beratKiriman = TextEditingController();
  final panjang = TextEditingController();
  final lebar = TextEditingController();
  final tinggi = TextEditingController();
  final estimasiHargaBarang = TextEditingController();

  bool asuransi = false;
  bool dimensi = false;
  bool isCalculate = false;
  double berat = 0;
  double isr = 0;
  bool isLoading = false;

  List<City> cityList = [];
  List<Origin> originList = [];
  List<Origin> destinationList = [];
  List<Ongkir> ongkirList = [];

  GetOriginModel? cityModel;
  Origin? selectedDestination;
  Origin? selectedOrigin;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getOriginList(''),
      getDestinationList(''),
    ]);
  }

  Future<void> loadOngkir() async {
    if (asuransi) hitungAsuransi();
    ongkirList = [];
    isLoading = true;
    update();
    try {
      await ongkir
          .postCekOngkir(
        selectedOrigin?.originCode ?? '',
        selectedDestination?.originCode ?? '',
        beratKiriman.text,
      )
          .then((value) {
        ongkirList.addAll(value.ongkir ?? []);
      });
    } catch (e,i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
  }

  Future<List<Origin>> getOriginList(String keyword) async {
    originList = [];
    isLoading = true;
    try {
      var response = await ongkir.postOrigin(keyword);
      cityModel = response;
      originList.addAll(cityModel?.payload ?? []);
      // print(cityModel?.detail);
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
    return cityModel?.payload?.toList() ?? [];
    // return originList;
  }

  Future<List<Origin>> getDestinationList(String keyword) async {
    isLoading = true;
    destinationList = [];
    try {
      var response = await ongkir.postDestination(keyword);
      cityModel = response;
      destinationList.addAll(response.payload ?? []);
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
    return cityModel?.payload?.toList() ?? [];
  }

  void hitungAsuransi() {
    isr = 0;
    isr = (0.002 * (estimasiHargaBarang.text == '' ? 0 : estimasiHargaBarang.text.digitOnly().toInt())) + 5000;
    update();
  }

  void hitungBerat(double p, double l, double t) {
    isCalculate = true;
    berat = 0;
    update();

    if (dimensi) {
      berat = (p * l * t) / 6000;
      String b = "0.${berat.toStringAsFixed(2).split('.').last}";

      if (berat < 1) {
        beratKiriman.text = '1';
      } else if (b.toDouble() >= 0.31) {
        beratKiriman.text = berat.ceil().toString();
      } else {
        beratKiriman.text = berat.truncate().toString();
      }

      // if (b.split('.').last.toInt() > 30) {
      // beratKiriman.text = berat.truncate().toString();
      // }

      update();
    }
  }

  void showCityList(String title) {
    searchCity.clear();
    cityModel = null;
    update();
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title\n',
                style: appTitleTextStyle.copyWith(
                  color: greyDarkColor1,
                ),
              ),
              CustomSearchField(
                controller: searchCity,
                hintText: 'Cari'.tr,
                validate: searchCity.text.length < 3,
                validationText: 'Masukan 3 atau lebih karakter'.tr,
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 1000), () {
                    getOriginList(value).then((dest) {});
                  });

                  update();
                  setState(() {});
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                // child: ListView.builder(
                //   itemBuilder: (c, i) => ListTile(
                //     title: Text(destinationList[i].cityName ?? ''),
                //   ),
                // ),
                child: FutureBuilder(
                  // future: getOriginList(searchCity.text == '' ? 'jak' : searchCity.text),
                  future: (title == "Kota Asal" || title == "Origin") ? getOriginList(searchCity.text) : getDestinationList(searchCity.text),
                  // initialData: (title == "Kota Asal" || title == "Origin") ? originList : destinationList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final posts = snapshot.data!;
                      if (posts.isEmpty) {
                        return const Center(child: DataEmpty());
                      }
                      return buildPosts(posts, title);
                    } else {
                      return const Center(child: DataEmpty());
                    }
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget buildPosts(List<Origin> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(post.originName!),
          onTap: () {
            if (title == "Kota Asal" || title == "Origin") {
              selectedOrigin = post;
              kotaPengirim.text = post.originName.toString();
            } else if (title == "Kota Tujuan" || title == "Destination") {
              selectedDestination = post;
              kotaTujuan.text = post.originName.toString();
            }
            update();
            Get.back();
          },
        );
      },
    );
  }
}

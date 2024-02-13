import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_city_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
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
  bool isLoading = false;

  List<City> cityList = [];

  PostCekongkirCityModel? cityModel;
  City? selectedDestination;
  City? selectedOrigin;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getOriginList('jakarta'),
      getDestinationList('jakarta'),
    ]);
  }

  Future<List<City>> getOriginList(String keyword) async {
    cityList = [];
    isLoading = true;
    try {
      var response = await ongkir.postOrigin(keyword);
      cityModel = response;
      cityList.addAll(cityModel?.detail ?? []);
      print(cityModel?.detail);
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
    // return cityModel?.city?.toList() ?? [];
    return cityList;
  }

  Future<List<City>> getDestinationList(String keyword) async {
    isLoading = true;
    cityList = [];
    try {
      var response = await ongkir.postDestination(keyword);
      cityModel = response;
      cityList.addAll(response.detail ?? []);
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
    return cityList;
    // return destinationModel?.payload?.toList() ?? [];
  }

  void hitungBerat(double p, double l, double t) {
    isCalculate = true;
    berat = 0;
    update();

    if (dimensi) {
      berat = (p * l * t) / 6000;
      beratKiriman.text = berat!.toStringAsFixed(2);
    }

    update();
  }

  void showCityList(String title) {
    searchCity.clear();
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
                onSubmit: (value) {
                  print(value);
                  getOriginList(value).then((dest) {
                    print("dest $dest");
                    // destinationList = [];
                    // destinationList
                  });
                  update();
                  setState(() {});
                },
              ),
              const SizedBox(height: 15),
              Expanded(
                // child: ListView.builder(
                //   itemBuilder: (c, i) => ListTile(
                //     title: Text(destinationList[i].cityName ?? ''),
                //   ),
                // ),
                child: FutureBuilder(
                  future: getOriginList(searchCity.text),
                  // future: (title == "Kota Asal" || title == "Origin")
                  //     ? getOriginList(searchCity.text)
                  //     : getDestinationList(searchCity.text),
                  initialData: cityList,
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

  Widget buildPosts(List<City> data, String title) {
    print('title $title');
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(post.label!),
          onTap: () {
            if (title == "Kota Asal" || title == "Origin") {
              selectedOrigin = post;
              kotaPengirim.text = post.label.toString();
            } else if (title == "Kota Tujuan" || title == "Destination") {
              selectedDestination = post;
              kotaTujuan.text = post.label.toString();
            }
            update();
            Get.back();
          },
        );
      },
    );
  }
}

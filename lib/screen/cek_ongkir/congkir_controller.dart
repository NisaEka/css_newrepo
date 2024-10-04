import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CekOngkirController extends BaseController {
  final state = CekOngkirState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getOriginList(''),
      getDestinationList(''),
    ]);
  }

  Future<void> loadOngkir() async {
    if (state.formKey.currentState!.validate() == true) {
      if (state.asuransi) hitungAsuransi();
      state.ongkirList = [];
      state.isLoading = true;
      update();
      try {
        await ongkir
            .postCekOngkir(
          state.selectedOrigin?.originCode ?? '',
          state.selectedDestination?.originCode ?? '',
          state.beratKiriman.text,
        )
            .then((value) {
          state.ongkirList.addAll(value.ongkir ?? []);
        });
      } catch (e, i) {
        e.printError();
        i.printError();
      }

      state.isLoading = false;
      update();
    }
  }

  Future<List<Origin>> getOriginList(String keyword) async {
    state.originList = [];
    state.isLoading = true;
    try {
      var response = await ongkir.postOrigin(keyword);
      state.cityModel = response;
      state.originList.addAll(state.cityModel?.payload ?? []);
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    state.isLoading = false;
    update();
    return state.cityModel?.payload?.toList() ?? [];
    // return state.originList;
  }

  Future<List<Origin>> getDestinationList(String keyword) async {
    state.isLoading = true;
    state.destinationList = [];
    try {
      var response = await ongkir.postDestination(keyword);
      state.cityModel = response;
      state.destinationList.addAll(response.payload ?? []);
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    state.isLoading = false;
    update();
    return state.cityModel?.payload?.toList() ?? [];
  }

  void hitungAsuransi() {
    state.isr = 0;
    state.isr = (0.002 * (state.estimasiHargaBarang.text == '' ? 0 : state.estimasiHargaBarang.text.digitOnly().toInt())) + 5000;
    update();
  }

  void hitungBerat(double p, double l, double t) {
    state.isCalculate = true;
    state.berat = 0;
    update();

    if (state.dimensi) {
      state.berat = (p * l * t) / 6000;
      String b = "0.${state.berat.toStringAsFixed(2).split('.').last}";

      if (state.berat < 1) {
        state.beratKiriman.text = '1';
      } else if (b.toDouble() >= 0.31) {
        state.beratKiriman.text = state.berat.ceil().toString();
      } else {
        state.beratKiriman.text = state.berat.truncate().toString();
      }

      // if (b.split('.').last.toInt() > 30) {
      // state.beratKiriman.text = state.berat.truncate().toString();
      // }

      update();
    }
  }

  void showCityList(String title) {
    state.searchCity.clear();
    state.cityModel = null;
    update();
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: AppConst.isLightTheme(context) ? whiteColor : greyDarkColor1,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title\n',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CustomSearchField(
                controller: state.searchCity,
                hintText: 'Cari'.tr,
                validate: state.searchCity.text.length < 3,
                margin: EdgeInsets.zero,
                autoFocus: true,
                validationText: 'Masukan 3 atau lebih karakter'.tr,
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 1000), () {
                    getOriginList(value).then((dest) {});
                  });

                  update();
                  setState(() {});
                },
              ),
              // const SizedBox(height: 10),
              Expanded(
                // child: ListView.builder(
                //   itemBuilder: (c, i) => ListTile(
                //     title: Text(state.destinationList[i].cityName ?? ''),
                //   ),
                // ),
                child: FutureBuilder(
                  // future: getOriginList(state.searchCity.text == '' ? 'jak' : state.searchCity.text),
                  future:
                      (title == "Kota Asal" || title == "Origin") ? getOriginList(state.searchCity.text) : getDestinationList(state.searchCity.text),
                  // initialData: (title == "Kota Asal" || title == "Origin") ? state.originList : state.destinationList,
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
          title: Text(
            post.originName!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            if (title == "Kota Asal" || title == "Origin") {
              state.selectedOrigin = post;
              state.kotaPengirim.text = post.originName.toString();
            } else if (title == "Kota Tujuan" || title == "Destination") {
              state.selectedDestination = post;
              state.kotaTujuan.text = post.originName.toString();
            }
            update();
            Get.back();
          },
        );
      },
    );
  }
}

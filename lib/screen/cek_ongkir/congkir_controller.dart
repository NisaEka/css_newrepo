import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/destination_external_dropdown.dart';
import 'package:css_mobile/widgets/forms/origin_external_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CekOngkirController extends BaseController {
  final state = CekOngkirState();

  Future<void> loadOngkir() async {
    if (state.formKey.currentState!.validate() == true) {
      if (state.asuransi) hitungAsuransi();
      state.ongkirList = [];
      state.isLoading = true;
      update();
      try {
        await ongkir
            .postCekOngkir(
          state.selectedOrigin?.code ?? '',
          state.selectedDestination?.code ?? '',
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

  void hitungAsuransi() {
    state.isr = 0;
    state.isr = (0.002 *
            (state.estimasiHargaBarang.text == ''
                ? 0
                : state.estimasiHargaBarang.text.digitOnly().toInt())) +
        5000;
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

  Widget buildPosts(List<OriginExternal> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(
            post.label!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            if (title == "Kota Asal" || title == "Origin") {
              state.selectedOrigin = post;
              state.kotaPengirim.text = post.label.toString();
            } else if (title == "Kota Tujuan" || title == "Destination") {
              state.selectedDestination = post as DestinationExternal?;
              state.kotaTujuan.text = post.label.toString();
            }
            update();
            Get.back();
          },
        );
      },
    );
  }
}

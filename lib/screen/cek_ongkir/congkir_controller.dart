import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/forms/destination_external_dropdown.dart';
import 'package:css_mobile/widgets/forms/origin_external_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';

class CekOngkirController extends BaseController {
  final state = CekOngkirState();
  final network = Get.find<NetworkCore>();

  Future<void> loadOngkir() async {
    if (state.formKey.currentState!.validate() == true) {
      state.ongkirList = [];
      state.isLoading = true;
      update();
      try {
        final Map<String, String> queryParams = {
          'originCode': state.selectedOrigin?.code ?? '',
          'destinationCode': state.selectedDestination?.code ?? '',
          'isInsurance': state.asuransi.toString(),
        };

        if (state.beratKiriman.text.isNotEmpty) {
          queryParams['weight'] = state.beratKiriman.text;
        }

        if (state.dimensi) {
          queryParams['length'] = state.panjang.text;
          queryParams['width'] = state.lebar.text;
          queryParams['height'] = state.tinggi.text;
        }

        if (state.asuransi) {
          queryParams['goodsAmount'] =
              state.estimasiHargaBarang.text.replaceAll('.', '');
        }

        Response response = await network.base.get(
          '/transaction/fees/external',
          queryParameters: queryParams,
          options: Options(extra: {'skipAuth': true}),
        );

        state.weightExpress = '${response.data['data']['weightExpress']} KG';
        state.weightJtr = '${response.data['data']['weightJtr']} KG';
        if (state.dimensi) {
          state.weightExpress +=
              ' (${response.data['data']['length']} CM x ${response.data['data']['width']} CM x ${response.data['data']['height']} CM)';
          state.weightJtr +=
              ' (${response.data['data']['length']} CM x ${response.data['data']['width']} CM x ${response.data['data']['height']} CM)';
        }

        List<Ongkir> resultExpressList =
            (response.data['data']['resultExpress'] as List)
                .map((item) => Ongkir.fromJson(item))
                .toList();
        List<Ongkir> resultJtrList =
            (response.data['data']['resultJtr'] as List)
                .map((item) => Ongkir.fromJson(item))
                .toList();

        // Add all the mapped Ongkir objects to state.ongkirList
        state.ongkirList.addAll(resultExpressList);
        state.ongkirList.addAll(resultJtrList);
        update();
      } catch (e, i) {
        AppLogger.e('error loadOngkir $e, $i');
        AppSnackBar.error('Failed to load cek ongkir');
      } finally {
        state.isLoading = false;
        update();
      }
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

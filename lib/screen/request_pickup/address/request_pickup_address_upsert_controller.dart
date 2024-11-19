import 'dart:convert';
import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_create_request_model.dart';
import 'package:css_mobile/util/ext/placement_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class RequestPickupAddressUpsertController extends BaseController {
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  bool isLoadDestination = false;

  List<Destination> destinationList = [];
  Destination? selectedDestination;

  bool createDataLoading = false;
  bool createDataFailed = false;
  bool createDataSuccess = false;

  String? selectedLat;
  String? selectedLng;

  /// Internal methods.

  Future<RequestPickupAddressCreateRequestModel> _prepareRequestData() async {
    await locationFromAddress(address.text).then((locations) {
      final location = locations.firstOrNull;
      selectedLat = location?.latitude.toString();
      selectedLng = location?.longitude.toString();
    }).onError((error, stackTrace) {
      // Do nothing for now.
    });

    return RequestPickupAddressCreateRequestModel(
      pickupDataName: name.text,
      pickupDataPhone: phone.text,
      pickupDataAddress: address.text,
      pickupDataZipCode: selectedDestination?.zipCode ?? '',
      pickupDataCity: selectedDestination?.cityName ?? '',
      pickupDataDistrict: selectedDestination?.districtName ?? '',
      pickupDataSubdistrict: selectedDestination?.subdistrictName ?? '',
      pickupDataRegion: selectedDestination?.provinceName ?? '',
      pickupDataLatitude: selectedLat,
      pickupDataLongitude: selectedLng,
    );
  }

  _getDestinationByPostalCode(Placemark placemark) async {
    final where = [];
    where.add({"zipCode": placemark.postalCode});

    final soundex = [];
    soundex.add({"subdistrictName": placemark.subLocality});

    requestPickupRepository
        .getRequestPickupDestinations(QueryParamModel(
            table: true,
            limit: 50,
            where: jsonEncode(where),
            soundex: jsonEncode(soundex)))
        .then((value) => _setSelectedDestination(value.data?.first))
        .onError((error, stackTrace) => null);
  }

  _setSelectedDestination(Destination? destination) {
    selectedDestination = destination;
    update();
  }

  /// Screen methods.

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoadDestination = true;
    destinationList.clear();

    var response = await requestPickupRepository
        .getRequestPickupDestinations(QueryParamModel(
            table: true,
            limit: 50,
            search: keyword.toUpperCase(),
            sort: jsonEncode([
              {"id": "asc"}
            ])));
    var models = response.data ?? List.empty();

    isLoadDestination = false;
    update();

    return models;
  }

  void onSubmitAction() async {
    createDataLoading = true;
    update();

    requestPickupRepository
        .createRequestPickupAddress(await _prepareRequestData())
        .then((response) {
      if (response.code == HttpStatus.created) {
        Get.back(result: HttpStatus.created);
        createDataSuccess = true;
      } else {
        createDataFailed = true;
      }
    }).catchError((error) {
      AppLogger.e("Error on createRequestPickupAddress: $error");
      createDataFailed = true;
    });
    createDataLoading = false;
    update();
  }

  void onRefreshCreateState() {
    createDataLoading = false;
    createDataSuccess = false;
    createDataFailed = false;
  }

  void onSelectedPlaceMark(Placemark? placeMark) {
    if (placeMark != null) {
      address.text = placeMark.toReadableAddress();
      if (placeMark.postalCode != null) {
        AppLogger.d("PlaceMark: ${jsonEncode(placeMark)}");
        _getDestinationByPostalCode(placeMark);
      }
    }
  }
}

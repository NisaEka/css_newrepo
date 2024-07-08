import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_create_request_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/util/ext/placement_ext.dart';
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

  double? selectedLat;
  double? selectedLng;

  /// Internal methods.

  Future<RequestPickupAddressCreateRequestModel> _prepareRequestData() async {
    await locationFromAddress(address.text).then((locations) {
      final location = locations.firstOrNull;
      selectedLat = location?.latitude;
      selectedLng = location?.longitude;
    }).onError((error, stackTrace) {
      // Do nothing for now.
    });

    return RequestPickupAddressCreateRequestModel(
      name: name.text,
      phone: phone.text,
      address: address.text,
      zipCode: selectedDestination?.zipCode ?? '',
      city: selectedDestination?.cityName ?? '',
      district: selectedDestination?.districtName ?? '',
      subDistrict: selectedDestination?.subDistrictName ?? '',
      region: selectedDestination?.provinceName ?? '',
      lat: selectedLat,
      lng: selectedLng,
    );
  }

  _getDestinationByPostalCode(String postalCode) async {
    transaction.getDestination(postalCode)
        .then((value) => _setSelectedDestination(value.payload?.first))
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

    var response = await transaction.getDestination(keyword);
    var models = response.payload?.toList();

    isLoadDestination = false;
    update();

    return models ?? List.empty();
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
        _getDestinationByPostalCode(placeMark.postalCode!);
      }
    }
  }

}

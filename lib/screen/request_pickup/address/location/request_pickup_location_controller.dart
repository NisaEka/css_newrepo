import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/ext/placement_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestPickupLocationController extends BaseController {

  double _selectedLat = 0.0;
  double get selectedLat => _selectedLat;

  double _selectedLng = 0.0;
  double get selectedLng => _selectedLng;

  final List<Placemark> _placeMarks = [];
  List<Placemark> get placeMarks => _placeMarks;

  Placemark? _selectedPlaceMark;
  Placemark? get selectedPlaceMark => _selectedPlaceMark;

  TextEditingController addressText = TextEditingController();

  void onCameraMove(LatLng latLng) {
    _selectedLat = latLng.latitude;
    _selectedLng = latLng.longitude;
  }

  void onCameraIdle() async {
    _getAddress(await placemarkFromCoordinates(_selectedLat, _selectedLng));
  }

  void onAddressTextChanged(String newText) async {
    List<Location> locations = await locationFromAddress(newText);
    final locationFirst = locations.first;
    _getAddress(await placemarkFromCoordinates(locationFirst.latitude, locationFirst.longitude));
  }

  void onNavigateUp() {
    Get.back(result: _selectedPlaceMark);
  }

  void onSetSelectedPlaceMark(Placemark placemark) {
    _selectedPlaceMark = placemark;
    _updateAddressText();
  }

  /// Internal methods.

  void _getAddress(List<Placemark> foundPlaceMarks) {
    final places = foundPlaceMarks;
    _placeMarks.clear();
    _placeMarks.addAll(places);

    update();
  }

  void _updateAddressText() {
    addressText.text = _selectedPlaceMark!.toReadableAddress();
    update();
  }

}
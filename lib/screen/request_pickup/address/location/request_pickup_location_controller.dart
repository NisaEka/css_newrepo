import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/ext/placement_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestPickupLocationController extends BaseController {

  double _selectedLat = 0.0;
  double get selectedLat => _selectedLat;

  double _selectedLng = 0.0;
  double get selectedLng => _selectedLng;

  List<Placemark> _placeMarks = [];
  List<Placemark> get placeMarks => _placeMarks;

  TextEditingController addressText = TextEditingController();

  void onCameraMove(LatLng latLng) {
    _selectedLat = latLng.latitude;
    _selectedLng = latLng.longitude;
  }

  void onCameraIdle() {
    _getAddress();
  }

  void onAddressTextChanged(String newText) {

  }

  /// Internal methods.

  void _getAddress() async {
    final places = await placemarkFromCoordinates(_selectedLat, _selectedLng);
    _placeMarks.clear();
    _placeMarks.addAll(places);

    final firstPlace = places.first;
    addressText.text = firstPlace.toReadableAddress();
    update();
  }

}
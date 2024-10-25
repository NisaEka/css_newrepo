import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/ext/placement_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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

  bool _contentReady = false;
  bool get contentReady => _contentReady;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initializeCurrentLocation()]);
  }

  Future<void> initializeCurrentLocation() async {
    _getCurrentLocation().then((coordinate) {
      _selectedLat = coordinate.latitude;
      _selectedLng = coordinate.longitude;

      _contentReady = true;
      update();
    }).catchError((error) {
      _selectedLat = -6.9506528;
      _selectedLng = 107.6234307;

      _contentReady = true;
      update();
    });
  }

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
    _getAddress(await placemarkFromCoordinates(
        locationFirst.latitude, locationFirst.longitude));
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

  Future<LatLng> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}

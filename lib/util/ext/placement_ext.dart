import 'package:geocoding/geocoding.dart';

extension PlacementExt on Placemark {
  String toReadableAddress() {
    final addressBuffer = StringBuffer();

    if (street != null) {
      addressBuffer.write(street);
      addressBuffer.write(', ');
    }

    if (subLocality != null) {
      addressBuffer.write(subLocality);
      addressBuffer.write(', ');
    }

    if (locality != null) {
      addressBuffer.write(locality);
      addressBuffer.write(', ');
    }

    if (subAdministrativeArea != null) {
      addressBuffer.write(subAdministrativeArea);
      addressBuffer.write(', ');
    }

    if (administrativeArea != null) {
      addressBuffer.write(administrativeArea);
      addressBuffer.write(', ');
    }

    if (postalCode != null) {
      addressBuffer.write(postalCode);
    }

    return addressBuffer.toString();
  }
}

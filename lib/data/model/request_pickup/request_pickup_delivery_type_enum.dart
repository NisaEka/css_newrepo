enum RequestPickupDeliveryType { semuaTipeKiriman, cod, nonCod, codOngkir }

extension RequestPickupDeliveryTypeExt on RequestPickupDeliveryType {
  String asName() {
    String result = "";

    switch (this) {
      case RequestPickupDeliveryType.semuaTipeKiriman:
        result = "Semua Tipe Kiriman";
        break;
      case RequestPickupDeliveryType.cod:
        result = "COD";
        break;
      case RequestPickupDeliveryType.nonCod:
        result = "Non COD";
        break;
      case RequestPickupDeliveryType.codOngkir:
        result = "COD Ongkir";
        break;
      default:
        result = "Tidak Diketahui";
        break;
    }

    return result;
  }
}

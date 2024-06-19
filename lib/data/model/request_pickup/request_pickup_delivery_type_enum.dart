enum RequestPickupDeliveryType {
  semua_tipe_kiriman,
  cod,
  non_cod,
  cod_ongkir
}

extension RequestPickupDeliveryTypeExt on RequestPickupDeliveryType {

  String asName() {
    String result = "";

    switch (this) {
      case RequestPickupDeliveryType.semua_tipe_kiriman:
        result = "Semua Tipe Kiriman";
        break;
      case RequestPickupDeliveryType.cod:
        result = "COD";
        break;
      case RequestPickupDeliveryType.non_cod:
        result = "Non COD";
        break;
      case RequestPickupDeliveryType.cod_ongkir:
        result = "COD Ongkir";
        break;
      default:
        result = "Tidak Diketahui";
        break;
    }

    return result;
  }

}
enum RequestPickupDateEnum {
  all,
  one_month,
  one_week,
  today,
  custom
}

extension RequestPickupDateEnumExt on RequestPickupDateEnum {

  String asName() {
    String result = "";

    switch (this) {
      case RequestPickupDateEnum.all:
        result = "SEMUA TANGGAL";
        break;
      case RequestPickupDateEnum.one_month:
        result = "1 BULAN TERAKHIR";
        break;
      case RequestPickupDateEnum.one_week:
        result = "1 MINGGU TERAKHIR";
        break;
      case RequestPickupDateEnum.today:
        result = "HARI INI";
        break;
      case RequestPickupDateEnum.custom:
        result = "PILIH TANGGAL SENDIRI";
        break;
      default:
        result = "SEMUA TANGGAL";
        break;
    }

    return result;
  }

}
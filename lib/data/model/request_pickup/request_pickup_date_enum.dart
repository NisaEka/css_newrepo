enum RequestPickupDateEnum {
  all,
  oneMonth,
  oneWeek,
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
      case RequestPickupDateEnum.oneMonth:
        result = "1 BULAN TERAKHIR";
        break;
      case RequestPickupDateEnum.oneWeek:
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
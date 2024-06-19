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
        result = "Semua Tanggal";
        break;
      case RequestPickupDateEnum.one_month:
        result = "1 Bulan Terakhir";
        break;
      case RequestPickupDateEnum.one_week:
        result = "1 Minggu Terakhir";
        break;
      case RequestPickupDateEnum.today:
        result = "Hari Ini";
        break;
      case RequestPickupDateEnum.custom:
        result = "Pilih Tanggal Sendiri";
        break;
      default:
        result = "Tidak Diketahui";
        break;
    }

    return result;
  }

}
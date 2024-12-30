enum DateFilterEnum { all, oneMonth, oneWeek, today, custom, yesterday }

extension RequestPickupDateEnumExt on DateFilterEnum {
  String asName() {
    String result = "";

    switch (this) {
      case DateFilterEnum.all:
        result = "SEMUA TANGGAL";
        break;
      case DateFilterEnum.oneMonth:
        result = "1 BULAN TERAKHIR";
        break;
      case DateFilterEnum.oneWeek:
        result = "1 MINGGU TERAKHIR";
        break;
      case DateFilterEnum.today:
        result = "HARI INI";
        break;
      case DateFilterEnum.yesterday:
        result = "Kemarin";
        break;
      case DateFilterEnum.custom:
        result = "PILIH TANGGAL SENDIRI";
        break;
      default:
        result = "SEMUA TANGGAL";
        break;
    }

    return result;
  }
}

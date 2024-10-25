enum RequestPickupStatus {
  semua,
  belumMintaDijemput,
  sudahMintaDijemput,
  gagalDijemput,
  berhasilDijemput
}

extension RequestPickupExt on RequestPickupStatus {
  String asName() {
    String result = "";

    switch (this) {
      case RequestPickupStatus.semua:
        result = "Semua Status";
        break;
      case RequestPickupStatus.belumMintaDijemput:
        result = "Belum Minta di Jemput";
        break;
      case RequestPickupStatus.sudahMintaDijemput:
        result = "Sudah Minta di Jemput";
        break;
      case RequestPickupStatus.gagalDijemput:
        result = "Gagal di Jemput";
        break;
      case RequestPickupStatus.berhasilDijemput:
        result = "Berhasil di Jemput";
        break;
      default:
        result = "Tidak Diketahui";
        break;
    }

    return result;
  }
}

enum RequestPickupStatus {
  semua,
  belum_minta_dijemput,
  sudah_minta_dijemput,
  gagal_dijemput,
  berhasil_dijemput
}

extension RequestPickupExt on RequestPickupStatus {
  String asName() {
    String result = "";

    switch (this) {
      case RequestPickupStatus.semua:
        result = "Semua Status";
        break;
      case RequestPickupStatus.belum_minta_dijemput:
        result = "Belum Minta di Jemput";
        break;
      case RequestPickupStatus.sudah_minta_dijemput:
        result = "Sudah Minta di Jemput";
        break;
      case RequestPickupStatus.gagal_dijemput:
        result = "Gagal di Jemput";
        break;
      case RequestPickupStatus.berhasil_dijemput:
        result = "Berhasil di Jemput";
        break;
      default:
        result = "Tidak Diketahui";
        break;
    }

    return result;
  }
}

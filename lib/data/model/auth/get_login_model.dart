class LoginModel {
  LoginModel({
    num? code,
    String? message,
    Payload? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  LoginModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  Payload? _payload;

  LoginModel copyWith({
    num? code,
    String? message,
    Payload? payload,
  }) =>
      LoginModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  Payload? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }
}

class Payload {
  Payload({
    AllowedMenu? allowedMenu,
    String? token,
  }) {
    _allowedMenu = allowedMenu;
    _token = token;
  }

  Payload.fromJson(dynamic json) {
    _allowedMenu = json['allowed_menu'] != null ? AllowedMenu.fromJson(json['allowed_menu']) : null;
    _token = json['token'];
  }

  AllowedMenu? _allowedMenu;
  String? _token;

  Payload copyWith({
    AllowedMenu? allowedMenu,
    String? token,
  }) =>
      Payload(
        allowedMenu: allowedMenu ?? _allowedMenu,
        token: token ?? _token,
      );

  AllowedMenu? get allowedMenu => _allowedMenu;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_allowedMenu != null) {
      map['allowed_menu'] = _allowedMenu?.toJson();
    }
    map['token'] = _token;
    return map;
  }
}

class AllowedMenu {
  AllowedMenu({
    String? profil,
    String? fasilitas,
    String? katasandi,
    String? semuaTransaksi,
    String? semuaHapus,
    String? hapusPesanan,
    String? beranda,
    String? paketmuInput,
    String? paketmuRiwayat,
    String? paketmuLacak,
    String? paketmuMintaDijemput,
    String? paketmuSerahTerima,
    String? paketmuPrint,
    String? keuanganJneMoney,
    String? keuanganCod,
    String? keuanganAggregasi,
    String? keuanganAggregasiMinus,
    String? keuanganTagihan,
    String? keuanganBonus,
    String? pantauPaketmu,
    String? hubungiLaporan,
    String? hubungiEclaim,
    String? laporanReturn,
    String? laporanSummaryOrigin,
    String? laporanSummaryDestination,
    String? cekOngkir,
    String? dukunganTeknis,
    String? pengaturanTema,
    String? pengaturanLabel,
    String? pengaturanPetugas,
  }) {
    _profil = profil;
    _fasilitas = fasilitas;
    _katasandi = katasandi;
    _semuaTransaksi = semuaTransaksi;
    _semuaHapus = semuaHapus;
    _hapusPesanan = hapusPesanan;
    _beranda = beranda;
    _paketmuInput = paketmuInput;
    _paketmuRiwayat = paketmuRiwayat;
    _paketmuLacak = paketmuLacak;
    _paketmuMintaDijemput = paketmuMintaDijemput;
    _paketmuSerahTerima = paketmuSerahTerima;
    _paketmuPrint = paketmuPrint;
    _keuanganJneMoney = keuanganJneMoney;
    _keuanganCod = keuanganCod;
    _keuanganAggregasi = keuanganAggregasi;
    _keuanganAggregasiMinus = keuanganAggregasiMinus;
    _keuanganTagihan = keuanganTagihan;
    _keuanganBonus = keuanganBonus;
    _pantauPaketmu = pantauPaketmu;
    _hubungiLaporan = hubungiLaporan;
    _hubungiEclaim = hubungiEclaim;
    _laporanReturn = laporanReturn;
    _laporanSummaryOrigin = laporanSummaryOrigin;
    _laporanSummaryDestination = laporanSummaryDestination;
    _cekOngkir = cekOngkir;
    _dukunganTeknis = dukunganTeknis;
    _pengaturanTema = pengaturanTema;
    _pengaturanLabel = pengaturanLabel;
    _pengaturanPetugas = pengaturanPetugas;
  }

  AllowedMenu.fromJson(dynamic json) {
    _profil = json['profil'];
    _fasilitas = json['fasilitas'];
    _katasandi = json['katasandi'];
    _semuaTransaksi = json['semua_transaksi'];
    _semuaHapus = json['semua_hapus'];
    _hapusPesanan = json['hapus_pesanan'];
    _beranda = json['beranda'];
    _paketmuInput = json['paketmu_input'];
    _paketmuRiwayat = json['paketmu_riwayat'];
    _paketmuLacak = json['paketmu_lacak'];
    _paketmuMintaDijemput = json['paketmu_minta_dijemput'];
    _paketmuSerahTerima = json['paketmu_serah_terima'];
    _paketmuPrint = json['paketmu_print'];
    _keuanganJneMoney = json['keuangan_jne_money'];
    _keuanganCod = json['keuangan_cod'];
    _keuanganAggregasi = json['keuangan_aggregasi'];
    _keuanganAggregasiMinus = json['keuangan_aggregasi_minus'];
    _keuanganTagihan = json['keuangan_tagihan'];
    _keuanganBonus = json['keuangan_bonus'];
    _pantauPaketmu = json['pantau_paketmu'];
    _hubungiLaporan = json['hubungi_laporan'];
    _hubungiEclaim = json['hubungi_eclaim'];
    _laporanReturn = json['laporan_return'];
    _laporanSummaryOrigin = json['laporan_summary_origin'];
    _laporanSummaryDestination = json['laporan_summary_destination'];
    _cekOngkir = json['cek_ongkir'];
    _dukunganTeknis = json['dukungan_teknis'];
    _pengaturanTema = json['pengaturan_tema'];
    _pengaturanLabel = json['pengaturan_label'];
    _pengaturanPetugas = json['pengaturan_petugas'];
  }

  String? _profil;
  String? _fasilitas;
  String? _katasandi;
  String? _semuaTransaksi;
  String? _semuaHapus;
  String? _hapusPesanan;
  String? _beranda;
  String? _paketmuInput;
  String? _paketmuRiwayat;
  String? _paketmuLacak;
  String? _paketmuMintaDijemput;
  String? _paketmuSerahTerima;
  String? _paketmuPrint;
  String? _keuanganJneMoney;
  String? _keuanganCod;
  String? _keuanganAggregasi;
  String? _keuanganAggregasiMinus;
  String? _keuanganTagihan;
  String? _keuanganBonus;
  String? _pantauPaketmu;
  String? _hubungiLaporan;
  String? _hubungiEclaim;
  String? _laporanReturn;
  String? _laporanSummaryOrigin;
  String? _laporanSummaryDestination;
  String? _cekOngkir;
  String? _dukunganTeknis;
  String? _pengaturanTema;
  String? _pengaturanLabel;
  String? _pengaturanPetugas;

  AllowedMenu copyWith({
    String? profil,
    String? fasilitas,
    String? katasandi,
    String? semuaTransaksi,
    String? semuaHapus,
    String? hapusPesanan,
    String? beranda,
    String? paketmuInput,
    String? paketmuRiwayat,
    String? paketmuLacak,
    String? paketmuMintaDijemput,
    String? paketmuSerahTerima,
    String? paketmuPrint,
    String? keuanganJneMoney,
    String? keuanganCod,
    String? keuanganAggregasi,
    String? keuanganAggregasiMinus,
    String? keuanganTagihan,
    String? keuanganBonus,
    String? pantauPaketmu,
    String? hubungiLaporan,
    String? hubungiEclaim,
    String? laporanReturn,
    String? laporanSummaryOrigin,
    String? laporanSummaryDestination,
    String? cekOngkir,
    String? dukunganTeknis,
    String? pengaturanTema,
    String? pengaturanLabel,
    String? pengaturanPetugas,
  }) =>
      AllowedMenu(
        profil: profil ?? _profil,
        fasilitas: fasilitas ?? _fasilitas,
        katasandi: katasandi ?? _katasandi,
        semuaTransaksi: semuaTransaksi ?? _semuaTransaksi,
        semuaHapus: semuaHapus ?? _semuaHapus,
        hapusPesanan: hapusPesanan ?? _hapusPesanan,
        beranda: beranda ?? _beranda,
        paketmuInput: paketmuInput ?? _paketmuInput,
        paketmuRiwayat: paketmuRiwayat ?? _paketmuRiwayat,
        paketmuLacak: paketmuLacak ?? _paketmuLacak,
        paketmuMintaDijemput: paketmuMintaDijemput ?? _paketmuMintaDijemput,
        paketmuSerahTerima: paketmuSerahTerima ?? _paketmuSerahTerima,
        paketmuPrint: paketmuPrint ?? _paketmuPrint,
        keuanganJneMoney: keuanganJneMoney ?? _keuanganJneMoney,
        keuanganCod: keuanganCod ?? _keuanganCod,
        keuanganAggregasi: keuanganAggregasi ?? _keuanganAggregasi,
        keuanganAggregasiMinus: keuanganAggregasiMinus ?? _keuanganAggregasiMinus,
        keuanganTagihan: keuanganTagihan ?? _keuanganTagihan,
        keuanganBonus: keuanganBonus ?? _keuanganBonus,
        pantauPaketmu: pantauPaketmu ?? _pantauPaketmu,
        hubungiLaporan: hubungiLaporan ?? _hubungiLaporan,
        hubungiEclaim: hubungiEclaim ?? _hubungiEclaim,
        laporanReturn: laporanReturn ?? _laporanReturn,
        laporanSummaryOrigin: laporanSummaryOrigin ?? _laporanSummaryOrigin,
        laporanSummaryDestination: laporanSummaryDestination ?? _laporanSummaryDestination,
        cekOngkir: cekOngkir ?? _cekOngkir,
        dukunganTeknis: dukunganTeknis ?? _dukunganTeknis,
        pengaturanTema: pengaturanTema ?? _pengaturanTema,
        pengaturanLabel: pengaturanLabel ?? _pengaturanLabel,
        pengaturanPetugas: pengaturanPetugas ?? _pengaturanPetugas,
      );

  String? get profil => _profil;

  String? get fasilitas => _fasilitas;

  String? get katasandi => _katasandi;

  String? get semuaTransaksi => _semuaTransaksi;

  String? get semuaHapus => _semuaHapus;

  String? get hapusPesanan => _hapusPesanan;

  String? get beranda => _beranda;

  String? get paketmuInput => _paketmuInput;

  String? get paketmuRiwayat => _paketmuRiwayat;

  String? get paketmuLacak => _paketmuLacak;

  String? get paketmuMintaDijemput => _paketmuMintaDijemput;

  String? get paketmuSerahTerima => _paketmuSerahTerima;

  String? get paketmuPrint => _paketmuPrint;

  String? get keuanganJneMoney => _keuanganJneMoney;

  String? get keuanganCod => _keuanganCod;

  String? get keuanganAggregasi => _keuanganAggregasi;

  String? get keuanganAggregasiMinus => _keuanganAggregasiMinus;

  String? get keuanganTagihan => _keuanganTagihan;

  String? get keuanganBonus => _keuanganBonus;

  String? get pantauPaketmu => _pantauPaketmu;

  String? get hubungiLaporan => _hubungiLaporan;

  String? get hubungiEclaim => _hubungiEclaim;

  String? get laporanReturn => _laporanReturn;

  String? get laporanSummaryOrigin => _laporanSummaryOrigin;

  String? get laporanSummaryDestination => _laporanSummaryDestination;

  String? get cekOngkir => _cekOngkir;

  String? get dukunganTeknis => _dukunganTeknis;

  String? get pengaturanTema => _pengaturanTema;

  String? get pengaturanLabel => _pengaturanLabel;

  String? get pengaturanPetugas => _pengaturanPetugas;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profil'] = _profil;
    map['fasilitas'] = _fasilitas;
    map['katasandi'] = _katasandi;
    map['semua_transaksi'] = _semuaTransaksi;
    map['semua_hapus'] = _semuaHapus;
    map['hapus_pesanan'] = _hapusPesanan;
    map['beranda'] = _beranda;
    map['paketmu_input'] = _paketmuInput;
    map['paketmu_riwayat'] = _paketmuRiwayat;
    map['paketmu_lacak'] = _paketmuLacak;
    map['paketmu_minta_dijemput'] = _paketmuMintaDijemput;
    map['paketmu_serah_terima'] = _paketmuSerahTerima;
    map['paketmu_print'] = _paketmuPrint;
    map['keuangan_jne_money'] = _keuanganJneMoney;
    map['keuangan_cod'] = _keuanganCod;
    map['keuangan_aggregasi'] = _keuanganAggregasi;
    map['keuangan_aggregasi_minus'] = _keuanganAggregasiMinus;
    map['keuangan_tagihan'] = _keuanganTagihan;
    map['keuangan_bonus'] = _keuanganBonus;
    map['pantau_paketmu'] = _pantauPaketmu;
    map['hubungi_laporan'] = _hubungiLaporan;
    map['hubungi_eclaim'] = _hubungiEclaim;
    map['laporan_return'] = _laporanReturn;
    map['laporan_summary_origin'] = _laporanSummaryOrigin;
    map['laporan_summary_destination'] = _laporanSummaryDestination;
    map['cek_ongkir'] = _cekOngkir;
    map['dukungan_teknis'] = _dukunganTeknis;
    map['pengaturan_tema'] = _pengaturanTema;
    map['pengaturan_label'] = _pengaturanLabel;
    map['pengaturan_petugas'] = _pengaturanPetugas;
    return map;
  }
}

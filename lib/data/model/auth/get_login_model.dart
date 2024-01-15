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
    String? beranda,
    String? buatPesanan,
    String? lacakPesanan,
    String? mintaDijemput,
    String? serahTerima,
    String? saldo,
    String? uangCod,
    String? tagihan,
    String? bonus,
    String? pantauPaketmu,
    String? laporan,
    String? eclaim,
    String? tema,
    String? label,
    String? petugas,
    String? riwayatPesanan,
    String? cekOngkir,
    String? semuaTransaksi,
    String? hapusPesanan,
    String? semuaHapus,
    String? cetakPesanan,
    String? monitoringAgg,
    String? monitoringAggMinus,
  }) {
    _profil = profil;
    _fasilitas = fasilitas;
    _katasandi = katasandi;
    _beranda = beranda;
    _buatPesanan = buatPesanan;
    _lacakPesanan = lacakPesanan;
    _mintaDijemput = mintaDijemput;
    _serahTerima = serahTerima;
    _saldo = saldo;
    _uangCod = uangCod;
    _tagihan = tagihan;
    _bonus = bonus;
    _pantauPaketmu = pantauPaketmu;
    _laporan = laporan;
    _eclaim = eclaim;
    _tema = tema;
    _label = label;
    _petugas = petugas;
    _riwayatPesanan = riwayatPesanan;
    _cekOngkir = cekOngkir;
    _semuaTransaksi = semuaTransaksi;
    _hapusPesanan = hapusPesanan;
    _semuaHapus = semuaHapus;
    _cetakPesanan = cetakPesanan;
    _monitoringAgg = monitoringAgg;
    _monitoringAggMinus = monitoringAggMinus;
  }

  AllowedMenu.fromJson(dynamic json) {
    _profil = json['profil'];
    _fasilitas = json['fasilitas'];
    _katasandi = json['katasandi'];
    _beranda = json['beranda'];
    _buatPesanan = json['buat_pesanan'];
    _lacakPesanan = json['lacak_pesanan'];
    _mintaDijemput = json['minta_dijemput'];
    _serahTerima = json['serah_terima'];
    _saldo = json['saldo'];
    _uangCod = json['uang_cod'];
    _tagihan = json['tagihan'];
    _bonus = json['bonus'];
    _pantauPaketmu = json['pantau_paketmu'];
    _laporan = json['laporan'];
    _eclaim = json['eclaim'];
    _tema = json['tema'];
    _label = json['label'];
    _petugas = json['petugas'];
    _riwayatPesanan = json['riwayat_pesanan'];
    _cekOngkir = json['cek_ongkir'];
    _semuaTransaksi = json['semua_transaksi'];
    _hapusPesanan = json['hapus_pesanan'];
    _semuaHapus = json['semua_hapus'];
    _cetakPesanan = json['cetak_pesanan'];
    _monitoringAgg = json['monitoring_agg'];
    _monitoringAggMinus = json['monitoring_agg_minus'];
  }

  String? _profil;
  String? _fasilitas;
  String? _katasandi;
  String? _beranda;
  String? _buatPesanan;
  String? _lacakPesanan;
  String? _mintaDijemput;
  String? _serahTerima;
  String? _saldo;
  String? _uangCod;
  String? _tagihan;
  String? _bonus;
  String? _pantauPaketmu;
  String? _laporan;
  String? _eclaim;
  String? _tema;
  String? _label;
  String? _petugas;
  String? _riwayatPesanan;
  String? _cekOngkir;
  String? _semuaTransaksi;
  String? _hapusPesanan;
  String? _semuaHapus;
  String? _cetakPesanan;
  String? _monitoringAgg;
  String? _monitoringAggMinus;

  AllowedMenu copyWith({
    String? profil,
    String? fasilitas,
    String? katasandi,
    String? beranda,
    String? buatPesanan,
    String? lacakPesanan,
    String? mintaDijemput,
    String? serahTerima,
    String? saldo,
    String? uangCod,
    String? tagihan,
    String? bonus,
    String? pantauPaketmu,
    String? laporan,
    String? eclaim,
    String? tema,
    String? label,
    String? petugas,
    String? riwayatPesanan,
    String? cekOngkir,
    String? semuaTransaksi,
    String? hapusPesanan,
    String? semuaHapus,
    String? cetakPesanan,
    String? monitoringAgg,
    String? monitoringAggMinus,
  }) =>
      AllowedMenu(
        profil: profil ?? _profil,
        fasilitas: fasilitas ?? _fasilitas,
        katasandi: katasandi ?? _katasandi,
        beranda: beranda ?? _beranda,
        buatPesanan: buatPesanan ?? _buatPesanan,
        lacakPesanan: lacakPesanan ?? _lacakPesanan,
        mintaDijemput: mintaDijemput ?? _mintaDijemput,
        serahTerima: serahTerima ?? _serahTerima,
        saldo: saldo ?? _saldo,
        uangCod: uangCod ?? _uangCod,
        tagihan: tagihan ?? _tagihan,
        bonus: bonus ?? _bonus,
        pantauPaketmu: pantauPaketmu ?? _pantauPaketmu,
        laporan: laporan ?? _laporan,
        eclaim: eclaim ?? _eclaim,
        tema: tema ?? _tema,
        label: label ?? _label,
        petugas: petugas ?? _petugas,
        riwayatPesanan: riwayatPesanan ?? _riwayatPesanan,
        cekOngkir: cekOngkir ?? _cekOngkir,
        semuaTransaksi: semuaTransaksi ?? _semuaTransaksi,
        hapusPesanan: hapusPesanan ?? _hapusPesanan,
        semuaHapus: semuaHapus ?? _semuaHapus,
        cetakPesanan: cetakPesanan ?? _cetakPesanan,
        monitoringAgg: monitoringAgg ?? _monitoringAgg,
        monitoringAggMinus: monitoringAggMinus ?? _monitoringAggMinus,
      );

  String? get profil => _profil;

  String? get fasilitas => _fasilitas;

  String? get katasandi => _katasandi;

  String? get beranda => _beranda;

  String? get buatPesanan => _buatPesanan;

  String? get lacakPesanan => _lacakPesanan;

  String? get mintaDijemput => _mintaDijemput;

  String? get serahTerima => _serahTerima;

  String? get saldo => _saldo;

  String? get uangCod => _uangCod;

  String? get tagihan => _tagihan;

  String? get bonus => _bonus;

  String? get pantauPaketmu => _pantauPaketmu;

  String? get laporan => _laporan;

  String? get eclaim => _eclaim;

  String? get tema => _tema;

  String? get label => _label;

  String? get petugas => _petugas;

  String? get riwayatPesanan => _riwayatPesanan;

  String? get cekOngkir => _cekOngkir;

  String? get semuaTransaksi => _semuaTransaksi;

  String? get hapusPesanan => _hapusPesanan;

  String? get semuaHapus => _semuaHapus;

  String? get cetakPesanan => _cetakPesanan;

  String? get monitoringAgg => _monitoringAgg;

  String? get monitoringAggMinus => _monitoringAggMinus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profil'] = _profil;
    map['fasilitas'] = _fasilitas;
    map['katasandi'] = _katasandi;
    map['beranda'] = _beranda;
    map['buat_pesanan'] = _buatPesanan;
    map['lacak_pesanan'] = _lacakPesanan;
    map['minta_dijemput'] = _mintaDijemput;
    map['serah_terima'] = _serahTerima;
    map['saldo'] = _saldo;
    map['uang_cod'] = _uangCod;
    map['tagihan'] = _tagihan;
    map['bonus'] = _bonus;
    map['pantau_paketmu'] = _pantauPaketmu;
    map['laporan'] = _laporan;
    map['eclaim'] = _eclaim;
    map['tema'] = _tema;
    map['label'] = _label;
    map['petugas'] = _petugas;
    map['riwayat_pesanan'] = _riwayatPesanan;
    map['cek_ongkir'] = _cekOngkir;
    map['semua_transaksi'] = _semuaTransaksi;
    map['hapus_pesanan'] = _hapusPesanan;
    map['semua_hapus'] = _semuaHapus;
    map['cetak_pesanan'] = _cetakPesanan;
    map['monitoring_agg'] = _monitoringAgg;
    map['monitoring_agg_minus'] = _monitoringAggMinus;
    return map;
  }
}

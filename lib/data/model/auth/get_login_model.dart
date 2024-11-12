class GetLoginModel {
  GetLoginModel({
    num? code,
    String? message,
    Payload? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetLoginModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  Payload? _payload;

  GetLoginModel copyWith({
    num? code,
    String? message,
    Payload? payload,
  }) =>
      GetLoginModel(
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
    _allowedMenu = json['allowed_menu'] != null
        ? AllowedMenu.fromJson(json['allowed_menu'])
        : null;
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
    String? dashReferralTrans,
    String? dashReferralDseller,
    String? dashReferralSeller,
    String? groupOwner,
    String? laporanReturn,
    String? summaryOrigin,
    String? summaryDestination,
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
    String? hubungiLaporan,
    String? hubungiEclaim,
    String? laporanSummaryOrigin,
    String? laporanSummaryDestination,
    String? dukunganTeknis,
    String? pengaturanTema,
    String? pengaturanLabel,
    String? pengaturanPetugas,
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
    _dashReferralTrans = dashReferralTrans;
    _dashReferralDseller = dashReferralDseller;
    _dashReferralSeller = dashReferralSeller;
    _groupOwner = groupOwner;
    _laporanReturn = laporanReturn;
    _summaryOrigin = summaryOrigin;
    _summaryDestination = summaryDestination;
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
    _hubungiLaporan = hubungiLaporan;
    _hubungiEclaim = hubungiEclaim;
    _laporanSummaryOrigin = laporanSummaryOrigin;
    _laporanSummaryDestination = laporanSummaryDestination;
    _dukunganTeknis = dukunganTeknis;
    _pengaturanTema = pengaturanTema;
    _pengaturanLabel = pengaturanLabel;
    _pengaturanPetugas = pengaturanPetugas;
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
    _dashReferralTrans = json['dash_referral_trans'];
    _dashReferralDseller = json['dash_referral_dseller'];
    _dashReferralSeller = json['dash_referral_seller'];
    _groupOwner = json['group_owner'];
    _laporanReturn = json['laporan_return'];
    _summaryOrigin = json['summary_origin'];
    _summaryDestination = json['summary_destination'];
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
    _hubungiLaporan = json['hubungi_laporan'];
    _hubungiEclaim = json['hubungi_eclaim'];
    _laporanSummaryOrigin = json['laporan_summary_origin'];
    _laporanSummaryDestination = json['laporan_summary_destination'];
    _dukunganTeknis = json['dukungan_teknis'];
    _pengaturanTema = json['pengaturan_tema'];
    _pengaturanLabel = json['pengaturan_label'];
    _pengaturanPetugas = json['pengaturan_petugas'];
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
  String? _dashReferralTrans;
  String? _dashReferralDseller;
  String? _dashReferralSeller;
  String? _groupOwner;
  String? _laporanReturn;
  String? _summaryOrigin;
  String? _summaryDestination;
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
  String? _hubungiLaporan;
  String? _hubungiEclaim;
  String? _laporanSummaryOrigin;
  String? _laporanSummaryDestination;
  String? _dukunganTeknis;
  String? _pengaturanTema;
  String? _pengaturanLabel;
  String? _pengaturanPetugas;

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
    String? dashReferralTrans,
    String? dashReferralDseller,
    String? dashReferralSeller,
    String? groupOwner,
    String? laporanReturn,
    String? summaryOrigin,
    String? summaryDestination,
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
    String? hubungiLaporan,
    String? hubungiEclaim,
    String? laporanSummaryOrigin,
    String? laporanSummaryDestination,
    String? dukunganTeknis,
    String? pengaturanTema,
    String? pengaturanLabel,
    String? pengaturanPetugas,
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
        dashReferralTrans: dashReferralTrans ?? _dashReferralTrans,
        dashReferralDseller: dashReferralDseller ?? _dashReferralDseller,
        dashReferralSeller: dashReferralSeller ?? _dashReferralSeller,
        groupOwner: groupOwner ?? _groupOwner,
        laporanReturn: laporanReturn ?? _laporanReturn,
        summaryOrigin: summaryOrigin ?? _summaryOrigin,
        summaryDestination: summaryDestination ?? _summaryDestination,
        paketmuInput: paketmuInput ?? _paketmuInput,
        paketmuRiwayat: paketmuRiwayat ?? _paketmuRiwayat,
        paketmuLacak: paketmuLacak ?? _paketmuLacak,
        paketmuMintaDijemput: paketmuMintaDijemput ?? _paketmuMintaDijemput,
        paketmuSerahTerima: paketmuSerahTerima ?? _paketmuSerahTerima,
        paketmuPrint: paketmuPrint ?? _paketmuPrint,
        keuanganJneMoney: keuanganJneMoney ?? _keuanganJneMoney,
        keuanganCod: keuanganCod ?? _keuanganCod,
        keuanganAggregasi: keuanganAggregasi ?? _keuanganAggregasi,
        keuanganAggregasiMinus:
            keuanganAggregasiMinus ?? _keuanganAggregasiMinus,
        keuanganTagihan: keuanganTagihan ?? _keuanganTagihan,
        keuanganBonus: keuanganBonus ?? _keuanganBonus,
        hubungiLaporan: hubungiLaporan ?? _hubungiLaporan,
        hubungiEclaim: hubungiEclaim ?? _hubungiEclaim,
        laporanSummaryOrigin: laporanSummaryOrigin ?? _laporanSummaryOrigin,
        laporanSummaryDestination:
            laporanSummaryDestination ?? _laporanSummaryDestination,
        dukunganTeknis: dukunganTeknis ?? _dukunganTeknis,
        pengaturanTema: pengaturanTema ?? _pengaturanTema,
        pengaturanLabel: pengaturanLabel ?? _pengaturanLabel,
        pengaturanPetugas: pengaturanPetugas ?? _pengaturanPetugas,
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

  String? get dashReferralTrans => _dashReferralTrans;

  String? get dashReferralDseller => _dashReferralDseller;

  String? get dashReferralSeller => _dashReferralSeller;

  String? get groupOwner => _groupOwner;

  String? get laporanReturn => _laporanReturn;

  String? get summaryOrigin => _summaryOrigin;

  String? get summaryDestination => _summaryDestination;

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

  String? get hubungiLaporan => _hubungiLaporan;

  String? get hubungiEclaim => _hubungiEclaim;

  String? get laporanSummaryOrigin => _laporanSummaryOrigin;

  String? get laporanSummaryDestination => _laporanSummaryDestination;

  String? get dukunganTeknis => _dukunganTeknis;

  String? get pengaturanTema => _pengaturanTema;

  String? get pengaturanLabel => _pengaturanLabel;

  String? get pengaturanPetugas => _pengaturanPetugas;

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
    map['dash_referral_trans'] = _dashReferralTrans;
    map['dash_referral_dseller'] = _dashReferralDseller;
    map['dash_referral_seller'] = _dashReferralSeller;
    map['group_owner'] = _groupOwner;
    map['laporan_return'] = _laporanReturn;
    map['summary_origin'] = _summaryOrigin;
    map['summary_destination'] = _summaryDestination;
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
    map['hubungi_laporan'] = _hubungiLaporan;
    map['hubungi_eclaim'] = _hubungiEclaim;
    map['laporan_summary_origin'] = _laporanSummaryOrigin;
    map['laporan_summary_destination'] = _laporanSummaryDestination;
    map['dukungan_teknis'] = _dukunganTeknis;
    map['pengaturan_tema'] = _pengaturanTema;
    map['pengaturan_label'] = _pengaturanLabel;
    map['pengaturan_petugas'] = _pengaturanPetugas;
    return map;
  }
}

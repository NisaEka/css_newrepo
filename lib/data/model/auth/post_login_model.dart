class PostLoginModel {
  PostLoginModel({
    Token? token,
    MenuModel? menu,
  }) {
    _token = token;
    _menu = menu;
  }

  PostLoginModel.fromJson(dynamic json) {
    _token = json['token'] != null ? Token.fromJson(json['token']) : null;
    _menu = json['menu'] != null ? MenuModel.fromJson(json['menu']) : null;
  }

  Token? _token;
  MenuModel? _menu;

  PostLoginModel copyWith({
    Token? token,
    MenuModel? menu,
  }) =>
      PostLoginModel(
        token: token ?? _token,
        menu: menu ?? _menu,
      );

  Token? get token => _token;

  MenuModel? get menu => _menu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_token != null) {
      map['token'] = _token?.toJson();
    }
    if (_menu != null) {
      map['menu'] = _menu?.toJson();
    }
    return map;
  }
}

class MenuModel {
  MenuModel({
    String? profil,
    String? fasilitas,
    String? katasandi,
    String? beranda,
    String? buatPesanan,
    String? riwayatPesanan,
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
    String? laporanReturn,
    String? summaryOrigin,
    String? summaryDestination,
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
    String? accountJlc,
    String? accountCod,
    String? accountNoncod,
    String? paketmuInput,
    String? paketmuRiwayat,
    String? paketmuLacak,
    String? paketmuMintadijemput,
    String? paketmuSerahterima,
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
    _riwayatPesanan = riwayatPesanan;
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
    _laporanReturn = laporanReturn;
    _summaryOrigin = summaryOrigin;
    _summaryDestination = summaryDestination;
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
    _accountJlc = accountJlc;
    _accountCod = accountCod;
    _accountNoncod = accountNoncod;
    _paketmuInput = paketmuInput;
    _paketmuRiwayat = paketmuRiwayat;
    _paketmuLacak = paketmuLacak;
    _paketmuMintadijemput = paketmuMintadijemput;
    _paketmuSerahterima = paketmuSerahterima;
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

  MenuModel.fromJson(dynamic json) {
    _profil = json['profil'];
    _fasilitas = json['fasilitas'];
    _katasandi = json['katasandi'];
    _beranda = json['beranda'];
    _buatPesanan = json['buatPesanan'];
    _riwayatPesanan = json['riwayatPesanan'];
    _lacakPesanan = json['lacakPesanan'];
    _mintaDijemput = json['mintaDijemput'];
    _serahTerima = json['serahTerima'];
    _saldo = json['saldo'];
    _uangCod = json['uangCod'];
    _tagihan = json['tagihan'];
    _bonus = json['bonus'];
    _pantauPaketmu = json['pantauPaketmu'];
    _laporan = json['laporan'];
    _eclaim = json['eclaim'];
    _tema = json['tema'];
    _label = json['label'];
    _petugas = json['petugas'];
    _laporanReturn = json['laporanReturn'];
    _summaryOrigin = json['summaryOrigin'];
    _summaryDestination = json['summaryDestination'];
    _cekOngkir = json['cekOngkir'];
    _semuaTransaksi = json['semuaTransaksi'];
    _hapusPesanan = json['hapusPesanan'];
    _semuaHapus = json['semuaHapus'];
    _cetakPesanan = json['cetakPesanan'];
    _monitoringAgg = json['monitoringAgg'];
    _monitoringAggMinus = json['monitoringAggMinus'];
    _dashReferralTrans = json['dashReferralTrans'];
    _dashReferralDseller = json['dashReferralDseller'];
    _dashReferralSeller = json['dashReferralSeller'];
    _accountJlc = json['accountJlc'];
    _accountCod = json['accountCod'];
    _accountNoncod = json['accountNoncod'];
    _paketmuInput = json['paketmuInput'];
    _paketmuRiwayat = json['paketmuRiwayat'];
    _paketmuLacak = json['paketmuLacak'];
    _paketmuMintadijemput = json['paketmuMintadijemput'];
    _paketmuSerahterima = json['paketmuSerahterima'];
    _paketmuPrint = json['paketmuPrint'];
    _keuanganJneMoney = json['keuanganJneMoney'];
    _keuanganCod = json['keuanganCod'];
    _keuanganAggregasi = json['keuanganAggregasi'];
    _keuanganAggregasiMinus = json['keuanganAggregasiMinus'];
    _keuanganTagihan = json['keuanganTagihan'];
    _keuanganBonus = json['keuanganBonus'];
    _hubungiLaporan = json['hubungiLaporan'];
    _hubungiEclaim = json['hubungiEclaim'];
    _laporanSummaryOrigin = json['laporanSummaryOrigin'];
    _laporanSummaryDestination = json['laporanSummaryDestination'];
    _dukunganTeknis = json['dukunganTeknis'];
    _pengaturanTema = json['pengaturanTema'];
    _pengaturanLabel = json['pengaturanLabel'];
    _pengaturanPetugas = json['pengaturanPetugas'];
  }

  String? _profil;
  String? _fasilitas;
  String? _katasandi;
  String? _beranda;
  String? _buatPesanan;
  String? _riwayatPesanan;
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
  String? _laporanReturn;
  String? _summaryOrigin;
  String? _summaryDestination;
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
  String? _accountJlc;
  String? _accountCod;
  String? _accountNoncod;
  String? _paketmuInput;
  String? _paketmuRiwayat;
  String? _paketmuLacak;
  String? _paketmuMintadijemput;
  String? _paketmuSerahterima;
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

  MenuModel copyWith({
    String? profil,
    String? fasilitas,
    String? katasandi,
    String? beranda,
    String? buatPesanan,
    String? riwayatPesanan,
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
    String? laporanReturn,
    String? summaryOrigin,
    String? summaryDestination,
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
    String? accountJlc,
    String? accountCod,
    String? accountNoncod,
    String? paketmuInput,
    String? paketmuRiwayat,
    String? paketmuLacak,
    String? paketmuMintadijemput,
    String? paketmuSerahterima,
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
      MenuModel(
        profil: profil ?? _profil,
        fasilitas: fasilitas ?? _fasilitas,
        katasandi: katasandi ?? _katasandi,
        beranda: beranda ?? _beranda,
        buatPesanan: buatPesanan ?? _buatPesanan,
        riwayatPesanan: riwayatPesanan ?? _riwayatPesanan,
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
        laporanReturn: laporanReturn ?? _laporanReturn,
        summaryOrigin: summaryOrigin ?? _summaryOrigin,
        summaryDestination: summaryDestination ?? _summaryDestination,
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
        accountJlc: accountJlc ?? _accountJlc,
        accountCod: accountCod ?? _accountCod,
        accountNoncod: accountNoncod ?? _accountNoncod,
        paketmuInput: paketmuInput ?? _paketmuInput,
        paketmuRiwayat: paketmuRiwayat ?? _paketmuRiwayat,
        paketmuLacak: paketmuLacak ?? _paketmuLacak,
        paketmuMintadijemput: paketmuMintadijemput ?? _paketmuMintadijemput,
        paketmuSerahterima: paketmuSerahterima ?? _paketmuSerahterima,
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

  String? get riwayatPesanan => _riwayatPesanan;

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

  String? get laporanReturn => _laporanReturn;

  String? get summaryOrigin => _summaryOrigin;

  String? get summaryDestination => _summaryDestination;

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

  String? get accountJlc => _accountJlc;

  String? get accountCod => _accountCod;

  String? get accountNoncod => _accountNoncod;

  String? get paketmuInput => _paketmuInput;

  String? get paketmuRiwayat => _paketmuRiwayat;

  String? get paketmuLacak => _paketmuLacak;

  String? get paketmuMintadijemput => _paketmuMintadijemput;

  String? get paketmuSerahterima => _paketmuSerahterima;

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
    map['buatPesanan'] = _buatPesanan;
    map['riwayatPesanan'] = _riwayatPesanan;
    map['lacakPesanan'] = _lacakPesanan;
    map['mintaDijemput'] = _mintaDijemput;
    map['serahTerima'] = _serahTerima;
    map['saldo'] = _saldo;
    map['uangCod'] = _uangCod;
    map['tagihan'] = _tagihan;
    map['bonus'] = _bonus;
    map['pantauPaketmu'] = _pantauPaketmu;
    map['laporan'] = _laporan;
    map['eclaim'] = _eclaim;
    map['tema'] = _tema;
    map['label'] = _label;
    map['petugas'] = _petugas;
    map['laporanReturn'] = _laporanReturn;
    map['summaryOrigin'] = _summaryOrigin;
    map['summaryDestination'] = _summaryDestination;
    map['cekOngkir'] = _cekOngkir;
    map['semuaTransaksi'] = _semuaTransaksi;
    map['hapusPesanan'] = _hapusPesanan;
    map['semuaHapus'] = _semuaHapus;
    map['cetakPesanan'] = _cetakPesanan;
    map['monitoringAgg'] = _monitoringAgg;
    map['monitoringAggMinus'] = _monitoringAggMinus;
    map['dashReferralTrans'] = _dashReferralTrans;
    map['dashReferralDseller'] = _dashReferralDseller;
    map['dashReferralSeller'] = _dashReferralSeller;
    map['accountJlc'] = _accountJlc;
    map['accountCod'] = _accountCod;
    map['accountNoncod'] = _accountNoncod;
    map['paketmuInput'] = _paketmuInput;
    map['paketmuRiwayat'] = _paketmuRiwayat;
    map['paketmuLacak'] = _paketmuLacak;
    map['paketmuMintadijemput'] = _paketmuMintadijemput;
    map['paketmuSerahterima'] = _paketmuSerahterima;
    map['paketmuPrint'] = _paketmuPrint;
    map['keuanganJneMoney'] = _keuanganJneMoney;
    map['keuanganCod'] = _keuanganCod;
    map['keuanganAggregasi'] = _keuanganAggregasi;
    map['keuanganAggregasiMinus'] = _keuanganAggregasiMinus;
    map['keuanganTagihan'] = _keuanganTagihan;
    map['keuanganBonus'] = _keuanganBonus;
    map['hubungiLaporan'] = _hubungiLaporan;
    map['hubungiEclaim'] = _hubungiEclaim;
    map['laporanSummaryOrigin'] = _laporanSummaryOrigin;
    map['laporanSummaryDestination'] = _laporanSummaryDestination;
    map['dukunganTeknis'] = _dukunganTeknis;
    map['pengaturanTema'] = _pengaturanTema;
    map['pengaturanLabel'] = _pengaturanLabel;
    map['pengaturanPetugas'] = _pengaturanPetugas;
    return map;
  }
}

class Token {
  Token({
    String? accessToken,
    num? accessTokenExpiresAt,
    String? refreshToken,
    num? refreshTokenExpiresAt,
  }) {
    _accessToken = accessToken;
    _accessTokenExpiresAt = accessTokenExpiresAt;
    _refreshToken = refreshToken;
    _refreshTokenExpiresAt = refreshTokenExpiresAt;
  }

  Token.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _accessTokenExpiresAt = json['accessTokenExpiresAt'];
    _refreshToken = json['refreshToken'];
    _refreshTokenExpiresAt = json['refreshTokenExpiresAt'];
  }

  String? _accessToken;
  num? _accessTokenExpiresAt;
  String? _refreshToken;
  num? _refreshTokenExpiresAt;

  Token copyWith({
    String? accessToken,
    num? accessTokenExpiresAt,
    String? refreshToken,
    num? refreshTokenExpiresAt,
  }) =>
      Token(
        accessToken: accessToken ?? _accessToken,
        accessTokenExpiresAt: accessTokenExpiresAt ?? _accessTokenExpiresAt,
        refreshToken: refreshToken ?? _refreshToken,
        refreshTokenExpiresAt: refreshTokenExpiresAt ?? _refreshTokenExpiresAt,
      );

  String? get accessToken => _accessToken;

  num? get accessTokenExpiresAt => _accessTokenExpiresAt;

  String? get refreshToken => _refreshToken;

  num? get refreshTokenExpiresAt => _refreshTokenExpiresAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['accessTokenExpiresAt'] = _accessTokenExpiresAt;
    map['refreshToken'] = _refreshToken;
    map['refreshTokenExpiresAt'] = _refreshTokenExpiresAt;
    return map;
  }
}

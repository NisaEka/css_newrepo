import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';

class DataPetugasModel {
  DataPetugasModel({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? zipCode,
    String? status,
    Menu? menu,
    Transaction? transaction,
    List<Account>? accounts,
    List<String>? originCodes,
    List<BranchModel>? branches,
    List<Origin>? origins,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _password = password;
    _address = address;
    _zipCode = zipCode;
    _status = status;
    _menu = menu;
    _transaction = transaction;
    _accounts = accounts;
    _originCodes = originCodes;
    _branches = branches;
    _origins = origins;
  }

  DataPetugasModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _address = json['address'] ?? json['branch'];
    _zipCode = json['zip_code'];
    _status = json['status'];
    _menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
    _transaction = json['transaction'] != null ? Transaction.fromJson(json['transaction']) : null;
    if (json['accounts'] != null) {
      _accounts = [];
      json['accounts'].forEach((v) {
        _accounts?.add(Account.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches?.add(BranchModel.fromJson(v));
      });
    }
    if (json['origins'] != null) {
      _origins = [];
      json['origins'].forEach((v) {
        _origins?.add(Origin.fromJson(v));
      });
    }
    _originCodes = json['origins'] != null ? json['origins'].cast<String>() : [];
  }

  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _password;
  String? _address;
  String? _zipCode;
  String? _status;
  Menu? _menu;
  Transaction? _transaction;
  List<Account>? _accounts;
  List<String>? _originCodes;
  List<BranchModel>? _branches;
  List<Origin>? _origins;

  DataPetugasModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? zipCode,
    String? status,
    Menu? menu,
    Transaction? transaction,
    List<Account>? accounts,
    List<String>? originCodes,
    List<BranchModel>? branches,
    List<Origin>? origins,
  }) =>
      DataPetugasModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        password: password ?? _password,
        address: address ?? _address,
        zipCode: zipCode ?? _zipCode,
        status: status ?? _status,
        menu: menu ?? _menu,
        transaction: transaction ?? _transaction,
        accounts: accounts ?? _accounts,
        originCodes: originCodes ?? _originCodes,
        branches: branches ?? _branches,
        origins: origins ?? _origins,
      );

  String? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get phone => _phone;

  String? get password => _password;

  String? get address => _address;

  String? get zipCode => _zipCode;

  String? get status => _status;

  Menu? get menu => _menu;

  Transaction? get transaction => _transaction;

  List<Account>? get accounts => _accounts;

  List<String>? get originCodes => _originCodes;

  List<BranchModel>? get branches => _branches;

  List<Origin>? get origins => _origins;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['password'] = _password;
    map['address'] = _address;
    map['branch'] = _address;
    map['zip_code'] = _zipCode;
    map['status'] = _status;
    if (_menu != null) {
      map['menu'] = _menu?.toJson();
    }
    if (_transaction != null) {
      map['transaction'] = _transaction?.toJson();
    }
    if (_accounts != null) {
      map['accounts'] = _accounts?.map((v) => v.toJson()).toList();
    }
    if (_branches != null) {
      map['branches'] = _branches?.map((v) => v.toJson()).toList();
    }
    map['origins'] = _originCodes;
    map['origins'] = _origins;
    return map;
  }
}

class Transaction {
  Transaction({
    String? show,
    String? delete,
  }) {
    _show = show;
    _delete = delete;
  }

  Transaction.fromJson(dynamic json) {
    _show = json['show'];
    _delete = json['delete'];
  }

  String? _show;
  String? _delete;

  Transaction copyWith({
    String? show,
    String? delete,
  }) =>
      Transaction(
        show: show ?? _show,
        delete: delete ?? _delete,
      );

  String? get show => _show;

  String? get delete => _delete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['show'] = _show;
    map['delete'] = _delete;
    return map;
  }
}

class Menu {
  Menu({
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

  Menu.fromJson(dynamic json) {
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

  Menu copyWith({
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
      Menu(
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

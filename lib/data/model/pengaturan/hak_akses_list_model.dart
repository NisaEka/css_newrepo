class HakAksesListModel {
  HakAksesListModel({
    this.profilku,
    this.fasilitasku,
    this.ubahKataSandi,
    this.beranda,
  });

  HakAksesListModel.fromJson(dynamic json) {
    profilku = json['Profilku'];
    fasilitasku = json['Fasilitasku'];
    ubahKataSandi = json['Ubah Kata Sandi'];
    beranda = json['Beranda'];
  }

  bool? profilku;
  bool? fasilitasku;
  bool? ubahKataSandi;
  bool? beranda;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Profilku'] = profilku;
    map['Fasilitasku'] = fasilitasku;
    map['Ubah Kata Sandi'] = ubahKataSandi;
    map['Beranda'] = beranda;
    return map;
  }

}

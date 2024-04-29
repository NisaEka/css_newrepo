class FacilityModel {

  String _icon = "";
  String get icon => _icon;

  String _name = "";
  String get name => _name;

  bool _enabled = false;
  bool get enabled => _enabled;

  bool _canUse = false;
  bool get canUse => _canUse;

  FacilityModel({
    String icon = "",
    String name = "",
    bool enabled = false,
    bool canUse = false
  }) {
    _icon = icon;
    _name = name;
    _enabled = enabled;
    _canUse = canUse;
  }

  List<FacilityModel> getCodFacilities() {
    final List<FacilityModel> facilities = [];

    facilities.add(FacilityModel(
      icon: "assets/images/img_cod_gak_mau_ribet.png",
      name: "Gak Mau Ribet",
      enabled: false,
      canUse: true
    ));

    facilities.add(FacilityModel(
        icon: "assets/images/img_cod_bayar_ongkir_diawal.png",
        name: "Bayar Ongkir diawal",
        enabled: false,
        canUse: true
    ));

    facilities.add(FacilityModel(
        icon: "assets/images/img_cod_bayar_ongkir_diakhir.png",
        name: "Bayar Ongkir diakhir",
        enabled: false,
        canUse: true
    ));

    return facilities;
  }

  List<FacilityModel> getNonCodFacilities() {
    final List<FacilityModel> facilities = [];

    facilities.add(FacilityModel(
        icon: "assets/images/img_ncod_gak_mau_ribet.png",
        name: "Gak Mau Ribet",
        enabled: true,
        canUse: false
    ));

    facilities.add(FacilityModel(
        icon: "assets/images/img_ncod_bayar_ongkir_nanti.png",
        name: "Bayar Ongkir Nanti",
        enabled: false,
        canUse: true
    ));

    return facilities;
  }

}
class FacilityModel {
  String _icon = "";
  String get icon => _icon;

  String _name = "";
  String get name => _name;

  String _type = "";
  String get type => _type;

  String _description = "description";
  String get description => _description;

  bool _enabled = false;
  bool get enabled => _enabled;

  bool _onProcess = false;
  bool get onProcess => _onProcess;

  bool _canUse = false;
  bool get canUse => _canUse;

  FacilityModel(
      {String icon = "",
      String name = "",
      String type = "",
      bool enabled = false,
      bool onProcess = false,
      bool canUse = false}) {
    _icon = icon;
    _name = name;
    _type = type;
    _enabled = enabled;
    _onProcess = onProcess;
    _canUse = canUse;
  }

  FacilityModel.fromJson(dynamic json) {
    _icon = json["image_url"];
    _name = json["name"];
    _type = json["type"];
    _description = json["description"];
    _enabled = json["enabled"];
    _onProcess = json['on_process'];
    _canUse = json["can_use"];
  }
}

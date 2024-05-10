class DefaultResponseModel <T> {

  num _code = 0;
  num get code => _code;

  String _message = "";
  String get message => _message;

  T? _payload;
  T? get payload => _payload;

  DefaultResponseModel({
    num code = 0,
    String message = "",
    T? payload
  }) {
    this._code = code;
    this._message = message;
    this._payload = payload;
  }

  DefaultResponseModel.fromJson(dynamic json, T payload) {
    this._code = json["code"];
    this._message = json["message"];
    this._payload = payload;
  }

}
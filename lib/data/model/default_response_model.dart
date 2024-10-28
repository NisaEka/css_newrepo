class DefaultResponseModel<T> {
  num _statusCode = 0;
  num get statusCode => _statusCode;

  String _message = "";
  String get message => _message;

  T? _data;
  T? get data => _data;

  DefaultResponseModel({num statusCode = 0, String message = "", T? data}) {
    this._statusCode = statusCode;
    this._message = message;
    this._data = data;
  }

  DefaultResponseModel.fromJson(dynamic json, T? data) {
    this._statusCode = json["statusCode"];
    // this._message = json["message"];
    this._data = data;
  }
}

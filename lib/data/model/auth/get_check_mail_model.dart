class GetCheckMailModel {
  GetCheckMailModel({
      num? code, 
      String? message, 
      Payload? payload,}){
    _code = code;
    _message = message;
    _payload = payload;
}

  GetCheckMailModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }
  num? _code;
  String? _message;
  Payload? _payload;
GetCheckMailModel copyWith({  num? code,
  String? message,
  Payload? payload,
}) => GetCheckMailModel(  code: code ?? _code,
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
      num? status, 
      String? email, 
      String? domain, 
      bool? mx, 
      bool? disposable, 
      bool? publicDomain, 
      bool? alias, 
      String? didYouMean,}){
    _status = status;
    _email = email;
    _domain = domain;
    _mx = mx;
    _disposable = disposable;
    _publicDomain = publicDomain;
    _alias = alias;
    _didYouMean = didYouMean;
}

  Payload.fromJson(dynamic json) {
    _status = json['status'];
    _email = json['email'];
    _domain = json['domain'];
    _mx = json['mx'];
    _disposable = json['disposable'];
    _publicDomain = json['public_domain'];
    _alias = json['alias'];
    _didYouMean = json['did_you_mean'];
  }
  num? _status;
  String? _email;
  String? _domain;
  bool? _mx;
  bool? _disposable;
  bool? _publicDomain;
  bool? _alias;
  String? _didYouMean;
Payload copyWith({  num? status,
  String? email,
  String? domain,
  bool? mx,
  bool? disposable,
  bool? publicDomain,
  bool? alias,
  String? didYouMean,
}) => Payload(  status: status ?? _status,
  email: email ?? _email,
  domain: domain ?? _domain,
  mx: mx ?? _mx,
  disposable: disposable ?? _disposable,
  publicDomain: publicDomain ?? _publicDomain,
  alias: alias ?? _alias,
  didYouMean: didYouMean ?? _didYouMean,
);
  num? get status => _status;
  String? get email => _email;
  String? get domain => _domain;
  bool? get mx => _mx;
  bool? get disposable => _disposable;
  bool? get publicDomain => _publicDomain;
  bool? get alias => _alias;
  String? get didYouMean => _didYouMean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['email'] = _email;
    map['domain'] = _domain;
    map['mx'] = _mx;
    map['disposable'] = _disposable;
    map['public_domain'] = _publicDomain;
    map['alias'] = _alias;
    map['did_you_mean'] = _didYouMean;
    return map;
  }

}
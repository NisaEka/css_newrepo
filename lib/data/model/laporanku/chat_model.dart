class ChatModel {
  ChatModel({
      num? data, 
      String? message,}){
    _data = data;
    _message = message;
}

  ChatModel.fromJson(dynamic json) {
    _data = json['data'];
    _message = json['message'];
  }
  num? _data;
  String? _message;
ChatModel copyWith({  num? data,
  String? message,
}) => ChatModel(  data: data ?? _data,
  message: message ?? _message,
);
  num? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['message'] = _message;
    return map;
  }

}
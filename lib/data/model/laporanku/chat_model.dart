// class ChatModel {
//   ChatModel({
//     num? data,
//     String? message,
//     String? image,
//   }) {
//     _data = data;
//     _message = message;
//     _image = image;
//   }
//
//   ChatModel.fromJson(dynamic json) {
//     _data = json['data'];
//     _message = json['message'];
//     _image = json['image'];
//   }
//
//   num? _data;
//   String? _message;
//   String? _image;
//
//   ChatModel copyWith({
//     num? data,
//     String? message,
//     String? image,
//   }) =>
//       ChatModel(
//         data: data ?? _data,
//         message: message ?? _message,
//         image: image ?? _image,
//       );
//
//   num? get data => _data;
//
//   String? get message => _message;
//
//   String? get image => _image;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['data'] = _data;
//     map['message'] = _message;
//     map['image'] = _image;
//     return map;
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';

class UnreadMessageModel {
  UnreadMessageModel({
    List<Messages>? messages,
  }) {
    _messages = messages;
  }

  UnreadMessageModel.fromJson(dynamic json) {
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
  }

  List<Messages>? _messages;

  UnreadMessageModel copyWith({
    List<Messages>? messages,
  }) =>
      UnreadMessageModel(
        messages: messages ?? _messages,
      );

  List<Messages>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Messages {
  Messages({
    String? senderId,
    String? category,
    String? collapseKey,
    bool? contentAvailable,
    Map<String, dynamic>? data,
    String? from,
    String? messageId,
    String? messageType,
    bool? mutableContent,
    RemoteNotification? notification,
    DateTime? sentTime,
    String? threadId,
    int? ttl,
    bool? isRead,
  }) {
    _senderId = senderId;
    _category = category;
    _collapseKey = collapseKey;
    _contentAvailable = contentAvailable;
    _data = data;
    _from = from;
    _messageId = messageId;
    _messageType = messageType;
    _mutableContent = mutableContent;
    _notification = notification;
    _sentTime = sentTime;
    _threadId = threadId;
    _ttl = ttl;
    _isRead = isRead;
  }

  Messages.fromJson(dynamic json) {
    _senderId = json['senderId'];
    _category = json['category'];
    _collapseKey = json['collapseKey'];
    _contentAvailable = json['contentAvailable'];
    _data = json['data'];
    _from = json['from'];
    _messageId = json['messageId'];
    _messageType = json['messageType'];
    _mutableContent = json['mutableContent'];
    _notification = json['notification'];
    _sentTime = json['sentTime'];
    _threadId = json['threadId'];
    _ttl = json['ttl'];
    _isRead = json['is_read'];
  }

  String? _senderId;
  String? _category;
  String? _collapseKey;
  bool? _contentAvailable;
  Map<String, dynamic>? _data;
  String? _from;
  String? _messageId;
  String? _messageType;
  bool? _mutableContent;
  RemoteNotification? _notification;
  DateTime? _sentTime;
  String? _threadId;
  int? _ttl;
  bool? _isRead;

  Messages copyWith({
    String? senderId,
    String? category,
    String? collapseKey,
    bool? contentAvailable,
    Map<String, dynamic>? data,
    String? from,
    String? messageId,
    String? messageType,
    bool? mutableContent,
    RemoteNotification? notification,
    DateTime? sentTime,
    String? threadId,
    int? ttl,
    bool? isRead,
  }) =>
      Messages(
          senderId: senderId ?? _senderId,
          category: category ?? _category,
          collapseKey: collapseKey ?? _collapseKey,
          contentAvailable: contentAvailable ?? _contentAvailable,
          data: data ?? _data,
          from: from ?? _from,
          messageId: messageId ?? _messageId,
          messageType: messageType ?? _messageType,
          mutableContent: mutableContent ?? _mutableContent,
          notification: notification ?? _notification,
          sentTime: sentTime ?? _sentTime,
          threadId: threadId ?? _threadId,
          ttl: ttl ?? _ttl,
          isRead: isRead ?? _isRead);

  String? get senderId => _senderId;

  String? get category => _category;

  String? get collapseKey => _collapseKey;

  bool? get contentAvailable => _contentAvailable;

  Map<String, dynamic>? get data => _data;

  String? get from => _from;

  String? get messageId => _messageId;

  String? get messageType => _messageType;

  bool? get mutableContent => _mutableContent;

  RemoteNotification? get notification => _notification;

  DateTime? get sentTime => _sentTime;

  String? get threadId => _threadId;

  int? get ttl => _ttl;

  bool? get isRead => _isRead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderId'] = _senderId;
    map['category'] = _category;
    map['collapseKey'] = _collapseKey;
    map['contentAvailable'] = _contentAvailable;
    map['data'] = _data;
    map['from'] = _from;
    map['messageId'] = _messageId;
    map['messageType'] = _messageType;
    map['mutableContent'] = _mutableContent;
    map['notification'] = _notification;
    map['sentTime'] = _sentTime;
    map['threadId'] = _threadId;
    map['ttl'] = _ttl;
    map['is_read'] = _isRead;
    return map;
  }
}

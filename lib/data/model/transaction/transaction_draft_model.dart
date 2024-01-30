import 'dart:convert';

import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';

TransactionDraftModel transactionDraftModelFromJson(String str) => TransactionDraftModel.fromJson(json.decode(str));

String transactionDraftModelToJson(TransactionDraftModel data) => json.encode(data.toJson());

class TransactionDraftModel {
  TransactionDraftModel({
    List<TransactionDataModel>? draft,
  }) {
    _draft = draft;
  }

  List<TransactionDataModel> get draft => _draft ?? [];

  set draft(List<TransactionDataModel> value) {
    _draft = value;
  }

  TransactionDraftModel.fromJson(dynamic json) {
    if (json['draft'] != null) {
      _draft = [];
      json['draft'].forEach((v) {
        _draft?.add(TransactionDataModel.fromJson(v));
      });
    }
  }

  List<TransactionDataModel>? _draft;

  TransactionDraftModel copyWith({
    List<TransactionDataModel>? draft,
  }) =>
      TransactionDraftModel(
        draft: draft ?? _draft,
      );


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_draft != null) {
      map['draft'] = _draft?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

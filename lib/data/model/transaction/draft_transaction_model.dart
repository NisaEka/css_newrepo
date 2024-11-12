import 'dart:convert';

import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';

DraftTransactionModel transactionDraftModelFromJson(String str) =>
    DraftTransactionModel.fromJson(json.decode(str));

String transactionDraftModelToJson(DraftTransactionModel data) =>
    json.encode(data.toJson());

class DraftTransactionModel {
  DraftTransactionModel({
    List<DataTransactionModel>? draft,
  }) {
    _draft = draft;
  }

  List<DataTransactionModel> get draft => _draft ?? [];

  set draft(List<DataTransactionModel> value) {
    _draft = value;
  }

  DraftTransactionModel.fromJson(dynamic json) {
    if (json['draft'] != null) {
      _draft = [];
      json['draft'].forEach((v) {
        _draft?.add(DataTransactionModel.fromJson(v));
      });
    }
  }

  List<DataTransactionModel>? _draft;

  DraftTransactionModel copyWith({
    List<DataTransactionModel>? draft,
  }) =>
      DraftTransactionModel(
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

class AggregationMinusDocModel {

  String _aggMinDoc = "";
  String get aggMinDoc => _aggMinDoc;

  String _docDate = "";
  String get docDate => _docDate;

  String _cnoteNo = "";
  String get cnoteNo => _cnoteNo;

  AggregationMinusDocModel.fromJson(dynamic json) {
    _aggMinDoc = json["agg_min_doc"];
    _docDate = json["doc_date"];
    _cnoteNo = json["cnote_no"];
  }

}
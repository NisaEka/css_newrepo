class AggregationMinusDetailModel {

  String _aggMinDoc = "";
  String get aggMinDoc => _aggMinDoc;

  String _docDate = "";
  String get docDate => _docDate;

  AggregationMinusDetailModel.fromJson(dynamic json) {
    _aggMinDoc = json["agg_min_doc"];
    _docDate = json["doc_date"];
  }

}
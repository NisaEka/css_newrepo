import 'package:css_mobile/util/constant.dart';

class AdvanceFilterModel {

  int _page = Constant.defaultPage;
  int get page => _page;

  int _limit = Constant.defaultLimit;
  int get limit => _limit;

  String _date = "";
  String get date => _date;

  String _keyword = "";
  String get keyword => _keyword;

  AdvanceFilterModel({
    int page = Constant.defaultPage,
    int limit = Constant.defaultLimit,
    String date = "",
    String keyword = ""
  }) {
    _page = page;
    _limit = limit;
    _date = date;
    _keyword = keyword;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['page'] = _page;
    json['limit'] = _limit;
    json['date'] = _date;
    json['keyword'] = _keyword;

    return json;
  }

}
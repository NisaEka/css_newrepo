class DefaultPageFilterModel {

  int _page = 10;

  int _limit = 1;

  String _keyword = "";

  DefaultPageFilterModel({
    int page = 1,
    int limit = 10,
    String keyword = "",
  }) {
    _page = page;
    _limit = limit;
    _keyword = keyword;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['page'] = _page;
    json['limit'] = _limit;
    json['keyword'] = _keyword;

    return json;
  }

}
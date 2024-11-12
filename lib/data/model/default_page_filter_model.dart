class DefaultPageFilterModel {
  int _page = 10;
  int get page => _page;

  int _limit = 1;
  int get limit => _limit;

  String _keyword = "";
  String get keyword => _keyword;

  DefaultPageFilterModel({
    int page = 1,
    int limit = 10,
    String keyword = "",
  }) {
    _page = page;
    _limit = limit;
    _keyword = keyword;
  }

  setPage(int newPage) {
    _page = newPage;
  }

  setKeyword(String newKeyword) {
    _keyword = newKeyword;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['page'] = _page;
    json['limit'] = _limit;
    json['keyword'] = _keyword;

    return json;
  }
}

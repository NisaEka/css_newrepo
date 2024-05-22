import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AggByDocController extends BaseController {
  final searchField = TextEditingController();
  final PagingController<int, dynamic> pagingController = PagingController(firstPageKey: 1);
}

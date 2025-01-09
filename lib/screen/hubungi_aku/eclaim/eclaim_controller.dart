import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_state.dart';
import 'package:css_mobile/util/logger.dart';

class EclaimController extends BaseController {
  final state = EclaimState();
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    Future.wait([eclaimCount(), initData()]);
    state.pagingController.addPageRequestListener((pageKey) {
      getEclaim(pageKey);
    });
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    state.selectedStatusClaim = "Total";
    applyFilter();
  }

  Future<void> eclaimCount() async {
    try {
      await eclaims
          .getEclaimCount(QueryModel(
        search: state.searchField.text,
        between: state.transDate,
      ))
          .then((value) {
        state.countModel = value.data;
        state.total = value.data?.totalCount?.toInt() ?? 0;
        state.diterima = value.data?.acceptedCount?.toInt() ?? 0;
        state.ditolak = value.data?.rejectedCount?.toInt() ?? 0;
        update();
      });
    } catch (e, i) {
      AppLogger.e('error transactionCount $e, $i');
    }
  }

  Future<void> initData() async {
    state.selectedStatusClaim = '';
  }

  Future<void> getEclaim(int page) async {
    state.isLoading = true;
    try {
      final trans = await eclaims.getEclaim(QueryModel(
          search: state.searchField.text,
          between: state.transDate,
          sort: [
            {"createDate": "desc"}
          ]));

      final isLastPage =
          (trans.meta?.currentPage ?? 0) == (trans.meta?.lastPage ?? 0);
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.data ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.data ?? [], nextPageKey);
      }
    } catch (e) {
      AppLogger.e('error getEclaim $e');
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  void resetFilter() {
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    state.searchField.clear();
    state.transDate = [];
    state.dateFilter = '0';
    state.pagingController.refresh();
    update();
    eclaimCount();
    applyFilter();
  }

  @override
  void dispose() {
    super.dispose();
    state.pagingController.dispose();
  }

  applyFilter() {
    state.isFiltered = true;
    if (state.startDate != null && state.endDate != null) {
      state.transDate = [
        {
          "createDate": ["${state.startDate}", "${state.endDate}"]
        }
      ];
    }
    update();
    state.pagingController.refresh();
    eclaimCount();
  }
}

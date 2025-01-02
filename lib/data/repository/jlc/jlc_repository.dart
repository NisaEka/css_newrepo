import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_point_reedem_model.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_transactions_model.dart';
import 'package:css_mobile/data/model/jlc/post_total_point_model.dart';

abstract class JLCRepository {
  Future<PostTotalPointModel> postTotalPoint();

  Future<PostJlcPointReedemModel> postTukarPoint();

  Future<PostJlcTransactionsModel> postTransPoint();

  Future<BaseResponse<List<BannerModel>>> postDashboardBanner();

  Future<BaseResponse<List<NewsModel>>> postDashboardNews();
}

import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_category_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_summary_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';

abstract class LaporankuRepository {
  Future<BaseResponse<List<TicketCategory>>> getTicketCategory(
      QueryParamModel param);

  Future<BaseResponse<TicketSummary>> getTicketSummary(QueryParamModel param);

  Future<BaseResponse<List<TicketModel>>> getTickets(QueryParamModel param);

  Future<BaseResponse<TicketModel>> postTicket(DataPostTicketModel data);

  Future<BaseResponse<List<TicketMessageModel>>> getTickeMessage(
      QueryParamModel param);

  Future<BaseResponse<TicketModel>> postTicketMessage(DataPostTicketModel data);

  Future<BaseResponse<TicketModel>> putTicket(String id, String status);
}

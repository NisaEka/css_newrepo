import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_category_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_summary_model.dart';
import 'package:css_mobile/data/model/query_model.dart';

abstract class LaporankuRepository {
  Future<BaseResponse<List<TicketCategory>>> getTicketCategory(
      QueryModel param);

  Future<BaseResponse<TicketSummary>> getTicketSummary(QueryModel param);

  Future<BaseResponse<List<TicketModel>>> getTickets(QueryModel param);

  Future<BaseResponse<TicketModel>> postTicket(DataPostTicketModel data);

  Future<BaseResponse<List<TicketMessageModel>>> getTicketMessage(
      QueryModel param);

  Future<BaseResponse<TicketModel>> postTicketMessage(DataPostTicketModel data);

  Future<BaseResponse<TicketModel>> putTicket(String id, String status);

  Future<BaseResponse> patchTicketMessageRead(
      String id, TicketMessageModel data);
}

import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_category_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_summary_model.dart';

abstract class LaporankuRepository {
  Future<GetTicketCategoryModel> getTicketCategory();

  Future<GetTicketSummaryModel> getTicketSummary(
    String status,
    String date,
    String query,
  );

  Future<GetTicketModel> getTickets(
    int page,
    int limit,
    String status,
    String date,
    String query,
  );

  Future<GetTicketModel> postTicket(DataPostTicketModel data);

  Future<GetTicketMessageModel> getTickeMessage(
    String id,
    int page,
    int limit,
  );

  Future<GetTicketModel> postTicketMessage(DataPostTicketModel data);

  Future<GetTicketModel> putTicket(String id, String status);
}

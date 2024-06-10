import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_point_reedem_model.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BonusKamuController extends BaseController {
  TabController? tabController;
  int tabIndex = 0;
  String? totalTransaksi;
  String? jlcPoint;

  bool isLoading = false;

  List<JLCTransactions> totalTransaksiList = [];
  List<JlcPointReedem> reedemPointList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      await jlc.postTotalPoint().then((value) {
        totalTransaksi = value.data?.first.totalTransaksi;
        jlcPoint = value.data?.first.sisaPoint;

        update();
      });

      await jlc.postTransPoint().then((value) {
        totalTransaksiList.addAll(value.data ?? []);
        update();
      });

      await jlc.postTukarPoint().then((value) {
        reedemPointList.addAll(value.data ?? []);
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
  }
}

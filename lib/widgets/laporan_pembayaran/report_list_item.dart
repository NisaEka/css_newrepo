import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/value_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportListItem extends StatefulWidget {
  final String? status;
  final bool isLoading;
  final AggregationModel? data;
  final AggregationDetailModel? det;
  final VoidCallback? onTapButton;
  final VoidCallback? onTap;
  final bool isShowDetail;

  const ReportListItem({
    super.key,
    this.status,
    this.isLoading = false,
    this.data,
    this.onTapButton,
    this.isShowDetail = true,
    this.onTap,
    this.det,
  });

  @override
  State<ReportListItem> createState() => _ReportListItemState();
}

class _ReportListItemState extends State<ReportListItem> {
  bool showDetail = false;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: widget.isLoading,
      child: GestureDetector(
        onTap: widget.onTap ??
            () => setState(() {
                  if (widget.isLoading == false) {
                    showDetail = showDetail ? false : true;
                  }
                }),
        child: Stack(
          children: [
            Positioned(
              right: 1.2,
              top: 1.2,
              child: widget.status != null
                  ? Container(
                      padding: const EdgeInsets.only(
                          top: 5, right: 5, left: 20, bottom: 2),
                      decoration: BoxDecoration(
                          color: widget.status == 'Success'
                              ? successLightColor2
                              : errorLightColor2,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(20),
                          )),
                      child: Text(
                        widget.status ?? '',
                        style: listTitleTextStyle.copyWith(color: whiteColor),
                      ),
                    )
                  : const SizedBox(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 18),
                        decoration: BoxDecoration(
                          color: infoColor,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? successColor
                                  : infoColor,
                              width: 2),
                        ),
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.white,
                          size: 20,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: widget.isLoading
                                ? greyLightColor3
                                : Colors.transparent,
                            width: widget.isLoading ? Get.width / 3 : null,
                            height: widget.isLoading ? 10 : null,
                            child: Text(
                              widget.data?.mpayWdrGrpPayDate
                                      ?.toLongDateTimeFormat() ??
                                  widget.det?.dpayDetWdrCnotedate
                                      ?.toLongDateTimeFormat() ??
                                  '',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          Container(
                            color: widget.isLoading
                                ? greyLightColor3
                                : Colors.transparent,
                            width: widget.isLoading ? Get.width / 3 : null,
                            height: widget.isLoading ? 15 : null,
                            margin: widget.isLoading
                                ? const EdgeInsets.only(top: 2)
                                : EdgeInsets.zero,
                            child: Text(
                              widget.data?.mpayWdrGrpPayNo ??
                                  widget.det?.dpayDetWdrCnoteno ??
                                  '',
                              style: listTitleTextStyle.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? blueJNE
                                      : greyLightColor1),
                            ),
                          ),
                          !showDetail && widget.isShowDetail
                              ? Container(
                                  color: widget.isLoading
                                      ? greyLightColor3
                                      : Colors.transparent,
                                  width:
                                      widget.isLoading ? Get.width / 4 : null,
                                  height: widget.isLoading ? 12 : null,
                                  margin: widget.isLoading
                                      ? const EdgeInsets.only(top: 2)
                                      : EdgeInsets.zero,
                                  child: Text(
                                    "RP. ${widget.data?.mpayWdrGrpPayPaidAmt?.toInt().toCurrency() ?? widget.data?.mpayWdrGrpPayNetAmt?.toInt().toCurrency() ?? '-'}",
                                    style: listTitleTextStyle.copyWith(
                                      color: successColor,
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      )
                    ],
                  ),
                  showDetail && widget.isShowDetail
                      ? Column(
                          children: [
                            const Divider(thickness: 0.5),
                            ValueItem(
                              title: "PAID AMOUNT",
                              value:
                                  "RP. ${widget.data?.mpayWdrGrpPayPaidAmt?.toInt().toCurrency() ?? '0'}",
                              valueFontColor: successColor,
                            ),
                            ValueItem(
                              title: "PAID DATE",
                              value: widget.data?.mpayWdrGrpPayDatePaid
                                      ?.toShortDateFormat() ??
                                  '-',
                            ),
                            CustomFilledButton(
                              color: primaryColor(context),
                              title: "Lihat Detail".tr,
                              margin: const EdgeInsets.only(top: 20),
                              onPressed: widget.onTapButton,
                            )
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

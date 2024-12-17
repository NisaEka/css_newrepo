import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/value_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggregationMinusItem extends StatefulWidget {
  final String? status;
  final bool isLoading;
  final AggregationMinusModel? data;
  final Function onTap;

  const AggregationMinusItem(
      {super.key,
      this.status,
      this.isLoading = false,
      this.data,
      required this.onTap});

  @override
  State<StatefulWidget> createState() => _AggregationMinusItemState();
}

class _AggregationMinusItemState extends State<AggregationMinusItem> {
  bool showDetail = false;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: widget.isLoading,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: widget.status != null
                ? Container(
                    padding: const EdgeInsets.only(
                        top: 5, right: 5, left: 20, bottom: 2),
                    decoration: BoxDecoration(
                        color: widget.status == 'Success'
                            ? successLightColor2
                            : errorLightColor2,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
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
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => setState(() {
                    if (widget.isLoading == false) {
                      showDetail = showDetail ? false : true;
                    }
                  }),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? redJNE
                                  : redJNE,
                              width: 2),
                        ),
                        child: Icon(
                          Icons.indeterminate_check_box_rounded,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? blueJNE
                                  : redJNE,
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
                              widget.data?.createddtm.toDateTimeFormat() ?? '',
                              style: Theme.of(context).textTheme.titleSmall,
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
                              "# ${widget.data?.aggMinDoc ?? ''}",
                              style: listTitleTextStyle.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? blueJNE
                                      : redJNE),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                showDetail
                    ? Column(
                        children: [
                          const Divider(thickness: 0.5),
                          ValueItem(
                            title: "COD AMOUNT",
                            fontSize: 10,
                            value:
                                "RP. ${widget.data?.codAmt.toCurrency() ?? '0'}",
                            valueFontColor: infoColor,
                          ),
                          ValueItem(
                            title: "COD FEE ( ONGKIR DLL )",
                            fontSize: 10,
                            value:
                                "RP. ${widget.data?.codFee.toCurrency() ?? '0'}",
                            valueFontColor: successColor,
                          ),
                          ValueItem(
                            title: "NET AMOUNT",
                            fontSize: 10,
                            value:
                                "RP. ${widget.data?.netAmt.toCurrency() ?? '0'}",
                            valueFontColor: errorColor,
                          ),
                          CustomFilledButton(
                              title: "Lihat Detail".tr,
                              color: blueJNE,
                              onPressed: () => {widget.onTap()})
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

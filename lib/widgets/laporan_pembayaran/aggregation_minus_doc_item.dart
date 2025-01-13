import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggregationMinusDocItem extends StatefulWidget {
  final String? status;
  final bool isLoading;
  final AggregationMinusDocModel? data;
  final Function onTap;

  const AggregationMinusDocItem(
      {super.key,
      this.status,
      this.isLoading = false,
      this.data,
      required this.onTap});

  @override
  State<StatefulWidget> createState() => _AggregationMinusDocItemState();
}

class _AggregationMinusDocItemState extends State<AggregationMinusDocItem> {
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
                      ),
                    ),
                    child: Text(
                      widget.status ?? '',
                      style: listTitleTextStyle.copyWith(color: whiteColor),
                    ),
                  )
                : const SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(bottom: 16),
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
                    onTap: () => {widget.onTap()},
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: primaryColor(context), width: 2),
                          ),
                          child: Icon(
                            Icons.indeterminate_check_box_rounded,
                            color: primaryColor(context),
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
                                widget.data?.dDocDate?.toLongDateTimeFormat() ??
                                    '',
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
                                widget.data?.dCnoteNo ?? '',
                                style: listTitleTextStyle.copyWith(
                                    color: primaryColor(context)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

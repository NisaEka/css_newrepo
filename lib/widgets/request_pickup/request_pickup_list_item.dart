import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupItem extends StatefulWidget {
  final bool isLoading;
  final RequestPickupModel? data;
  final Function(String) onTap;
  final Function onLongTap;
  final bool checkMode;
  final bool checked;

  const RequestPickupItem(
      {super.key,
      this.isLoading = false,
      required this.data,
      required this.onTap,
      required this.onLongTap,
      this.checkMode = false,
      required this.checked});

  @override
  State<StatefulWidget> createState() => _RequestPickupItemState();
}

class _RequestPickupItemState extends State<RequestPickupItem> {
  @override
  Widget build(BuildContext context) {
    final requestPickup = widget.data;

    return Shimmer(
        isLoading: widget.isLoading,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              {if (requestPickup != null) widget.onTap(requestPickup.awb)},
          onLongPress: () => {widget.onLongTap()},
          child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SizedBox(
                  width: Get.size.width,
                  child: Row(
                    children: [
                      _requestPickupCheckbox(),
                      if (widget.checkMode) const SizedBox(width: 8),
                      _requestPickupContent(requestPickup),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget _requestPickupCheckbox() {
    final isTristate =
        widget.data?.status == Constant.statusAlreadyRequestPickedUp;

    if (widget.checkMode && !isTristate) {
      return Row(
        children: [
          Checkbox(
            value: widget.checked,
            tristate: isTristate,
            onChanged: (newValue) {
              widget.onTap(widget.data!.awb);
            },
          ),
        ],
      );
    } else if (widget.checkMode) {
      return const SizedBox(
        width: 48,
      );
    } else {
      return Container();
    }
  }

  Widget _requestPickupContent(RequestPickupModel? requestPickup) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: _chipColor(requestPickup),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                requestPickup?.status ?? '',
                style: sublistTitleTextStyle.copyWith(
                  color: whiteColor,
                  fontSize: 10,
                ),
              ),
            ),
            Text(
              (requestPickup?.createdDateSearch ?? '').toShortDateFormat(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color:
                      AppConst.isLightTheme(context) ? blueJNE : warningColor),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            requestPickup?.awb ?? "",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ]),
        const SizedBox(height: 4),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text((requestPickup?.qty ?? 0).toString(),
                  style: Theme.of(context).textTheme.titleSmall),
              Text(
                ' ${"Koli".tr.toUpperCase()} / ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text((requestPickup?.weight ?? 0).toString(),
                  style: Theme.of(context).textTheme.titleSmall),
              Text(
                " KG",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Text(
            requestPickup?.shipperCity ?? "",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ]),
      ],
    ));
  }

  Color _chipColor(RequestPickupModel? requestPickup) {
    if (requestPickup?.status == Constant.statusNotRequestPickedUpYet) {
      return warningDarkColor;
    } else if (requestPickup?.status == Constant.statusAlreadyRequestPickedUp) {
      return successColor;
    } else if (requestPickup?.status == Constant.statusFailedRequestForPickUp) {
      return errorColor;
    } else {
      return whiteColor;
    }
  }
}

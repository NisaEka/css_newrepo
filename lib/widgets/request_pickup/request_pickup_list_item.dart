import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class RequestPickupItem extends StatefulWidget {

  final RequestPickupModel? data;
  final Function onTap;
  final Function onLongTap;
  final bool checkMode;

  const RequestPickupItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.onLongTap,
    this.checkMode = false
  });

  @override
  State<StatefulWidget> createState() => _RequestPickupItemState();

}

class _RequestPickupItemState extends State<RequestPickupItem> {

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    final requestPickup = widget.data!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => {
        widget.onTap()
      },
      onLongPress: () => {
        widget.onLongTap()
      },
      child: Container(
        width: Get.size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            _requestPickupCheckbox(),
            _requestPickupImage(),
            const SizedBox(width: 16,),
            _requestPickupContent(requestPickup),
            const SizedBox(width: 16,),
            _requestPickupExtraInfo(requestPickup)
          ],
        ),
      ),
    );
  }

  Widget _requestPickupCheckbox() {
    if (widget.checkMode) {
      return Checkbox(
        value: _checked,
        tristate: widget.data?.status == "Dijemput",
        onChanged: (newValue) {
          setState(() {
            _checked = newValue ?? _checked;
          });
        },
      );
    } else {
      return Container();
    }
  }

  Widget _requestPickupImage() {
    return CachedNetworkImage(
      imageUrl: IconsConstant.paket,
      width: 48,
      height: 48,
    );
  }

  Widget _requestPickupContent(RequestPickupModel requestPickup) {
    return Expanded(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            requestPickup.awb,
            style: itemTextStyle.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            requestPickup.name,
            style: itemTextStyle,
          ),
          _requestPickupServiceAndType(requestPickup)
        ],
      )
    );
  }

  Widget _requestPickupServiceAndType(RequestPickupModel requestPickup) {
    return Row(
      children: [
        Text(
          requestPickup.transactionType,
          style: itemTextStyle,
        ),
        Text(
          " - ",
          style: itemTextStyle,
        ),
        Text(
          requestPickup.transactionService,
          style: itemTextStyle,
        )
      ],
    );
  }

  Widget _requestPickupExtraInfo(RequestPickupModel requestPickup) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          requestPickup.transactionDate,
          style: labelTextStyle,
        ),
        const SizedBox(height: 8,),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _chipColor(requestPickup),
            border: Border.all(
              color: _chipColor(requestPickup)
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          child: Text(
            requestPickup.status,
            style: labelTextStyle.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Color _chipColor(RequestPickupModel requestPickup) {
    if (requestPickup.status == "Belum Dijemput") {
      return warningDarkColor;
    } else {
      return successColor;
    }
  }

}
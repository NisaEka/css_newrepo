import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_address_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupSelectAddressContent extends StatelessWidget {

  final Function onAddNewAddressClick;
  final Function onPickupClick;

  const RequestPickupSelectAddressContent({
    super.key,
    required this.onAddNewAddressClick,
    required this.onPickupClick
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addNewAddressWidget(),
        _addressesWidget(),
        _pickupTime(),
        _pickupButton()
      ],
    );
  }

  Widget _addNewAddressWidget() {
    return GestureDetector(
      onTap: () { onAddNewAddressClick(); },
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tambah alamat penjemputan"),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }

  Widget _addressesWidget() {
    return SizedBox(
      height: 136,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RequestPickupAddressItem(
            lastItem: index == 4,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container();
        },
        itemCount: 5,
      ),
    );
  }

  Widget _pickupTime() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Jam Pickup",
            style: sublistTitleTextStyle.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
          FilledButton(
            onPressed: () { },
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith((states) {
                return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
              })
            ),
            child: Text(
              "Sekarang".tr,
              style: const TextStyle(color: whiteColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _pickupButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: Get.width,
        child: FilledButton(
          onPressed: () { onPickupClick(); },
          child: Text(
            "Jemput".tr,
            style: const TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }

}
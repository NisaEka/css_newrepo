import 'dart:async';

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_address_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupSelectAddressContent extends StatefulWidget {

  final List<RequestPickupAddressModel> addresses;
  final Function onAddNewAddressClick;
  final Function(String selectedTime) onPickupClick;
  String selectedTime = "Sekarang";

  RequestPickupSelectAddressContent({
    super.key,
    required this.addresses,
    required this.onAddNewAddressClick,
    required this.onPickupClick
  });

  @override
  State<StatefulWidget> createState() => _RequestPickupSelectAddressContentState();
}

class _RequestPickupSelectAddressContentState extends State<RequestPickupSelectAddressContent> {

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
      onTap: () { widget.onAddNewAddressClick(); },
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
            address: widget.addresses[index],
            lastItem: index == widget.addresses.length - 1,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container();
        },
        itemCount: widget.addresses.length,
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
          OutlinedButton(
            onPressed: () {
              _selectedTime(context).then((value) {
                if (value?.hour != null && value?.minute != null) {
                  setState(() {
                    widget.selectedTime = "${value!.hour}:${value.minute}";
                  });
                }
              });
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith((states) {
                  return const EdgeInsets.symmetric(horizontal: 4, vertical: 2);
                }),
                side: MaterialStateProperty.resolveWith((states) {
                  return const BorderSide(
                      color: blueJNE
                  );
                })
            ),
            child: Text(
              widget.selectedTime.tr,
              style: const TextStyle(
                color: blueJNE,
                fontWeight: FontWeight.normal
              ),
            ),
          ),
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
          onPressed: () {
            String pickupTime = widget.selectedTime;
            if (pickupTime == "Sekarang") {
              TimeOfDay currentTime = TimeOfDay.now();
              pickupTime = "${currentTime.hour}:${currentTime.minute}";
            }
            widget.onPickupClick(pickupTime);
          },
          child: Text(
            "Jemput".tr,
            style: const TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay?> _selectedTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: AppConst.isLightTheme(context) ? const ColorScheme.light() : const ColorScheme.dark(),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      }
    );
  }

}
import 'dart:async';

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/time_of_day_ext.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_address_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupSelectAddressContent extends StatefulWidget {

  final List<RequestPickupAddressModel> addresses;
  final Function onAddNewAddressClick;
  final Function(String selectedTime) onPickupClick;
  String selectedTime = Constant.defaultPickupTime;

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
    if (widget.addresses.isNotEmpty) {
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
    } else {
      return Container(
        width: Get.width,
        height: 136,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(16)
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Alamat masih kosong".tr,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8,),
            Text(
              "Tambah alamat baru untuk melakukan permintaan penjemputan".tr,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }
  }

  Widget _pickupTime() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Jam Pickup".tr,
            style: Theme.of(context).textTheme.bodyLarge
          ),
          OutlinedButton(
            onPressed: () {
              _selectedTime(context).then((value) {
                if (value?.hour != null && value?.minute != null) {
                  setState(() {
                    widget.selectedTime = value!.asPickupTimeFormat();
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
            if (pickupTime == Constant.defaultPickupTime) {
              TimeOfDay currentTime = TimeOfDay.now();
              pickupTime = currentTime.asPickupTimeFormat();
            }
            widget.onPickupClick(pickupTime);
          },
          child: Text(
            _pickupButtonText(),
            style: const TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }

  String _pickupButtonText() {
    if (widget.selectedTime == Constant.defaultPickupTime) {
      return "Jemput Sekarang".tr;
    } else {
      return "Jemput".tr;
    }
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
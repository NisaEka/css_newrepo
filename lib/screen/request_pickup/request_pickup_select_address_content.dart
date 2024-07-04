import 'dart:async';

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/time_of_day_ext.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_address_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupSelectAddressContent extends StatelessWidget {

  final List<RequestPickupAddressModel> addresses;

  final Function onAddNewAddressClick;
  final Function onPickupClick;
  final Function(String) onTimeSet;
  final Function(String) onSelectAddress;

  final String selectedTime;
  final String? selectedAddressId;

  const RequestPickupSelectAddressContent({
    super.key,
    required this.addresses,
    required this.onAddNewAddressClick,
    required this.onPickupClick,
    required this.onTimeSet,
    required this.onSelectAddress,
    required this.selectedTime,
    required this.selectedAddressId
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addNewAddressWidget(),
        _addressesWidget(context),
        _pickupTime(context),
        _pickupButton()
      ],
    );
  }

  Widget _addNewAddressWidget() {
    return GestureDetector(
      onTap: () { onAddNewAddressClick(); },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tambah alamat penjemputan'.tr),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }

  Widget _addressesWidget(BuildContext context) {
    if (addresses.isNotEmpty) {
      return SizedBox(
        height: 136,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return RequestPickupAddressItem(
              address: addresses[index],
              lastItem: index == addresses.length - 1,
              selected: selectedAddressId == addresses[index].id,
              onItemClick: () => onSelectAddress(addresses[index].id),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container();
          },
          itemCount: addresses.length,
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

  Widget _pickupTime(BuildContext context) {
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
                  onTimeSet(value!.asPickupTimeFormat());
                }
              });
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith((states) {
                  return const EdgeInsets.symmetric(horizontal: 4, vertical: 2);
                }),
                side: MaterialStateProperty.resolveWith((states) {
                  return BorderSide(
                      color: Theme.of(context).colorScheme.outline
                  );
                })
            ),
            child: Text(
              selectedTime.tr,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
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
          onPressed: () => onPickupClick(),
          child: Text(
            _pickupButtonText(),
            style: const TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }

  String _pickupButtonText() {
    if (selectedTime == Constant.defaultPickupTime) {
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
                  foregroundColor: Colors.red,
                ),
              ),
            ),
            child: child!,
          );
        }
    );
  }

}
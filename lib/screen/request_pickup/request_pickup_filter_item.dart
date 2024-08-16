import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RequestPickupFilterItem extends StatelessWidget {
  final Function onItemSelected;
  final String itemName;
  final bool isSelected;
  final bool requireDatePicker;
  final String startDate;
  final String endDate;
  final Function(DateTime?) onStartDateChange;
  final Function(DateTime?) onEndDateChange;

  const RequestPickupFilterItem(
      {super.key,
      required this.onItemSelected,
      required this.itemName,
      required this.isSelected,
      required this.requireDatePicker,
      required this.startDate,
      required this.endDate,
      required this.onStartDateChange,
      required this.onEndDateChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemSelected();
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.outline),
              ),
              Icon(isSelected ? Icons.circle : Icons.circle_outlined)
            ],
          ),
          _datePickerButtonRow(context)
        ],
      ),
    );
  }

  Widget _datePickerButtonRow(BuildContext context) {
    if (requireDatePicker) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilledButton(
            onPressed: () {
              _selectDate(context).then((value) {
                onStartDateChange(value);
              });
            },
            child: Text(
              startDate.tr,
              style: const TextStyle(color: whiteColor),
            ),
          ),
          FilledButton(
            onPressed: () {
              _selectDate(context).then((value) {
                onEndDateChange(value);
              });
            },
            child: Text(
              endDate.tr,
              style: const TextStyle(color: whiteColor),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Future<DateTime?> _selectDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(Constant.defaultFirstYear),
      lastDate: DateTime(Constant.defaultLastYear),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: AppConst.isLightTheme(context)
                ? const ColorScheme.light()
                : const ColorScheme.dark(),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}

// child: showDatePickerContent
// ?
//     : Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(items[index].asName().tr),
// Icon(isSelected
// ? Icons.circle
//     : Icons.circle_outlined)
// ],
// )

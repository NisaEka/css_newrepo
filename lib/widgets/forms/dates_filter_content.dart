import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'customformlabel.dart';
import 'customradiobutton.dart';
import 'customtextformfield.dart';

class DateFilterField extends StatefulHookWidget {
  final ValueChanged<DateFilter> onChanged;
  final String? label;
  final String? selectedDateFilter;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isShowAllDate;

  const DateFilterField({
    super.key,
    required this.onChanged,
    this.label,
    this.selectedDateFilter = '3',
    this.startDate,
    this.endDate,
    this.isShowAllDate = false,
  });

  @override
  State<DateFilterField> createState() => _DatesFilterContentState();
}

class _DatesFilterContentState extends State<DateFilterField> {
  String? dateFilter;
  DateTime? startDate;
  DateTime? endDate;
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      startDate = widget.startDate;
      endDate = widget.endDate;
      startDateField.text = startDate.toString().toShortDateTimeFormat();
      endDateField.text = endDate.toString().toShortDateTimeFormat();
      dateFilter = widget.selectedDateFilter.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormLabel(label: widget.label ?? 'Tanggal Entry'.tr),
          const SizedBox(height: 10),
          widget.isShowAllDate
              ? Customradiobutton(
                  title: "Semua Tanggal".tr,
                  value: '0',
                  groupValue: dateFilter,
                  onChanged: (value) => setState(() => selectDateFilter(0)),
                  onTap: () => setState(() => selectDateFilter(0)),
                )
              : const SizedBox(),
          Customradiobutton(
            title: "Hari Ini".tr,
            value: '3',
            groupValue: dateFilter,
            onChanged: (value) => setState(() => selectDateFilter(3)),
            onTap: () => setState(() => selectDateFilter(3)),
          ),
          Customradiobutton(
            title: "Kemarin".tr,
            value: '5',
            groupValue: dateFilter,
            onChanged: (value) => setState(() => selectDateFilter(5)),
            onTap: () => setState(() => selectDateFilter(5)),
          ),
          Customradiobutton(
            title: "1 Minggu Terakhir".tr,
            value: '2',
            groupValue: dateFilter,
            onChanged: (value) => setState(() => selectDateFilter(2)),
            onTap: () => setState(() => selectDateFilter(2)),
          ),
          Customradiobutton(
            title: "1 Bulan Terakhir".tr,
            value: '1',
            groupValue: dateFilter,
            onChanged: (value) => setState(() => selectDateFilter(1)),
            onTap: () => setState(() => selectDateFilter(1)),
          ),
          Customradiobutton(
            title: "Pilih Tanggal Sendiri".tr,
            value: '4',
            groupValue: dateFilter,
            onChanged: (value) => setState(() => selectDateFilter(4)),
            onTap: () => setState(() => selectDateFilter(4)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextFormField(
                controller: startDateField,
                readOnly: true,
                width: Get.width / 2.3,
                hintText: 'Tanggal Awal'.tr,
                onTap: () => selectDate(context).then((value) {
                  setState(() {
                    startDate = value;
                    startDateField.text =
                        value.toString().toShortDateTimeFormat();
                    endDate = DateTime.now();
                    endDateField.text =
                        DateTime.now().toString().toShortDateTimeFormat();

                    widget.onChanged(DateFilter(
                      dateFilter: dateFilter ?? '3',
                      startDate: startDate!,
                      endDate: endDate!,
                    ));
                  });
                }),
              ),
              CustomTextFormField(
                controller: endDateField,
                readOnly: true,
                width: Get.width / 2.3,
                hintText: 'Tanggal Akhir'.tr,
                onTap: () => selectDate(context).then((value) {
                  setState(() {
                    endDate = value;
                    endDateField.text =
                        value.toString().toShortDateTimeFormat();

                    widget.onChanged(DateFilter(
                      dateFilter: dateFilter ?? '3',
                      startDate: startDate!,
                      endDate: endDate!,
                    ));
                  });
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void selectDateFilter(int filter) {
    setState(() {
      dateFilter = filter.toString();
    });
    if (filter == 0 || filter == 4) {
      startDate = null;
      endDate = null;
      startDateField.clear();
      endDateField.clear();
    } else if (filter == 1) {
      startDate = DateTime.now()
          .copyWith(hour: 0, minute: 0)
          .subtract(const Duration(days: 29));
      endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      startDateField.text = startDate.toString().toShortDateTimeFormat();
      endDateField.text = endDate.toString().toShortDateTimeFormat();
    } else if (filter == 2) {
      startDate = DateTime.now()
          .copyWith(hour: 0, minute: 0)
          .subtract(const Duration(days: 6));
      endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      startDateField.text = startDate.toString().toShortDateTimeFormat();
      endDateField.text = endDate.toString().toShortDateTimeFormat();
    } else if (filter == 3) {
      startDate = DateTime.now().copyWith(hour: 0, minute: 0);
      endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      startDateField.text = startDate.toString().toShortDateTimeFormat();
      endDateField.text = endDate.toString().toShortDateTimeFormat();
    } else if (filter == 5) {
      startDate = DateTime.now()
          .subtract(const Duration(days: 1))
          .copyWith(hour: 0, minute: 0);
      endDate = DateTime.now()
          .subtract(const Duration(days: 1))
          .copyWith(hour: 23, minute: 59, second: 59);
      startDateField.text = startDate.toString().toShortDateTimeFormat();
      endDateField.text = endDate.toString().toShortDateTimeFormat();
    }

    setState(() {
      widget.onChanged(DateFilter(
        dateFilter: dateFilter ?? '3',
        startDate: startDate,
        endDate: endDate,
      ));
    });
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    // Show date picker
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: CustomTheme().dateTimePickerTheme(context),
          child: child!,
        );
      },
    );

    if (selectedDate == null || !context.mounted) return null;

    // Show time picker
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: CustomTheme().dateTimePickerTheme(context),
          child: child!,
        );
      },
    );

    if (selectedTime == null || !context.mounted) return null;

    // Combine date and time
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }
}

class DateFilter {
  final String dateFilter;
  final DateTime? startDate;
  final DateTime? endDate;

  const DateFilter({
    required this.dateFilter,
    this.startDate,
    this.endDate,
  });
}

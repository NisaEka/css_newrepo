import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class StatusFilterField extends StatefulHookWidget {
  final ValueChanged<String> onChanged;
  final List<String> statuses;

  const StatusFilterField({
    super.key,
    required this.onChanged,
    required this.statuses,
  });

  @override
  State<StatusFilterField> createState() => _StatusFilterFieldState();
}

class _StatusFilterFieldState extends State<StatusFilterField> {
  String? selectedStatusKiriman;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
            onTap: () => setState(() {
              if (selectedStatusKiriman != widget.statuses[index]) {
                selectedStatusKiriman = widget.statuses[index];
              } else {
                selectedStatusKiriman = null;
              }
              widget.onChanged(selectedStatusKiriman ?? '');
            }),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedStatusKiriman == widget.statuses[index]
                    ? primaryColor(context)
                    : whiteColor,
                border: Border.all(
                  color: selectedStatusKiriman != widget.statuses[index]
                      ? primaryColor(context)
                      : whiteColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                widget.statuses[index].tr,
                textAlign: TextAlign.center,
                style: listTitleTextStyle.copyWith(
                    color: selectedStatusKiriman == widget.statuses[index]
                        ? whiteColor
                        : primaryColor(context)),
              ),
            ),
          ),
          childCount: widget.statuses.length,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 140,
          mainAxisSpacing: 5,
          crossAxisSpacing: 16,
          childAspectRatio: 2,
          // mainAxisExtent: 100
        ),
      ),
    );
  }
}

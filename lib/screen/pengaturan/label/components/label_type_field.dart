import 'package:css_mobile/data/model/dashboard/sticker_label_model.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class LabelTypeField extends HookWidget {
  final SettingLabelsModel? selectedSticker;

  const LabelTypeField(this.selectedSticker, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 11, bottom: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormLabel(label: 'Pilih Jenis Label Anda'.tr),
          TextField(
            readOnly: true,
            controller: TextEditingController(
              text: selectedSticker?.name ?? '',
            ),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

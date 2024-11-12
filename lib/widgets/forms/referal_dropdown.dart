import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/repository/master/master_repository.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ReferalDropdown extends HookWidget {
  final String? label;
  final String? placeholder;
  final bool isRequired;
  final bool readonly;
  final GroupOwnerModel? value;
  final String? selectedItem;
  final void Function(dynamic) onChanged;
  final VoidCallback? onClear;

  const ReferalDropdown({
    super.key,
    this.label,
    this.isRequired = false,
    this.readonly = false,
    this.value,
    required this.onChanged,
    this.onClear,
    this.selectedItem,
    this.placeholder,
  });

  Future<List<GroupOwnerModel>> getList(String keyword) async {
    final master = Get.find<MasterRepository>();
    var response = await master.getReferals(keyword);
    var models = response.data?.toList();

    return models ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchDropdownField<GroupOwnerModel>(
      asyncItems: (String filter) => getList(filter),
      itemBuilder: (context, e, b) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            e.groupownerName.toString(),
          ),
        );
      },
      showClearButton: true,
      itemAsString: (e) => e.groupownerName.toString(),
      onChanged: onChanged,
      value: value,
      selectedItem: selectedItem,
      hintText: label ?? "Group Owner".tr,
      searchHintText: placeholder ?? 'Masukan minimal 3 karakter'.tr,
      prefixIcon: const Icon(Icons.line_style),
      textStyle: Theme.of(context).textTheme.titleSmall,
      readOnly: readonly,
      isRequired: isRequired,
      onClear: onClear,
    );
  }
}

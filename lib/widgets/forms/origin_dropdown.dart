import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/repository/cek_ongkir/cek_ongkir_repository.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class OriginDropdown extends StatefulHookWidget {
  final String? label;
  final bool isRequired;
  final bool readonly;
  final Origin? value;
  final String? selectedItem;
  final void Function(dynamic)? onChanged;

  const OriginDropdown({
    super.key,
    this.label,
    this.isRequired = true,
    this.readonly = false,
    this.value,
    this.onChanged,
    this.selectedItem,
  });

  @override
  State<OriginDropdown> createState() => _OriginDropdownState();
}

class _OriginDropdownState extends State<OriginDropdown> {
  bool isLoadOrigin = true;
  final ongkir = Get.find<CekOngkirRepository>();

  Future<List<Origin>> getOriginList(String keyword) async {
    var response = await ongkir.getOrigins(keyword);
    var models = response.data?.toList();

    setState(() {
      isLoadOrigin = false;
    });
    return models ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchDropdownField<Origin>(
      asyncItems: (String filter) => getOriginList(filter),
      itemBuilder: (context, e, b) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            e.originName.toString(),
          ),
        );
      },
      itemAsString: (Origin e) => e.originName.toString(),
      onChanged: (value) => widget.onChanged,
      value: widget.value,
      selectedItem: widget.selectedItem,
      hintText: widget.label ?? "Kota Pengiriman".tr,
      searchHintText: widget.label ?? 'Masukan Kota Pengiriman'.tr,
      prefixIcon: const Icon(Icons.location_city),
      textStyle: Theme.of(context).textTheme.titleSmall,
      readOnly: widget.readonly,
      isRequired: widget.isRequired,
    );
  }
}

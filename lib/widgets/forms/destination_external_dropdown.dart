import 'dart:async';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class DestinationExternal {
  String? code;
  String? label;

  DestinationExternal({this.code, this.label});

  DestinationExternal.fromJson(dynamic json)
      : code = json['code'],
        label = json['label'];

  Map<String, dynamic> toJson() => {'code': code, 'label': label};
}

class DestinationExternalDropdown extends StatefulHookWidget {
  final String? label;
  final bool isRequired;
  final bool readOnly;
  final DestinationExternal? value;
  final String? selectedItem;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final bool showfromBottom;
  final TextEditingController? controller;
  final void Function(dynamic)? onSelect;

  const DestinationExternalDropdown({
    super.key,
    this.label,
    this.isRequired = true,
    this.readOnly = false,
    this.value,
    this.onChanged,
    this.selectedItem,
    this.prefixIcon,
    this.suffixIcon,
    this.showfromBottom = false,
    this.controller,
    this.onSelect,
  });

  @override
  State<DestinationExternalDropdown> createState() => _DestinationExternalDropdownState();
}

class _DestinationExternalDropdownState extends State<DestinationExternalDropdown> {
  final searchTextfield = TextEditingController();
  Timer? _debounce;
  bool _showValidationError = false;

  Future<List<DestinationExternal>> getDestinationList(String keyword) async {
    final network = Get.find<NetworkCore>();

    Response response = await network.base.get(
      '/master/destinations/external/${keyword.toUpperCase()}',
      options: Options(extra: {'skipAuth': true}),
    );

    if (response.data['data'] != null && response.data['data'] is List) {
      return (response.data['data'] as List).map((item) => DestinationExternal.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  void dispose() {
    searchTextfield.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query, StateSetter setState) {
    _debounce?.cancel(); // Cancel ongoing timer

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        if (query.length < 3) {
          _showValidationError = true; // Show error when query is short
        } else {
          _showValidationError = false; // Hide error if query is valid
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchDropdownField<DestinationExternal>(
      controller: widget.controller,
      asyncItems: (String filter) => getDestinationList(filter),
      showFromBottom: widget.showfromBottom,
      itemBuilder: (context, e, b) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: widget.showfromBottom ? 20 : 16),
          child: Text(e.label.toString()),
        );
      },
      itemAsString: (e) => e.label.toString(),
      onChanged: widget.onChanged,
      value: widget.value,
      selectedItem: widget.selectedItem,
      hintText: widget.label ?? "Kota Tujuan".tr,
      searchHintText: widget.label ?? 'Masukan Kota Tujuan'.tr,
      prefixIcon: widget.prefixIcon,
      textStyle: Theme.of(context).textTheme.titleSmall,
      readOnly: widget.readOnly,
      isRequired: widget.isRequired,
    );
  }
}

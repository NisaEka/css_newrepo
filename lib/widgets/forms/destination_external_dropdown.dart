import 'dart:async';
import 'package:css_mobile/const/app_const.dart';
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
  State<DestinationExternalDropdown> createState() =>
      _DestinationExternalDropdownState();
}

class _DestinationExternalDropdownState
    extends State<DestinationExternalDropdown> {
  final searchTextfield = TextEditingController();
  Timer? _debounce;
  bool _showValidationError = false;

  Future<List<DestinationExternal>> getDestinationList(String keyword) async {
    final network = Get.find<NetworkCore>();

    Response response = await network.base
        .get('/master/destinations/external/${keyword.toUpperCase()}');

    if (response.data['data'] != null && response.data['data'] is List) {
      return (response.data['data'] as List)
          .map((item) => DestinationExternal.fromJson(item))
          .toList();
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
    return widget.showfromBottom
        ? CustomTextFormField(
            controller: widget.controller,
            hintText: widget.label ?? "Kota Tujuan".tr,
            readOnly: true,
            isRequired: widget.isRequired,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            onChanged: widget.onChanged,
            onTap: () => showCityList('Kota Tujuan'.tr),
          )
        : CustomSearchDropdownField<DestinationExternal>(
            controller: widget.controller,
            asyncItems: (String filter) => getDestinationList(filter),
            itemBuilder: (context, e, b) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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

  void showCityList(String title) {
    setState(() {
      searchTextfield.clear();
      _showValidationError = false; // Reset validation on open
    });

    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color:
                  AppConst.isLightTheme(context) ? whiteColor : greyDarkColor1,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title\n',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CustomSearchField(
                  controller: searchTextfield,
                  hintText: 'Cari'.tr,
                  margin: EdgeInsets.zero,
                  autoFocus: true,
                  validate: _showValidationError,
                  validationText: 'Masukan 3 atau lebih karakter'.tr,
                  onChanged: (value) {
                    _onSearchChanged(value, setState); // Use debounce logic
                  },
                ),
                Expanded(
                  child: FutureBuilder<List<DestinationExternal>>(
                    future: getDestinationList(searchTextfield.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return buildPosts(snapshot.data!, title);
                      } else {
                        return const Center(child: DataEmpty());
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPosts(List<DestinationExternal> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(
            post.label!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            widget.controller?.text = post.label ?? '';
            widget.onSelect?.call(post);
            widget.onChanged?.call(post);
            Get.back();
          },
        );
      },
    );
  }
}

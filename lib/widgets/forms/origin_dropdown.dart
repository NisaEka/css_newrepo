import 'dart:async';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/repository/master/master_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class OriginDropdown extends StatefulHookWidget {
  final String? label;
  final bool isRequired;
  final bool readOnly;
  final OriginModel? value;
  final String? selectedItem;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final bool showfromBottom;
  final TextEditingController? controller;
  final void Function(dynamic)? onSelect;
  final String? branchCode;
  final String? originCode;
  final bool showDialog;
  final bool isOfficer;

  const OriginDropdown({
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
    this.branchCode,
    this.originCode,
    this.showDialog = false,
    this.isOfficer = false,
  });

  @override
  State<OriginDropdown> createState() => _OriginDropdownState();
}

class _OriginDropdownState extends State<OriginDropdown> {
  final searchTextfield = TextEditingController();
  PetugasModel? officer;

  Future<List<OriginModel>> getOriginList(String keyword) async {
    final master = Get.find<MasterRepository>();
    AppLogger.i("branch code : ${widget.branchCode}");
    List<Map<String, dynamic>> whereList = [];
    if (widget.branchCode?.isNotEmpty ?? false) {
      whereList.add({"branchCode": "${widget.branchCode}"});
    }
    if (widget.originCode?.isNotEmpty ?? false) {
      whereList.add({"originCode": "${widget.originCode}"});
    }

    var response = await master.getOrigins(QueryModel(
      search: keyword.toUpperCase(),
      where: whereList,
      table: (widget.branchCode?.isNotEmpty ?? false) ||
          (widget.originCode?.isNotEmpty ?? false),
      relation: true,
    ));
    var models = response.data?.toList();

    return models ?? [];
  }

  Future<List<OriginModel>> getOfficerOriginList() async {
    officer = PetugasModel.fromJson(
        await StorageCore().readData(StorageCore.officerProfile));

    return officer?.origins ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return widget.showfromBottom
        ? CustomTextFormField(
            controller: widget.controller,
            hintText: widget.label ?? "Kota Asal".tr,
            readOnly: true,
            isRequired: true,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            onChanged: widget.onChanged,
            onTap: () => showCityList('Kota Asal'.tr),
          )
        : CustomSearchDropdownField<OriginModel>(
            controller: widget.controller,
            isFilterOnline: !widget.isOfficer,
            asyncItems: (String filter) => widget.isOfficer
                ? getOfficerOriginList()
                : getOriginList(filter),
            itemBuilder: (context, e, b) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  e.originName.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: textColor(context)),
                ),
              );
            },
            itemAsString: (OriginModel e) => e.originName.toString(),
            onChanged: widget.onChanged,
            value: widget.value,
            selectedItem: widget.selectedItem,
            hintText: widget.label ?? "Kota Pengiriman".tr,
            searchHintText: widget.label ?? 'Masukan Kota Pengiriman'.tr,
            prefixIcon: widget.prefixIcon,
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: textColor(context)),
            readOnly: widget.readOnly,
            isRequired: widget.isRequired,
          );
  }

  void showCityList(String title) {
    setState(() {
      searchTextfield.clear();
    });
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: dropDownColor(context),
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
                validationText: 'Masukan 3 atau lebih karakter'.tr,
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 1000), () {
                    getOriginList(value).then((dest) {});
                  });

                  setState(() {});
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: getOriginList(searchTextfield.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final posts = snapshot.data!;
                      if (posts.isEmpty) {
                        return const Center(child: DataEmpty());
                      }
                      return buildPosts(posts, title);
                    } else {
                      return const Center(child: DataEmpty());
                    }
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget buildPosts(List<OriginModel> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(
            post.originName!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            widget.value?.copyWith(
              branchCode: post.branchCode,
              originCode: post.originCode,
              originName: post.originName,
              originStatus: post.originStatus,
            );
            widget.controller?.text = post.originName ?? '';
            Get.back();
          },
        );
      },
    );
  }
}

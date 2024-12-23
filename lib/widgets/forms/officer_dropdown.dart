import 'dart:async';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/repository/transaction/transaction_repository.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class OfficerDropdown extends StatefulHookWidget {
  final String? label;
  final bool isRequired;
  final bool readOnly;
  final PetugasModel? value;
  final String? selectedItem;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final bool showfromBottom;
  final TextEditingController? controller;
  final void Function(dynamic)? onSelect;
  final String? branch;
  final bool showDialog;
  final bool isOfficer;

  const OfficerDropdown({
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
    this.branch,
    this.showDialog = false,
    this.isOfficer = false,
  });

  @override
  State<OfficerDropdown> createState() => _OriginDropdownState();
}

class _OriginDropdownState extends State<OfficerDropdown> {
  final searchTextfield = TextEditingController();
  PetugasModel? officer;

  Future<List<PetugasModel>> getOfficerList(String keyword) async {
    final master = Get.find<TransactionRepository>();
    var response = await master.getTransOfficer(QueryModel(
      search: keyword,
    ));
    var models = response.data?.toList();

    return models ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return widget.showfromBottom
        ? CustomTextFormField(
            controller: widget.controller,
            // items: [],
            hintText: widget.label ?? "Petugas".tr,
            // label: '',
            // textStyle: hintTextStyle,
            readOnly: true,
            isRequired: true,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            onChanged: widget.onChanged,
            onTap: () => showCityList('Petugas'.tr),
          )
        : CustomSearchDropdownField<PetugasModel>(
            controller: widget.controller,
            isFilterOnline: !widget.isOfficer,
            asyncItems: (String filter) => getOfficerList(filter),
            itemBuilder: (context, e, b) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  e.name.toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor(context),
                      ),
                ),
              );
            },
            itemAsString: (PetugasModel e) => e.name.toString(),
            onChanged: widget.onChanged,
            value: widget.value,
            selectedItem: widget.selectedItem,
            hintText: widget.label ?? "Petugas".tr,
            searchHintText: widget.label ?? 'Masukan Nama Petugas'.tr,
            prefixIcon: widget.prefixIcon,
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: formTextColor(context),
                ),
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
            color: AppConst.isLightTheme(context) ? whiteColor : greyDarkColor1,
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
                // onClear: () => setState(()=> searchTextfield.clear()),
                // validate: state.searchCity.text.length < 3,
                margin: EdgeInsets.zero,
                autoFocus: true,
                validationText: 'Masukan 3 atau lebih karakter'.tr,
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 1000), () {
                    getOfficerList(value).then((dest) {});
                  });

                  setState(() {});
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: getOfficerList(searchTextfield.text),
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

  Widget buildPosts(List<PetugasModel> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(
            post.name!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            // widget.value?.copyWith(
            //   branchCode: post.branchCode,
            //   originCode: post.originCode,
            //   originName: post.originName,
            //   originStatus: post.originStatus,
            // );
            widget.controller?.text = post.name ?? '';
            Get.back();
          },
        );
      },
    );
  }
}

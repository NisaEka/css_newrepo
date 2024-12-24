import 'dart:async';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/repository/bank/bank_repository.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class BankDropdown extends StatefulHookWidget {
  final String? label;
  final bool isRequired;
  final bool readOnly;
  final BankModel? value;
  final String? selectedItem;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final bool showfromBottom;
  final TextEditingController? controller;
  final void Function(dynamic)? onSelect;
  final String? bankId;
  final bool showDialog;

  const BankDropdown({
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
    this.bankId,
    this.showDialog = false,
  });

  @override
  State<BankDropdown> createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  final searchTextfield = TextEditingController();
  PetugasModel? officer;

  Future<List<BankModel>> getBankList(String keyword) async {
    final bank = Get.find<BankRepository>();

    var response = await bank.getBanks(QueryModel(
      table: true,
      search: keyword.toUpperCase(),
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
            hintText: widget.label ?? "Bank".tr,
            // label: '',
            // textStyle: hintTextStyle,
            readOnly: true,
            isRequired: true,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            onChanged: widget.onChanged,
            onTap: () => showCityList('Bank'.tr),
          )
        : CustomSearchDropdownField<BankModel>(
            controller: widget.controller,
            isFilterOnline: true,
            asyncItems: (String filter) => getBankList(filter),
            // items: getBankList(),
            itemBuilder: (context, e, b) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  e.bankName.toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor(context),
                      ),
                ),
              );
            },
            itemAsString: (BankModel e) => e.bankName.toString(),
            onChanged: widget.onChanged,
            value: widget.value,
            selectedItem: widget.selectedItem,
            hintText: widget.label ?? "Pilih Nama Bank".tr,
            searchHintText: widget.label ?? 'Masukkan Nama Bank'.tr,
            prefixIcon: widget.prefixIcon,
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? Colors.black
                      : warningColor,
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
                    getBankList(value).then((dest) {});
                  });

                  setState(() {});
                },
              ),
              // const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  // future: getOriginList(state.searchCity.text == '' ? 'jak' : state.searchCity.text),
                  future: getBankList(searchTextfield.text),
                  // initialData: (title == "Kota Asal" || title == "Origin") ? state.originList : state.destinationList,
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

  Widget buildPosts(List<BankModel> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(
            post.bankName!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            // widget.onSelect(post);
            widget.value?.copyWith(
              bankId: post.bankId,
              bankName: post.bankName,
            );
            widget.controller?.text = post.bankName ?? '';
            Get.back();
          },
        );
      },
    );
  }
}

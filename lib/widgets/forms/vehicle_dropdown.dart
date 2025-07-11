import 'dart:async';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/vehicle_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/repository/master/master_repository.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class VehicleDropdown extends StatefulHookWidget {
  final String? label;
  final bool isRequired;
  final bool readOnly;
  final VehicleModel? value;
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

  const VehicleDropdown({
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
  State<VehicleDropdown> createState() => _OriginDropdownState();
}

class _OriginDropdownState extends State<VehicleDropdown> {
  final searchTextfield = TextEditingController();
  PetugasModel? officer;

  Future<List<VehicleModel>> getVehicleList(String keyword) async {
    final master = Get.find<MasterRepository>();

    var response = await master.getVehicles();
    var models = response.data
        ?.where(
          (element) => element.vehicleStatus == "Y",
        )
        .toList();

    return models ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return widget.showfromBottom
        ? CustomTextFormField(
            controller: widget.controller,
            hintText: "Pilih Armada".tr,
            readOnly: true,
            isRequired: true,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            onChanged: widget.onChanged,
            onTap: () => showCityList('Pilih Armadal'.tr),
          )
        : CustomSearchDropdownField<VehicleModel>(
            controller: widget.controller,
            isFilterOnline: !widget.isOfficer,
            asyncItems: (String filter) => getVehicleList(filter),
            showSearchBox: false,
            itemBuilder: (context, e, b) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  e.vehicleName.toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor(context)),
                ),
              );
            },
            itemAsString: (VehicleModel e) => e.vehicleName.toString(),
            onChanged: widget.onChanged,
            value: widget.value,
            selectedItem: widget.selectedItem,
            hintText: widget.label ?? "Pilih Armada".tr,
            searchHintText: widget.label ?? 'Masukan Pilihan Armada'.tr,
            prefixIcon: widget.prefixIcon,
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor(context)),
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
                    getVehicleList(value).then((dest) {});
                  });

                  setState(() {});
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: getVehicleList(searchTextfield.text),
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

  Widget buildPosts(List<VehicleModel> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(
            post.vehicleName!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            widget.value;
            widget.controller?.text = post.vehicleName ?? '';
            Get.back();
          },
        );
      },
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/repository/master/master_repository.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class DestinationDropdown<T> extends StatefulHookWidget {
  final String? label;
  final bool isRequired;
  final bool readOnly;
  final Destination? value;
  final String? selectedItem;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final bool showfromBottom;
  final TextEditingController? controller;
  final void Function(dynamic)? onSelect;
  final String Function(T)? itemAsString;
  final String? displayText;

  const DestinationDropdown({
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
    this.itemAsString,
    this.displayText,
  });

  @override
  State<DestinationDropdown> createState() => _DestinationDropdownState();
}

class _DestinationDropdownState extends State<DestinationDropdown> {
  final searchTextfield = TextEditingController();

  Future<List<Destination>> getDestinationList(String keyword) async {
    final master = Get.find<MasterRepository>();
    var response = await master.getDestinations(QueryParamModel(
        table: true,
        limit: 50,
        search: keyword.toUpperCase(),
        sort: jsonEncode([
          {"id": "asc"}
        ])));
    var models = response.data?.toList();

    return models ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return widget.showfromBottom
        ? CustomTextFormField(
            controller: widget.controller,
            // items: [],
            hintText: widget.label ?? "Kota Tujuan".tr,
            // label: '',
            // textStyle: hintTextStyle,
            readOnly: true,
            isRequired: true,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            onChanged: widget.onChanged,
            onTap: () => showCityList('Kota Tujuan'.tr),
          )
        : CustomSearchDropdownField<Destination>(
            controller: widget.controller,
            asyncItems: (String filter) => getDestinationList(filter),
            itemBuilder: (context, e, b) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text('${e.zipCode == null || e.zipCode == '00000' ? '' : '${e.zipCode}; '}'
                        '${e.provinceName == null ? '' : '${e.provinceName}; '}'
                        '${e.cityName == null ? '' : '${e.cityName}; '}'
                        '${e.districtName == null || e.districtName == '-' ? '' : '${e.districtName}; '}'
                        '${e.subdistrictName == null || e.subdistrictName == '-' ? '' : '${e.subdistrictName}; '}'
                        '${e.destinationCode == null ? '' : '${e.destinationCode}'}'
                    .splitMapJoin(
                  ';',
                  onMatch: (p0) => '; ',
                )),
              );
            },
            itemAsString: widget.itemAsString ??
                (Destination e) => ''
                    '${e.zipCode == null ? '' : '${e.zipCode}; '}'
                    '${e.provinceName == null ? '' : '${e.provinceName}; '}'
                    '${e.cityName == null ? '' : '${e.cityName}; '}'
                    '${e.districtName == null || e.districtName == '-' ? '' : '${e.districtName}; '}'
                    '${e.subdistrictName == null || e.subdistrictName == '-' ? '' : '${e.subdistrictName}; '}'
                    '${e.destinationCode == null ? '' : '${e.destinationCode}; '}',
            // '${e.countryName == null ? '' : '${e.countryName}'}',
            onChanged: widget.onChanged,
            value: widget.value,
            selectedItem: widget.selectedItem,
            hintText: widget.label ?? "Kota Pengiriman".tr,
            searchHintText: widget.label ?? 'Masukan Kota Pengiriman'.tr,
            prefixIcon: widget.prefixIcon,
            textStyle: Theme.of(context).textTheme.titleMedium,
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
                    getDestinationList(value).then((dest) {});
                  });

                  setState(() {});
                },
              ),
              // const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  // future: getOriginList(state.searchCity.text == '' ? 'jak' : state.searchCity.text),
                  future: getDestinationList(searchTextfield.text),
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

  Widget buildPosts(List<Destination> data, String title) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(
            '${post.districtName!}, ${post.cityName!}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            // widget.onSelect(post);
            widget.value?.copyWith(
              id: post.id,
              countryName: post.countryName,
              provinceName: post.provinceName,
              cityName: post.cityName,
              districtName: post.districtName,
              subdistrictName: post.subdistrictName,
              zipCode: post.zipCode,
              destinationCode: post.destinationCode,
              status: post.status,
              facilityCode: post.facilityCode,
              cityZone: post.cityZone,
            );
            widget.controller?.text = post.cityName ?? '';
            Get.back();
          },
        );
      },
    );
  }
}

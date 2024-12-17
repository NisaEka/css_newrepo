import 'package:css_mobile/screen/pantau_paketmu/components/pantau_list_item.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_paketmu_filter.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_status_button.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_total_kiriman.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauCardScreen extends StatelessWidget {
  const PantauCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
        init: PantauPaketmuController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PantauStatusButton(),
                  const SizedBox(height: 5),
                  // Total Kiriman
                  const PantauTotalKiriman(),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                    thickness: 1.0,
                  ),
                  // Pantau List
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.state.isLoading
                          ? 1
                          : controller.state.countList.length,
                      itemBuilder: (context, index) {
                        if (controller.state.isLoading) {
                          return const PantauItems(
                            item: null,
                            isLoading: true,
                          );
                        }
                        var item = controller.state.countList[index];
                        return index != 0
                            ? PantauItems(
                                item: item, index: index, isLoading: false)
                            : const SizedBox();
                      },
                    ),
                  )
                  // Expanded(
                  //     child: ListView(
                  //   children: [
                  //     PantauCountCod(title: 'COD'.tr),
                  //     PantauCountCodOngkir(
                  //       title: 'COD ONGKIR'.tr,
                  //     ),
                  //     PantauCountNonCod(
                  //       title: 'NON COD'.tr,
                  //     ),
                  //   ],
                  // )),
                ],
              ),
            ),
          );
        });
  }

  CustomTopBar _appBarContent(PantauPaketmuController c) {
    return CustomTopBar(
      title: "Pantau Paketmu".tr,
      action: [
        FilterButton(
          filterContent: PantauPaketmuFilter(controller: c),
          isFiltered: c.state.isFiltered.value,
          isApplyFilter:
              (c.state.selectedStatusKiriman.value != "Total Kiriman"),
          onResetFilter: () {
            c.resetFilter();
            Get.back();
          },
          onApplyFilter: () {
            c.applyFilter();
            Get.back();
          },
          onCloseFilter: () {
            Get.back();
          },
        ),
      ],
    );
  }

// Widget _filterContent(PantauPaketmuController c) {
//   return Expanded(
//     child: CustomScrollView(
//       slivers: [
//         SliverToBoxAdapter(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Obx(() => Customradiobutton(
//                 title: "1 Bulan Terakhir".tr,
//                 value: '1',
//                 groupValue: c.state.dateFilter.value,
//                 onChanged: (value) => c.selectDateFilter(1),
//                 onTap: () => c.selectDateFilter(1),
//               )),
//               Obx(() => Customradiobutton(
//                 title: "1 Minggu Terakhir".tr,
//                 value: '2',
//                 groupValue: c.state.dateFilter.value,
//                 onChanged: (value) => c.selectDateFilter(2),
//                 onTap: () => c.selectDateFilter(2),
//               )),
//               Obx(() => Customradiobutton(
//                 title: "Hari Ini".tr,
//                 value: '3',
//                 groupValue: c.state.dateFilter.value,
//                 onChanged: (value) => c.selectDateFilter(3),
//                 onTap: () => c.selectDateFilter(3),
//               )),
//               Obx(() => Customradiobutton(
//                 title: "Pilih Tanggal Sendiri".tr,
//                 value: '4',
//                 groupValue: c.state.dateFilter.value,
//                 onChanged: (value) => c.selectDateFilter(4),
//                 onTap: () => c.selectDateFilter(4),
//               )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomTextFormField(
//                     controller: c.state.startDateField,
//                     readOnly: true,
//                     width: Get.width / 3,
//                     hintText: 'Tanggal Awal'.tr,
//                     onTap: () => c.state.dateFilter.value == '4'
//                         ? c.selectDate().then((value) {
//                       if (value != null) {
//                         if (c.state.endDate.value != null &&
//                             value.isAfter(c.state.endDate.value!)) {
//                           AppSnackBar.error(
//                               'Start date cannot be after end date');
//                           return;
//                         }
//                         c.state.startDate.value = DateTime(value.year,
//                             value.month, value.day, 0, 0, 0);
//                         c.state.startDateField.text = c.state.startDate
//                             .toString()
//                             .toShortDateFormat();
//                       }
//                     })
//                         : null,
//                   ),
//                   CustomTextFormField(
//                     controller: c.state.endDateField,
//                     readOnly: true,
//                     width: Get.width / 3,
//                     hintText: 'Tanggal Akhir'.tr,
//                     onTap: () => c.state.dateFilter.value == '4'
//                         ? c.selectDate().then((value) {
//                       // Set the end date to 23:59
//                       if (value != null) {
//                         c.state.endDate.value = DateTime(value.year,
//                             value.month, value.day, 23, 59, 59);
//                       }
//                       c.state.endDateField.text = c.state.endDate
//                           .toString()
//                           .toShortDateFormat();
//                     })
//                         : null,
//                   ),
//                 ],
//               ),
//               CustomDropDownField(
//                 items: c.state.listOfficerEntry
//                     .map(
//                       (e) => DropdownMenuItem(
//                     value: e,
//                     child: Text(e),
//                   ),
//                 )
//                     .toList(),
//                 label: 'Petugas Entry'.tr,
//                 hintText: 'Petugas Entry'.tr,
//                 value: c.state.selectedPetugasEntry.value,
//                 onChanged: (value) {
//                   c.state.selectedPetugasEntry.value = value as String;
//                 },
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
}

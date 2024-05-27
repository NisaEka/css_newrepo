import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/list_dropshipper_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/offlinebar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class InformasiPengirimScreen extends StatefulWidget {
  const InformasiPengirimScreen({super.key});

  @override
  State<InformasiPengirimScreen> createState() => _InformasiPengirimScreenState();
}

class _InformasiPengirimScreenState extends State<InformasiPengirimScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformasiPengirimController>(
        init: InformasiPengirimController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomTopBar(
                  title: 'Input Transaksi'.tr,
                  leading: CustomBackButton(
                    onPressed: () => Get.offAll(const DashboardScreen()),
                  ),
                  flexibleSpace: Column(
                    children: [
                      CustomStepper(
                        currentStep: 0,
                        totalStep: controller.steps.length,
                        steps: controller.steps,
                      ),
                      const SizedBox(height: 10),
                      controller.isOnline ? const SizedBox() : const OfflineBar(),
                    ],
                  ),
                  action: const [
                    // controller.isOnline
                    //     ? const SizedBox()
                    //     : Tooltip(
                    //         key: controller.offlineTooltipKey,
                    //         triggerMode: TooltipTriggerMode.tap,
                    //         showDuration: const Duration(seconds: 3),
                    //         decoration: ShapeDecoration(
                    //           color: greyColor,
                    //           shape: ToolTipCustomShape(usePadding: false),
                    //         ),
                    //         // textStyle: listTitleTextStyle.copyWith(color: whiteColor),
                    //         message: 'Offline Mode',
                    //         child: Container(
                    //           margin: const EdgeInsets.only(right: 20),
                    //           padding: const EdgeInsets.all(5),
                    //           decoration: BoxDecoration(
                    //             color: successColor,
                    //             borderRadius: BorderRadius.circular(50),
                    //           ),
                    //           child: const Icon(
                    //             Icons.cloud_off,
                    //             color: whiteColor,
                    //           ),
                    //         ),
                    //       )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: controller.formKey,
                              onChanged: () {
                                controller.formValidate();
                                controller.connection.isOnline().then((value) => controller.isOnline = value);
                                controller.update();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFormLabel(label: 'Nomor Akun'.tr),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: controller.isLoading
                                        ? Shimmer(
                                            isLoading: controller.isLoading,
                                            child: Row(
                                              children: List.generate(
                                                3,
                                                (index) => Container(
                                                  width: Get.width / 2,
                                                  height: 80,
                                                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: greyColor,
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            children: controller.accountList
                                                .map(
                                                  (e) => AccountListItem(
                                                    accountID: e.accountId.toString(),
                                                    accountNumber: e.accountNumber.toString(),
                                                    accountName: "${e.accountName.toString()} / ${e.accountType ?? e.accountService}",
                                                    accountType: e.accountService.toString(),
                                                    // isSelected: e.isSelected ?? false,
                                                    isSelected: controller.selectedAccount == e ? true : false,
                                                    onTap: () {
                                                      if (controller.selectedAccount == e && controller.selectedAccount != null) {
                                                        controller.selectedAccount = null;
                                                        controller.update();
                                                      } else {
                                                        controller.selectedAccount = e;
                                                        controller.codOgkir = false;
                                                        controller.update();
                                                      }
                                                      controller.getOriginList('', e.accountId.toString());
                                                      controller.formValidate();
                                                      controller.update();
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                  ),
                                  CustomSwitch(
                                    value: controller.isDropshipper,
                                    label: 'Kirim sebagai dropshipper'.tr,
                                    onChange: (bool? value) {
                                      controller.isDropshipper = value!;

                                      if (value == true) {
                                        if (controller.dropshipper != null && controller.data != null) {
                                          controller.namaPengirim.text = controller.dropshipper?.name ?? '';
                                          controller.nomorTelpon.text = controller.dropshipper?.phone ?? '';
                                          controller.kotaPengirim.text = controller.dropshipper?.city ?? '';
                                          controller.kodePos.text = controller.dropshipper?.zipCode ?? '';
                                          controller.alamatLengkap.text = controller.dropshipper?.address ?? '';
                                          controller
                                              .getOriginList(controller.dropshipper?.city ?? '', controller.selectedAccount?.accountId ?? '')
                                              .then((value) => controller.selectedOrigin = value.first);

                                          controller.isValidate = true;
                                        } else {
                                          controller.namaPengirim.clear();
                                          controller.nomorTelpon.clear();
                                          controller.kotaPengirim.clear();
                                          controller.kodePos.clear();
                                          controller.alamatLengkap.clear();
                                          controller.selectedOrigin = null;
                                          controller.isValidate = false;
                                        }
                                      } else {
                                        controller.namaPengirim.text = controller.senderOrigin?.name ?? '';
                                        controller.nomorTelpon.text = controller.senderOrigin?.phone ?? '';
                                        controller.kotaPengirim.text = controller.senderOrigin?.origin?.originName ?? '';
                                        controller.kodePos.text = controller.senderOrigin?.zipCode ?? '';
                                        controller.alamatLengkap.text = controller.senderOrigin?.address ?? '';
                                        controller.selectedOrigin = Origin(
                                          originCode: controller.senderOrigin?.origin?.originCode,
                                          branchCode: controller.senderOrigin?.origin?.branchCode,
                                          originName: controller.senderOrigin?.origin?.originName,
                                        );
                                        controller.isValidate = true;
                                      }
                                      controller.update();
                                    },
                                  ),
                                  controller.selectedAccount?.accountService == "JLC"
                                      ? CustomSwitch(
                                          value: controller.codOgkir,
                                          label: 'COD Ongkir'.tr,
                                          onChange: (bool? value) {
                                            controller.codOgkir = value!;
                                            controller.update();
                                          },
                                        )
                                      : const SizedBox(),
                                  controller.isDropshipper
                                      ? GestureDetector(
                                          onTap: () => controller.selectedAccount != null
                                              ? Get.to(const ListDropshipperScreen(), arguments: {
                                                  'account': controller.selectedAccount,
                                                })?.then(
                                                  (result) {
                                                    controller.dropshipper = result;
                                                    controller.update();
                                                    controller.getSelectedDropshipper();
                                                  },
                                                )
                                              : Get.showSnackbar(
                                                  GetSnackBar(
                                                    message: 'Pilih Account Terlebih dahulu'.tr,
                                                    backgroundColor: errorColor,
                                                    isDismissible: true,
                                                    duration: const Duration(seconds: 5),
                                                  ),
                                                ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                            margin: const EdgeInsets.symmetric(vertical: 10),
                                            decoration: const BoxDecoration(
                                              border:
                                                  Border(bottom: BorderSide(color: greyColor, width: 2), top: BorderSide(color: greyColor, width: 2)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Lihat Data Dropshipper'.tr),
                                                const Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: redJNE,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  CustomTextFormField(
                                    controller: controller.namaPengirim,
                                    hintText: "Nama Pengirim".tr,
                                    readOnly: !controller.isDropshipper,
                                    isRequired: true,
                                    prefixIcon: const Icon(Icons.person),
                                    validator: ValidationBuilder().name().build(),
                                  ),
                                  CustomTextFormField(
                                    controller: controller.nomorTelpon,
                                    hintText: "Nomor Telepon".tr,
                                    inputType: TextInputType.number,
                                    readOnly: !controller.isDropshipper,
                                    isRequired: true,
                                    prefixIcon: const Icon(Icons.phone),
                                    validator: ValidationBuilder().phoneNumber().build(),
                                  ),
                                  CustomSearchDropdownField<Origin>(
                                    asyncItems: (String filter) => controller.getOriginList(
                                      filter.isNotEmpty ? filter : controller.kotaPengirim.text,
                                      controller.selectedAccount?.accountId ?? '',
                                    ),
                                    itemBuilder: (context, e, b) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        child: Text(
                                          e.originName.toString(),
                                        ),
                                      );
                                    },
                                    itemAsString: (Origin e) => e.originName.toString(),
                                    onChanged: (value) {
                                      controller.selectedOrigin = value;
                                      controller.kotaPengirim.text = controller.selectedOrigin?.originName ?? '';
                                      // controller.kodePos.text = controller.selectedOrigin?.
                                      controller.update();
                                      // print(jsonEncode(value));
                                    },
                                    value: controller.selectedOrigin,
                                    isRequired: controller.isOnline,
                                    selectedItem: controller.kotaPengirim.text,
                                    readOnly: controller.selectedAccount == null || controller.isOnline == false ? true : !controller.isDropshipper,
                                    hintText: controller.isLoadOrigin ? "Loading..." : "Kota Pengirim".tr,
                                    prefixIcon: const Icon(Icons.location_city),
                                    textStyle: controller.selectedOrigin != null ? subTitleTextStyle : hintTextStyle,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.kodePos,
                                    hintText: "Kode Pos".tr,
                                    readOnly: !controller.isDropshipper,
                                    isRequired: true,
                                    prefixIcon: const Icon(Icons.line_style),
                                    validator: ValidationBuilder().zipCode().build(),
                                    inputType: TextInputType.number,
                                  ),
                                  CustomTextFormField(
                                    controller: controller.alamatLengkap,
                                    hintText: "Alamat".tr,
                                    readOnly: !controller.isDropshipper,
                                    isRequired: true,
                                    multiLine: true,
                                    prefixIcon: const Icon(Icons.location_city),
                                    validator: ValidationBuilder().address().build(),
                                  ),
                                  controller.isDropshipper && controller.isOnline && controller.isSaveDropshipper()
                                      ? CustomFilledButton(
                                          color: whiteColor,
                                          borderColor: controller.isValidate ? blueJNE : greyColor,
                                          title: 'Simpan Data Dropshipper'.tr,
                                          fontColor: controller.isValidate ? blueJNE : greyColor,
                                          onPressed: () => controller.isValidate ? controller.saveDropshipper() : null,
                                        )
                                      : const SizedBox(),
                                  CustomFilledButton(
                                    color: controller.isValidate ? blueJNE : greyColor,
                                    title: "Selanjutnya".tr,
                                    // radius: 20,
                                    onPressed: () {
                                      controller.isValidate ? controller.nextStep() : null;
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoadSave ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}

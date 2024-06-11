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
                appBar: _appBarContent(controller),
                body: _bodyContent(controller, context),
              ),
              controller.isLoadSave ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }

  CustomTopBar _appBarContent(InformasiPengirimController c) {
    return CustomTopBar(
      title: 'Input Transaksi'.tr,
      leading: CustomBackButton(
        onPressed: () => Get.offAll(const DashboardScreen()),
      ),
      flexibleSpace: Column(
        children: [
          CustomStepper(
            currentStep: 0,
            totalStep: c.steps.length,
            steps: c.steps,
          ),
          const SizedBox(height: 10),
          c.isOnline ? const SizedBox() : const OfflineBar(),
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
    );
  }

  Widget _bodyContent(InformasiPengirimController c, BuildContext context) {
    return SingleChildScrollView(
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
                  key: c.formKey,
                  onChanged: () {
                    c.formValidate();
                    c.connection.isOnline().then((value) => c.isOnline = value);
                    c.update();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormLabel(label: 'Nomor Akun'.tr),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: c.isLoading
                            ? Row(
                                children: List.generate(
                                  3,
                                  (index) => AccountListItem(isLoading: true),
                                ),
                              )
                            : Row(
                                children: c.accountList
                                    .map(
                                      (e) => AccountListItem(
                                        data: e,
                                        isSelected: c.selectedAccount == e ? true : false,
                                        onTap: () => c.selectAccount(e),
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                      CustomSwitch(
                        value: c.isDropshipper,
                        label: 'Kirim sebagai dropshipper'.tr,
                        onChange: (bool? value) => c.sendAsDropshipper(value),
                      ),
                      c.selectedAccount?.accountService == "JLC"
                          ? CustomSwitch(
                              value: c.codOgkir,
                              label: 'COD Ongkir'.tr,
                              onChange: (bool? value) {
                                c.codOgkir = value!;
                                c.update();
                              },
                            )
                          : const SizedBox(),
                      c.isDropshipper ? _listDropshipperButton(c) : const SizedBox(),
                      CustomTextFormField(
                        controller: c.namaPengirim,
                        hintText: "Nama Pengirim".tr,
                        readOnly: !c.isDropshipper,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.person),
                        validator: ValidationBuilder().name().build(),
                      ),
                      CustomTextFormField(
                        controller: c.nomorTelpon,
                        hintText: "Nomor Telepon".tr,
                        inputType: TextInputType.number,
                        readOnly: !c.isDropshipper,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.phone),
                        validator: ValidationBuilder().phoneNumber().build(),
                      ),
                      CustomSearchDropdownField<Origin>(
                        asyncItems: (String filter) => c.getOriginList(
                          filter.isNotEmpty ? filter : c.kotaPengirim.text,
                          c.selectedAccount?.accountId ?? '',
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
                          c.selectedOrigin = value;
                          c.kotaPengirim.text = c.selectedOrigin?.originName ?? '';
                          // controller.kodePos.text = controller.selectedOrigin?.
                          c.update();
                        },
                        value: c.selectedOrigin,
                        isRequired: c.isOnline,
                        selectedItem: c.kotaPengirim.text,
                        readOnly: c.selectedAccount == null || c.isOnline == false ? true : !c.isDropshipper,
                        hintText: c.isLoadOrigin ? "Loading..." : "Kota Pengirim".tr,
                        prefixIcon: const Icon(Icons.location_city),
                        textStyle: c.selectedOrigin != null ? subTitleTextStyle : hintTextStyle,
                      ),
                      CustomTextFormField(
                        controller: c.kodePos,
                        hintText: "Kode Pos".tr,
                        readOnly: !c.isDropshipper,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.line_style),
                        validator: ValidationBuilder().zipCode().build(),
                        inputType: TextInputType.number,
                      ),
                      CustomTextFormField(
                        controller: c.alamatLengkap,
                        hintText: "Alamat".tr,
                        readOnly: !c.isDropshipper,
                        isRequired: true,
                        multiLine: true,
                        prefixIcon: const Icon(Icons.location_city),
                        validator: ValidationBuilder().address().build(),
                      ),
                      c.isDropshipper && c.isOnline && c.isSaveDropshipper()
                          ? CustomFilledButton(
                              color: whiteColor,
                              borderColor: c.isValidate ? blueJNE : greyColor,
                              title: 'Simpan Data Dropshipper'.tr,
                              fontColor: c.isValidate ? blueJNE : greyColor,
                              onPressed: () => c.isValidate ? c.saveDropshipper() : null,
                            )
                          : const SizedBox(),
                      CustomFilledButton(
                        color: c.isValidate ? blueJNE : greyColor,
                        title: "Selanjutnya".tr,
                        // radius: 20,
                        onPressed: () {
                          c.isValidate ? c.nextStep() : null;
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
    );
  }

  Widget _listDropshipperButton(InformasiPengirimController c) {
    return GestureDetector(
      onTap: () => c.selectedAccount != null
          ? Get.to(const ListDropshipperScreen(), arguments: {
              'account': c.selectedAccount,
            })?.then(
              (result) {
                c.dropshipper = result;
                c.update();
                c.getSelectedDropshipper();
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
          border: Border(bottom: BorderSide(color: greyColor, width: 2), top: BorderSide(color: greyColor, width: 2)),
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
    );
  }
}

import 'package:css_mobile/const/app_const.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_riwayat_kiriman_controller.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_screen.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailRiwayatKirimanScreen extends StatelessWidget {
  const DetailRiwayatKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailRiwayatKirimanController>(
      init: DetailRiwayatKirimanController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: 'Detail Kiriman'.tr),
          body: _bodyContent(controller, context),
          bottomNavigationBar: _bottomContent(controller.transactionModel ?? DataTransactionModel(), controller),
        );
      },
    );
  }

  Widget _bodyContent(DetailRiwayatKirimanController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomTextFormField(
                    controller: c.transStatus,
                    // controller: TextEditingController(text: c.transactionModel?.status?.isNotEmpty.toString() ?? ''),
                    label: 'Status Transaksi'.tr,
                    width: Get.width / 2.5,
                    readOnly: true,
                    hintText: '',
                    backgroundColor: AppConst.isLightTheme(context) ? greyLightColor2 : greyDarkColor2,
                    noBorder: true,
                    isLoading: c.isLoading,
                  ),
                  CustomTextFormField(
                    controller: c.pickupStatus,
                    label: 'Status Pickup'.tr,
                    width: Get.width / 2.5,
                    readOnly: true,
                    hintText: '',
                    backgroundColor: AppConst.isLightTheme(context) ? greyLightColor2 : greyDarkColor2,
                    noBorder: true,
                    isLoading: c.isLoading,
                  ),
                ],
              ),
              Shimmer(
                isLoading: c.transactionModel == null,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: c.isLoading ? greyColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: c.transactionModel?.awb ?? '',
                    drawText: false,
                    height: 120,
                    width: 120,
                    color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                  ),
                ),
              )
            ],
          ),
          Shimmer(
            isLoading: c.transactionModel == null,
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: c.isLoading ? greyColor : (AppConst.isLightTheme(context) ? whiteColor : greyDarkColor2),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: greyLightColor3,
                    spreadRadius: 1,
                    offset: Offset(-2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomLabelText(
                    title: 'Tanggal Pesanan'.tr,
                    value: c.transactionModel?.createdDate?.toLongDateTimeFormat() ?? '',
                    titleTextStyle: listTitleTextStyle.copyWith(fontSize: 10, fontWeight: medium),
                    valueTextStyle: sublistTitleTextStyle.copyWith(fontSize: 10, color: greyColor),
                    alignment: 'end',
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("No Resi".tr, style: itemTextStyle),
                              GestureDetector(
                                onTap: () => Clipboard.setData(ClipboardData(text: c.transactionModel?.awb ?? '')),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    size: 10,
                                    Icons.copy_rounded,
                                    color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text("Tipe".tr, style: itemTextStyle),
                          Text("Service".tr, style: itemTextStyle),
                          Text("Dana COD".tr, style: itemTextStyle),
                          Text("Petugas Entry".tr, style: itemTextStyle),
                          Text("Pengirim".tr, style: itemTextStyle),
                          Text("Kota Pengiriman".tr, style: itemTextStyle),
                          Text("Penerima".tr, style: itemTextStyle),
                          Text("Kontak Penerima".tr, style: itemTextStyle),
                          Row(
                            children: [
                              Text("Order ID".tr, style: itemTextStyle),
                              GestureDetector(
                                onTap: () => Clipboard.setData(ClipboardData(text: c.transactionModel?.orderId ?? '')),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    size: 10,
                                    Icons.copy_rounded,
                                    color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text("Account".tr, style: itemTextStyle),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.transactionModel?.awb ?? '-',
                            style: itemTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          Text(
                            c.transactionModel?.type ?? '-',
                            style: itemTextStyle,
                          ),
                          Text(
                            c.transactionModel?.delivery?.serviceCode ?? '-',
                            style: itemTextStyle,
                          ),
                          Text(
                            'Rp. ${c.transactionModel?.delivery?.flatRate?.toInt().toCurrency() ?? '-'}',
                            style: itemTextStyle,
                          ),
                          Text(
                            c.transactionModel?.officerEntry ?? '-',
                            style: itemTextStyle,
                          ),
                          Text(
                            c.transactionModel?.shipper?.name ?? '-',
                            style: itemTextStyle.copyWith(fontWeight: medium),
                          ),
                          Text(
                            "${c.transactionModel?.receiver?.city} / ${c.transactionModel?.receiver?.district}",
                            style: itemTextStyle,
                          ),
                          Text(
                            c.transactionModel?.receiver?.name ?? '-',
                            style: itemTextStyle,
                          ),
                          Text(
                            c.transactionModel?.receiver?.phone ?? '-',
                            style: itemTextStyle,
                          ),
                          Text(
                            c.transactionModel?.orderId ?? '-',
                            style: itemTextStyle,
                          ),
                          Text(
                            c.transactionModel?.orderId ?? '-',
                            style: itemTextStyle,
                          ),
                          SizedBox(
                            width: Get.width - 200,
                            child: Text(
                              '${c.transactionModel?.account?.accountNumber}/${c.transactionModel?.account?.accountName}/${c.transactionModel?.account?.accountType ?? 'JLC'}',
                              style: itemTextStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          CustomFilledButton(
            color: blueJNE,
            title: 'Lihat Resi'.tr,
            onPressed: () => c.transactionModel != null
                ? Get.to(const LabelScreen(), arguments: {
                    'data': c.transactionModel,
                  })
                : null,
            isLoading: c.isLoading,
          ),
        ],
      ),
    );
  }

  Widget _bottomContent(DataTransactionModel trans, DetailRiwayatKirimanController c) {
    return CustomFilledButton(
      title: trans.status == "MASIH DI KAMU" &&
              trans.account?.accountType != "CASHLESS" &&
              trans.account?.accountService != "JLC" &&
              trans.account?.accountNumber?.substring(0, 1) != "3"
          ? "Edit Kiriman".tr
          : "Hubungi Aku".tr,
      color: trans.status == "MASIH DI KAMU" &&
              trans.account?.accountService != "JLC" &&
              trans.account?.accountType != "CASHLESS" &&
              trans.account?.accountNumber?.substring(0, 1) != "3"
          ? successLightColor3
          : errorLightColor3,
      margin: const EdgeInsets.all(20),
      isLoading: c.isLoading,
      onPressed: () {
        if (trans.status == "MASIH DI KAMU" &&
            trans.account?.accountService != "JLC" &&
            trans.account?.accountType != "CASHLESS" &&
            trans.account?.accountNumber?.substring(0, 1) != "3") {
          Get.to(
            const InformasiPengirimScreen(),
            arguments: {
              'data': c.transactionModel,
            },
          );
        }
      },
    );
  }
}

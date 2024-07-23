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
                boxShadow: [
                  BoxShadow(
                    color: AppConst.isLightTheme(context) ? greyLightColor3 : greyDarkColor2,
                    spreadRadius: 1,
                    offset: const Offset(-2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomLabelText(
                    title: 'Tanggal Pesanan'.tr,
                    value: c.transactionModel?.createdDate?.toLongDateTimeFormat() ?? '-',
                    titleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10, fontWeight: medium),
                    valueTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10),
                    alignment: 'end',
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("No Resi".tr, style: Theme.of(context).textTheme.bodySmall),
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
                          Text("Tipe".tr, style: Theme.of(context).textTheme.bodySmall),
                          Text("Service".tr, style: Theme.of(context).textTheme.bodySmall),
                          Text("Dana COD".tr, style: Theme.of(context).textTheme.bodySmall),
                          Text("Petugas Entry".tr, style: Theme.of(context).textTheme.bodySmall),
                          Text("Pengirim".tr, style: Theme.of(context).textTheme.bodySmall),
                          Text("Kota Pengiriman".tr, style: Theme.of(context).textTheme.bodySmall),
                          Text("Penerima".tr, style: Theme.of(context).textTheme.bodySmall),
                          Text("Kontak Penerima".tr, style: Theme.of(context).textTheme.bodySmall),
                          Row(
                            children: [
                              Text("Order ID".tr, style: Theme.of(context).textTheme.bodySmall),
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
                          Text("Account".tr, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.transactionModel?.awb ?? '-',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: medium,
                                ),
                          ),
                          Text(
                            c.transactionModel?.type ?? '-',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            c.transactionModel?.delivery?.serviceCode ?? '-',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Rp. ${c.transactionModel?.delivery?.flatRate?.toInt().toCurrency() ?? '-'}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            c.transactionModel?.officerEntry ?? '-',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            c.transactionModel?.shipper?.name ?? '-',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: medium),
                          ),
                          Text(
                            "${c.transactionModel?.receiver?.city} / ${c.transactionModel?.receiver?.district}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            c.transactionModel?.receiver?.name ?? '-',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            c.transactionModel?.receiver?.phone ?? '-',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            c.transactionModel?.orderId ?? '-',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            width: Get.width - 200,
                            child: Text(
                              '${c.transactionModel?.account?.accountNumber}/${c.transactionModel?.account?.accountName}/${c.transactionModel?.account?.accountType ?? 'JLC'}',
                              style: Theme.of(context).textTheme.bodySmall,
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

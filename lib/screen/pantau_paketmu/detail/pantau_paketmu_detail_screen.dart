import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_screen.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/screen/pantau_paketmu/detail/pantau_paketmu_detail_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/hubungi_aku_dialog.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/util/ext/string_ext.dart';

class PantauPaketmuDetailScreen extends StatelessWidget {
  const PantauPaketmuDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PantauPaketmuDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Detail Transaksi".tr),
          body: _detailBody(context, controller),
        );
      },
    );
  }

  Widget _detailBody(
      BuildContext context, PantauPaketmuDetailController controller) {
    if (controller.showLoadingIndicator) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    if (controller.showEmptyContainer) {
      return const Center(child: Text("Not Found"));
    }

    if (controller.showErrorContainer) {
      return const Center(child: Text("Error"));
    }

    if (controller.showContent) {
      return _mainContent(context, controller);
    }

    return Container();
  }

  Widget _mainContent(
      BuildContext context, PantauPaketmuDetailController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCodeLabel(
                          label: controller.pantauPaketmu.awbNo,
                          isLoading: false,
                        ),
                        Row(
                          children: [
                            CustomFilledButton(
                              color: warningColor,
                              isTransparent: true,
                              prefixIcon: Icons.phone,
                              width: 40,
                              height: 40,
                              fontSize: 19,
                              isLoading: false,
                              onPressed: () async {
                                Get.bottomSheet(
                                  enableDrag: true,
                                  isDismissible: true,
                                  // isScrollControlled: true,
                                  StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return HubungiAkuDialog(
                                        awb: controller.pantauPaketmu.awbNo);
                                  }),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            CustomFilledButton(
                              color: errorColor,
                              isTransparent: true,
                              prefixIcon: Icons.print,
                              width: 40,
                              height: 40,
                              fontSize: 19,
                              isLoading: false,
                              onPressed: () {
                                Get.to(const LabelScreen(), arguments: {
                                  'data': controller.transactionData,
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Informasi Transaksi'.tr,
                        style: listTitleTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow("Nomor Akun", controller.pantauPaketmu.custNo,
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Nama Akun", controller.pantauPaketmu.custName,
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Order Id",
                        controller.pantauPaketmu.transaction?.orderId ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow(
                        "Petugas Entry",
                        controller.pantauPaketmu.transaction?.petugasEntry ??
                            "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Tanggal Transaksi",
                        controller.pantauPaketmu.createDate.toDateTimeFormat(),
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow(
                        "Tangal Serah Terima / Pickup",
                        controller.pantauPaketmu.hoCourierDate
                                ?.toDateTimeFormat() ??
                            controller.pantauPaketmu.puLastAttempStatusDate
                                ?.toDateTimeFormat() ??
                            "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 16),
                    const Divider(
                      color: greyLightColor3,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Detail Kiriman'.tr,
                        style: listTitleTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow("Nama Pengirim",
                        controller.pantauPaketmu.cnoteShipperName,
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Nama Penerima",
                        controller.pantauPaketmu.cnoteReceiverName,
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Alamat Penerima",
                        '${controller.pantauPaketmu.cnoteReceiverAddr1}${controller.pantauPaketmu.cnoteReceiverAddr2}${controller.pantauPaketmu.cnoteReceiverAddr3}',
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Kota Tujuan Penerima",
                        controller.pantauPaketmu.destinationName,
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Isi Kiriman",
                        controller.pantauPaketmu.awbGoodsDescr ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Special Instructions",
                        controller.pantauPaketmu.awbSpecialIns ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow(
                        "Berat Kiriman",
                        controller.pantauPaketmu.weightAwb != null
                            ? '${controller.pantauPaketmu.weightAwb?.toDouble().toString()} KG'
                            : "- KG",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Service", controller.pantauPaketmu.service,
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Nominal COD",
                        'Rp. ${controller.pantauPaketmu.codAmount?.toCurrency().toString()}',
                        style: listTitleTextStyle.copyWith(color: blueJNE)),
                    const SizedBox(height: 6),
                    _textRow("Nominal Asuransi",
                        'Rp. ${controller.pantauPaketmu.awbInsuranceValue?.toCurrency().toString()}',
                        style: listTitleTextStyle.copyWith(color: blueJNE)),
                    const SizedBox(height: 6),
                    _textRow("Ongkos Kirim",
                        'Rp. ${controller.pantauPaketmu.awbAmount?.toCurrency().toString()}',
                        style: listTitleTextStyle.copyWith(color: blueJNE)),
                    const SizedBox(height: 16),
                    const Divider(
                      color: greyLightColor3,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Informasi Pengantaran'.tr,
                        style: listTitleTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow(
                        "Tanggal Status Pengantaran",
                        controller.pantauPaketmu.tglReceived
                            ?.toDateTimeFormat(),
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Status Pengantaran",
                        controller.pantauPaketmu.statusPod ?? "-"),
                    const SizedBox(height: 6),
                    _textRow("Deskripsi Status",
                        controller.pantauPaketmu.codingPod ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Keterangan Status Penerima",
                        controller.pantauPaketmu.receivedReason ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Bukti Foto Penerima",
                        controller.pantauPaketmu.podlEpodUrlPic ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    const SizedBox(height: 6),
                    _textRow("Bukti Tanda Tangan Penerima",
                        controller.pantauPaketmu.podlEpodUrl ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                    if (controller.pantauPaketmu.codFlag == 'Y') ...[
                      const SizedBox(height: 16),
                      const Divider(
                        color: greyLightColor3,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            right: 20), // Margin between the two text widgets
                        child: Text(
                          'Informasi Pembayaran'.tr,
                          style: listTitleTextStyle.copyWith(
                            color: AppConst.isLightTheme(context)
                                ? blueJNE
                                : whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _textRow("Reff ID",
                          controller.pantauPaketmu.repcssPaymentReffid ?? "-",
                          style:
                              listTitleTextStyle.copyWith(fontWeight: regular)),
                      const SizedBox(height: 6),
                      _textRow(
                          "Tanggal Pembayaran",
                          controller.pantauPaketmu.repcssPaymentDate
                                  ?.toDateTimeFormat() ??
                              "-"),
                    ],
                    const SizedBox(height: 16),
                    const Divider(
                      color: greyLightColor3,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Informasi Tiket Laporan'.tr,
                        style: listTitleTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow("No Tiket Laporan",
                        controller.pantauPaketmu.ticket?.id ?? "-",
                        style:
                            listTitleTextStyle.copyWith(fontWeight: regular)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _textRow(String title, String? value, {TextStyle? style}) {
    if (value == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Spread the columns
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          // Ensures that the title takes up only as much space as it needs
          child: Text(
            title.tr,
            style: sublistTitleTextStyle,
          ),
        ),
        Expanded(
          // Makes the value take the rest of the space in the row
          child: Text(
            value,
            style: style ?? listTitleTextStyle,
            textAlign: TextAlign.start, // Align the value to the right
          ),
        ),
      ],
    );
  }
}

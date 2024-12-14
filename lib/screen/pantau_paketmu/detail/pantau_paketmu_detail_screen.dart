import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_screen.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/screen/pantau_paketmu/detail/pantau_paketmu_detail_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/hubungi_aku_dialog.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
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
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
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
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter setState) {
                                  return HubungiAkuDialog(
                                    awb: controller.pantauPaketmu.awbNo,
                                    allow: controller.allow ?? MenuModel(),
                                  );
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
                  Shimmer(
                    isLoading: controller.isLoading,
                    child: Container(
                      color:
                          controller.isLoading ? greyColor : Colors.transparent,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Informasi Transaksi'.tr,
                        style: listTitleTextStyle.copyWith(
                          color:
                              AppConst.isLightTheme(context) ? blueJNE : warningColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _textRow(
                    context,
                    "Nomor Akun",
                    controller.pantauPaketmu.custNo ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Nama Akun",
                    controller.pantauPaketmu.custName ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Order Id",
                    controller.pantauPaketmu.transaction?.orderId ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Petugas Entry",
                    controller.pantauPaketmu.transaction?.petugasEntry ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Tanggal Transaksi",
                    controller.pantauPaketmu.createDate.toDateTimeFormat(),
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Tanggal Serah Terima / Pickup",
                    controller.pantauPaketmu.hoCourierDate
                            ?.toDateTimeFormat() ??
                        controller.pantauPaketmu.puLastAttempStatusDate
                            ?.toDateTimeFormat() ??
                        "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: greyLightColor3,
                  ),
                  const SizedBox(height: 16),
                  Shimmer(
                    isLoading: controller.isLoading,
                    child: Container(
                      color:
                          controller.isLoading ? greyColor : Colors.transparent,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Detail Kiriman'.tr,
                        style: listTitleTextStyle.copyWith(
                          color:
                              AppConst.isLightTheme(context) ? blueJNE : warningColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _textRow(
                    context,
                    "Nama Pengirim",
                    controller.pantauPaketmu.cnoteShipperName ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Nama Penerima",
                    controller.pantauPaketmu.cnoteReceiverName ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Alamat Penerima",
                    '${controller.pantauPaketmu.cnoteReceiverAddr1 ?? ''}${controller.pantauPaketmu.cnoteReceiverAddr2 ?? ''}${controller.pantauPaketmu.cnoteReceiverAddr3 ?? ''}',
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Kota Tujuan Penerima",
                    controller.pantauPaketmu.destinationName ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Isi Kiriman",
                    controller.pantauPaketmu.awbGoodsDescr ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Special Instructions",
                    controller.pantauPaketmu.awbSpecialIns ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Berat Kiriman",
                    controller.pantauPaketmu.weightAwb != null
                        ? '${controller.pantauPaketmu.weightAwb?.toDouble().toString()} KG'
                        : "- KG",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Service",
                    controller.pantauPaketmu.service,
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                      context,
                      "Nominal COD",
                      'Rp. ${controller.pantauPaketmu.codAmount?.toCurrency().toString() ?? '0'}',
                      controller.isLoading,
                      style: listTitleTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : Colors.lightBlueAccent)),
                  const SizedBox(height: 6),
                  _textRow(
                      context,
                      "Nominal Asuransi",
                      'Rp. ${controller.pantauPaketmu.awbInsuranceValue?.toCurrency().toString() ?? '0'}',
                      controller.isLoading,
                      style: listTitleTextStyle.copyWith(
                        color:
                            AppConst.isLightTheme(context) ? blueJNE : Colors.lightBlueAccent,
                      )),
                  const SizedBox(height: 6),
                  _textRow(
                      context,
                      "Ongkos Kirim",
                      'Rp. ${controller.pantauPaketmu.awbAmount?.toCurrency().toString() ?? '0'}',
                      controller.isLoading,
                      style: listTitleTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : Colors.lightBlueAccent)),
                  const SizedBox(height: 16),
                  const Divider(
                    color: greyLightColor3,
                  ),
                  const SizedBox(height: 16),
                  Shimmer(
                    isLoading: controller.isLoading,
                    child: Container(
                      color:
                          controller.isLoading ? greyColor : Colors.transparent,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Informasi Pengantaran'.tr,
                        style: listTitleTextStyle.copyWith(
                          color:
                              AppConst.isLightTheme(context) ? blueJNE : warningColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _textRow(
                    context,
                    "Tanggal Status Pengantaran",
                    controller.pantauPaketmu.tglReceived?.toDateTimeFormat(),
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Status Pengantaran",
                    controller.pantauPaketmu.statusPod ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Deskripsi Status",
                    controller.pantauPaketmu.codingPod ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Keterangan Status Penerima",
                    controller.pantauPaketmu.receivedReason ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Bukti Foto Penerima",
                    controller.pantauPaketmu.podlEpodUrlPic ?? "-",
                    controller.isLoading,
                  ),
                  const SizedBox(height: 6),
                  _textRow(
                    context,
                    "Bukti Tanda Tangan Penerima",
                    controller.pantauPaketmu.podlEpodUrl ?? "-",
                    controller.isLoading,
                  ),
                  if (controller.pantauPaketmu.codFlag == 'Y') ...[
                    const SizedBox(height: 16),
                    const Divider(
                      color: greyLightColor3,
                    ),
                    const SizedBox(height: 16),
                    Shimmer(
                      isLoading: controller.isLoading,
                      child: Container(
                        color: controller.isLoading
                            ? greyColor
                            : Colors.transparent,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            right: 20), // Margin between the two text widgets
                        child: Text(
                          'Informasi Pembayaran'.tr,
                          style: listTitleTextStyle.copyWith(
                            color: AppConst.isLightTheme(context)
                                ? blueJNE
                                : warningColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow(
                      context,
                      "Reff ID",
                      controller.pantauPaketmu.repcssPaymentReffid ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Tanggal Pembayaran",
                      controller.pantauPaketmu.repcssPaymentDate
                              ?.toDateTimeFormat() ??
                          "-",
                      controller.isLoading,
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Divider(
                    color: greyLightColor3,
                  ),
                  const SizedBox(height: 16),
                  Shimmer(
                    isLoading: controller.isLoading,
                    child: Container(
                      color:
                          controller.isLoading ? greyColor : Colors.transparent,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Informasi Tiket Laporan'.tr,
                        style: listTitleTextStyle.copyWith(
                          color:
                              AppConst.isLightTheme(context) ? blueJNE : warningColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _textRow(
                    context,
                    "No Tiket Laporan",
                    controller.pantauPaketmu.ticket?.id ?? "-",
                    controller.isLoading,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _textRow(
      BuildContext context, String title, String? value, bool isLoading,
      {TextStyle? style}) {
    if (value == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Spread the columns
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // Ensures that the title takes up only as much space as it needs
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              color: isLoading ? greyColor : Colors.transparent,
              child: Text(
                title.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: regular),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          // Makes the value take the rest of the space in the row
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              color: isLoading ? greyColor : Colors.transparent,
              child: Text(
                value,
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: regular),
                textAlign: TextAlign.start, // Align the value to the right
              ),
            ),
          ),
        )
      ],
    );
  }
}

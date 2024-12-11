import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/screen/invoice/cnote/invoice_cnote_screen.dart';
import 'package:css_mobile/screen/invoice/detail/invoice_detail_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:css_mobile/widgets/items/text_col_item.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InvoiceDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Detail Invoice".tr),
          body: RefreshIndicator(
            color: Theme.of(context).colorScheme.outline,
            onRefresh: () => Future.sync(() => controller.refreshInvoice()),
            child: _detailBody(context, controller),
          ),
        );
      },
    );
  }

  Widget _detailBody(BuildContext context, InvoiceDetailController controller) {
    if (controller.showLoadingIndicator) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.outline,
        ),
      );
    }

    if (controller.showEmptyContent) {
      return const Center(child: Text("Not Found"));
    }

    if (controller.showErrorContent) {
      return const Center(child: Text("Error"));
    }

    if (controller.showMainContent) {
      return _mainContent(context, controller);
    }

    return Container();
  }

  Widget _mainContent(
      BuildContext context, InvoiceDetailController controller) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Get.to(const InvoiceCnoteScreen(), arguments: {
              "invoice_number":
                  controller.invoiceDetailModel!.invoiceNumberEncoded!
            });
          },
          child: Container(
            color: blueJNE,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Lihat Daftar Transaksi".tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: whiteColor, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_circle_right, color: whiteColor),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              // _viewAwbList(
              //   context,
              //   controller.invoiceDetailModel!.invoiceNumberEncoded!,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 30, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCodeLabel(
                      label:
                          controller.invoiceDetailModel!.invoiceNumberEncoded!,
                      isLoading: false,
                      alignment: MainAxisAlignment.start,
                    ),
                    Text(
                      '*CCNC Invoice - NA*',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _basicSection(context, controller.invoiceDetailModel!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  "Informasi Customer",
                  style: listTitleTextStyle.copyWith(
                    color:
                        AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    _customerSection(context, controller.invoiceDetailModel!),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: DottedLine(
                  dashColor: greyLightColor3,
                  dashLength: 4.0,
                  dashGapLength: 2.0,
                  lineThickness: 1.0,
                  lineLength: double.infinity,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                ),
                child: Text(
                  "Informasi Tagihan",
                  style: listTitleTextStyle.copyWith(
                    color:
                        AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _paymentSection(context, controller.invoiceDetailModel!),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _basicSection(BuildContext context, InvoiceDetailModel invoiceDetail) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "Invoice Date".tr,
              value: invoiceDetail.invoiceDate,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Term Of Payment".tr,
              value: invoiceDetail.top,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Due Date".tr,
              value: invoiceDetail.dueDate,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Periode".tr,
              value: invoiceDetail.period,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Invoice Status".tr,
              value: invoiceDetail.invoiceStatus,
              valueStyle: TextStyle(fontWeight: bold, color: successColor),
            ),
            TextColItem(
              title: "Invoice Reference".tr,
              value: invoiceDetail.invoiceReference,
              lastItem: true,
            ),
            const SizedBox(height: 10),
            const Divider(
              color: greyLightColor3,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deskripsi",
                    style: listTitleTextStyle.copyWith(
                      color:
                          AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    invoiceDetail.description ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: regular),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: greyLightColor3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customerSection(
      BuildContext context, InvoiceDetailModel invoiceDetailModel) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "Customer Id".tr,
              value: invoiceDetailModel.customerId,
              valueStyle: TextStyle(
                fontWeight: bold,
                color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
              ),
            ),
            TextColItem(
              title: "Customer Name".tr,
              value: invoiceDetailModel.customerName,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Address".tr,
              value: invoiceDetailModel.address,
            ),
            TextColItem(
              title: "Zip Code".tr,
              value: invoiceDetailModel.zipCode,
            ),
            TextColItem(
              title: "Phone".tr,
              value: invoiceDetailModel.phone,
            ),
            TextColItem(
              title: "Email".tr,
              value: invoiceDetailModel.email,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: greyLightColor3,
            ),
            const SizedBox(
              height: 10,
            ),
            TextColItem(
              title: "Tax Number".tr,
              value: invoiceDetailModel.taxNumber,
            ),
            TextColItem(
              title: "Npwp Id".tr,
              value: invoiceDetailModel.npwpId,
            ),
            TextColItem(
              title: "Npwp Name".tr,
              value: invoiceDetailModel.npwpName,
            ),
            TextColItem(
              title: "Npwp Address".tr,
              value: invoiceDetailModel.npwpAddress,
              lastItem: true,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentSection(
      BuildContext context, InvoiceDetailModel invoiceDetail) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "Gross Total".tr,
              value: "Rp${invoiceDetail.grossTotal?.toCurrency()}",
              titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
              valueStyle: TextStyle(
                fontWeight: bold,
                color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
              ),
            ),
            TextColItem(
              title: "Discount".tr,
              value: "Rp${invoiceDetail.discount?.toCurrency()}",
            ),
            TextColItem(
              title: "Reward".tr,
              value: "Rp${invoiceDetail.reward?.toCurrency()}",
            ),
            TextColItem(
              title: "Total After Discount".tr,
              value: "Rp${invoiceDetail.totalAfterDiscount?.toCurrency()}",
              titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
              valueStyle: TextStyle(fontWeight: bold, color: redJNE),
            ),
            TextColItem(
              title: "VAT".tr,
              value: "Rp${invoiceDetail.vat?.toCurrency()}",
            ),
            TextColItem(
              title: "Commission Fee".tr,
              value: "Rp${invoiceDetail.commissionFee?.toCurrency()}",
            ),
            TextColItem(
              title: "VAT Commission Fee".tr,
              value: "Rp${invoiceDetail.vatCommissionFee?.toCurrency()}",
            ),
            TextColItem(
              title: "Insurance".tr,
              value: "Rp${invoiceDetail.insurance?.toCurrency()}",
            ),
            TextColItem(
              title: "Stamp".tr,
              value: "Rp${invoiceDetail.stamp?.toCurrency()}",
            ),
            const SizedBox(height: 10),
            const DottedLine(
              dashColor: greyLightColor3,
              dashLength: 4.0,
              dashGapLength: 2.0,
              lineThickness: 1.0,
              lineLength: double.infinity,
            ),
            const SizedBox(height: 10),
            TextColItem(
              title: "Total Paid".tr,
              value: "Rp${invoiceDetail.totalPaid?.toCurrency()}",
              lastItem: true,
              titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
              valueStyle: TextStyle(fontWeight: bold, color: successColor),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _viewAwbList(BuildContext context, String encodedInvoiceNumber) {
  //   return GestureDetector(
  //     behavior: HitTestBehavior.translucent,
  //     onTap: () {
  //       Get.to(const InvoiceCnoteScreen(),
  //           arguments: {"invoice_number": encodedInvoiceNumber});
  //     },
  //     child: Container(
  //       color: blueJNE,
  //       child: Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Lihat Daftar Transaksi".tr,
  //               style: Theme.of(context).textTheme.titleMedium?.copyWith(color: whiteColor, fontWeight: FontWeight.normal),
  //             ),
  //             const SizedBox(width: 5),
  //             const Icon(Icons.arrow_circle_right, color: whiteColor),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

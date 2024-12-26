import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/invoice/cnote/invoice_cnote_screen.dart';
import 'package:css_mobile/screen/invoice/components/invoice.dart';
import 'package:css_mobile/screen/invoice/detail/invoice_detail_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              AppLogger.i('Print button clicked!');
              // Generate the invoice PDF
              final pdf = await generateInvoice(
                  PdfPageFormat.a4,
                  Invoice(
                      invoiceNumber:
                          controller.invoiceDetailModel?.invoiceNumber ?? '-',
                      invoiceDate:
                          controller.invoiceDetailModel?.invoiceDate ?? '-',
                      top: controller.invoiceDetailModel?.top ?? '-',
                      dueDate: controller.invoiceDetailModel?.dueDate ?? '-',
                      period: controller.invoiceDetailModel?.period ?? '-',
                      customerId:
                          controller.invoiceDetailModel?.customerId ?? '-',
                      customerName:
                          controller.invoiceDetailModel?.customerName ?? '-',
                      address: controller.invoiceDetailModel?.address ?? '-',
                      phone: controller.invoiceDetailModel?.phone ?? '-',
                      email: controller.invoiceDetailModel?.email ?? '-',
                      zipCode: controller.invoiceDetailModel?.zipCode ?? '-',
                      taxNumber:
                          controller.invoiceDetailModel?.taxNumber ?? '-',
                      npwpId: controller.invoiceDetailModel?.npwpId ?? '-',
                      npwpName: controller.invoiceDetailModel?.npwpName ?? '-',
                      npwpAddress:
                          controller.invoiceDetailModel?.npwpAddress ?? '-',
                      description:
                          controller.invoiceDetailModel?.description ?? '-',
                      grossTotal:
                          controller.invoiceDetailModel?.grossTotal ?? 0,
                      discount: controller.invoiceDetailModel?.discount ?? 0,
                      totalAfterDiscount:
                          controller.invoiceDetailModel?.totalAfterDiscount ??
                              0,
                      vat: controller.invoiceDetailModel?.vat ?? 0,
                      insurance: controller.invoiceDetailModel?.insurance ?? 0,
                      stamp: controller.invoiceDetailModel?.stamp ?? 0,
                      totalPaid:
                          controller.invoiceDetailModel?.totalPaid ?? 0));

              // Preview or share the PDF using the Printing package
              await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async => pdf);
            },
            backgroundColor: primaryColor(context),
            child:
                const Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _detailBody(BuildContext context, InvoiceDetailController controller) {
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
            Get.to(() => const InvoiceCnoteScreen(), arguments: {
              "invoice_number":
                  controller.invoiceDetailModel!.invoiceNumberEncoded!
            });
          },
          child: Container(
            color: primaryColor(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Lihat Daftar Transaksi".tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: whiteColor, fontWeight: FontWeight.bold),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Shimmer(
                      isLoading: controller.isLoading,
                      child: Container(
                        color: controller.isLoading
                            ? greyColor
                            : Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                          .invoiceDetailModel?.invoiceNumber ??
                                      '',
                                  style: appTitleTextStyle.copyWith(
                                      fontWeight: bold,
                                      color: primaryColor(context)),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  controller.invoiceDetailModel?.invoiceType ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          fontSize: 9,
                                          fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () => Clipboard.setData(ClipboardData(
                                  text: controller
                                          .invoiceDetailModel?.invoiceNumber ??
                                      '')),
                              icon: const Icon(Icons.copy_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow(
                      context,
                      "Invoice Date".tr,
                      controller.invoiceDetailModel!.invoiceDate,
                      controller.isLoading,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Term Of Payment".tr,
                      controller.invoiceDetailModel!.top,
                      controller.isLoading,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Due Date".tr,
                      controller.invoiceDetailModel!.dueDate,
                      controller.isLoading,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Period".tr,
                      controller.invoiceDetailModel!.period,
                      controller.isLoading,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                        context,
                        "Invoice Status".tr,
                        controller.invoiceDetailModel?.invoiceStatus ?? "-",
                        controller.isLoading,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? successColor
                                      : successLightColor1,
                                )),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Invoice Reference".tr,
                      controller.invoiceDetailModel?.invoiceReference ?? '-',
                      controller.isLoading,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
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
                          'Deskripsi'.tr,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: primaryColor(context),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Shimmer(
                      isLoading: controller.isLoading,
                      child: Container(
                        color: controller.isLoading
                            ? greyColor
                            : Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.invoiceDetailModel?.description ?? '-',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: regular,
                                  ),
                        ),
                      ),
                    ),
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
                          'Informasi Customer'.tr,
                          style: listTitleTextStyle.copyWith(
                            color: primaryColor(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow(
                        context,
                        "Customer Id".tr,
                        controller.invoiceDetailModel?.customerId ?? "-",
                        controller.isLoading,
                        style: listTitleTextStyle.copyWith(
                          color: primaryColor(context),
                        )),
                    const SizedBox(height: 6),
                    _textRow(
                        context,
                        "Customer Name".tr,
                        controller.invoiceDetailModel?.customerName ?? "-",
                        controller.isLoading,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Address".tr,
                      controller.invoiceDetailModel?.address ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "ZIP Code".tr,
                      controller.invoiceDetailModel?.zipCode ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Phone".tr,
                      controller.invoiceDetailModel?.phone ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Email".tr,
                      controller.invoiceDetailModel?.email ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 16),
                    const DottedLine(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 2.0,
                      dashColor: greyLightColor3,
                      dashGapLength: 2.0,
                    ),
                    const SizedBox(height: 16),
                    _textRow(
                      context,
                      "Tax Number".tr,
                      controller.invoiceDetailModel?.taxNumber ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "NPWP ID".tr,
                      controller.invoiceDetailModel?.npwpId ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "NPWP Name".tr,
                      controller.invoiceDetailModel?.npwpName ?? "-",
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "NPWP Address".tr,
                      controller.invoiceDetailModel?.npwpAddress ?? "-",
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
                        color: controller.isLoading
                            ? greyColor
                            : Colors.transparent,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            right: 20), // Margin between the two text widgets
                        child: Text(
                          'Informasi Tagihan'.tr,
                          style: listTitleTextStyle.copyWith(
                            color: primaryColor(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textRow(
                      context,
                      "Gross Total".tr,
                      'Rp. ${controller.invoiceDetailModel?.grossTotal!.toCurrency() ?? "-"}',
                      controller.isLoading,
                      style: listTitleTextStyle.copyWith(
                        color: primaryColor(context),
                      ),
                      titleFontWeight: bold,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Discount".tr,
                      'Rp. ${controller.invoiceDetailModel?.discount!.toCurrency() ?? "-"}',
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Total After Discount".tr,
                      'Rp. ${controller.invoiceDetailModel?.totalAfterDiscount!.toCurrency() ?? "-"}',
                      controller.isLoading,
                      style: listTitleTextStyle.copyWith(
                        color: AppConst.isLightTheme(context)
                            ? errorColor
                            : warningColor,
                      ),
                      titleFontWeight: bold,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                        context,
                        "VAT".tr,
                        'Rp. ${controller.invoiceDetailModel?.vat!.toCurrency() ?? "-"}',
                        controller.isLoading),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Commission / Fee".tr,
                      'Rp. ${controller.invoiceDetailModel?.commissionFee!.toCurrency() ?? "-"}',
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "VAT Commission / Fee".tr,
                      'Rp. ${controller.invoiceDetailModel?.vatCommissionFee!.toCurrency() ?? "-"}',
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Insurance".tr,
                      'Rp. ${controller.invoiceDetailModel?.insurance!.toCurrency() ?? "-"}',
                      controller.isLoading,
                    ),
                    const SizedBox(height: 6),
                    _textRow(
                      context,
                      "Stamp".tr,
                      'Rp. ${controller.invoiceDetailModel?.stamp!.toCurrency() ?? "-"}',
                      controller.isLoading,
                    ),
                    const SizedBox(height: 16),
                    const DottedLine(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 2.0,
                      dashColor: greyLightColor3,
                      dashGapLength: 2.0,
                    ),
                    const SizedBox(height: 16),
                    _textRow(
                      context,
                      "Total Paid".tr,
                      'Rp. ${controller.invoiceDetailModel?.totalPaid!.toCurrency() ?? "-"}',
                      controller.isLoading,
                      style: listTitleTextStyle.copyWith(
                        color: AppConst.isLightTheme(context)
                            ? successColor
                            : successLightColor1,
                      ),
                      titleFontWeight: bold,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
  //       color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Lihat Daftar Transaksi ".tr,
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .titleMedium
  //                   ?.copyWith(color: Colors.white),
  //             ),
  //             const Icon(Icons.arrow_circle_right, color: Colors.white),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _textRow(
      BuildContext context, String title, String? value, bool isLoading,
      {TextStyle? style, FontWeight? titleFontWeight}) {
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
                    ?.copyWith(fontWeight: titleFontWeight ?? regular),
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
                textAlign: TextAlign.end, // Align the value to the right
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/dashed_border.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickerDefault extends StatelessWidget {
  final DataTransactionModel data;
  final bool shippingCost;

  const StickerDefault({
    super.key,
    required this.data,
    this.shippingCost = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextStyle(
          style: const TextStyle(color: greyDarkColor1),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(), color: whiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      ImageConstant.logoJNE,
                      height: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          "Reference Number",
                          style: TextStyle(
                            fontWeight: extraBold,
                            fontSize: 15,
                          ),
                        ),
                        BarcodeWidget(
                          barcode: Barcode.code128(
                            useCode128A: true,
                            // escapes: true,
                          ),
                          color: greyDarkColor1,
                          data: data.orderId ?? '',
                          drawText: false,
                          height: 80,
                          width: Get.width / 1.7,
                        ),
                        Text(data.orderId ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: greyDarkColor1,
                                  fontWeight: regular,
                                )),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("From :", style: TextStyle(fontWeight: bold)),
                          Text(data.shipper?.name ?? ''),
                          Text(data.origin?.originName ?? ''),
                          Text(data.shipper?.city ??
                              data.shipper?.origin?.originName ??
                              ''),
                          Text(data.shipper?.address ?? ''),
                          Text("\n\nKode Pos : ${data.shipper?.zipCode ?? ''}"),
                          Text(data.shipper?.phone ?? '')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("To :", style: TextStyle(fontWeight: bold)),
                          Text("${data.receiver?.name ?? ''}\n"),
                          Text(data.destination?.cityName ?? ''),
                          Text(data.receiver?.city ?? ''),
                          Text(data.receiver?.address ?? ''),
                          Text(
                              "\n\nKode Pos : ${data.receiver?.zipCode ?? ''}"),
                          Text(data.receiver?.phone?.maskPhoneNumber() ?? ''),
                          Text(
                            data.destination?.destinationCode
                                    ?.substring(0, 3) ??
                                '-',
                            style: TextStyle(fontSize: 38, fontWeight: bold),
                          ),
                          Text(
                            data.account?.accountType ?? '',
                            style: TextStyle(fontWeight: bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                CustomLabelText(
                  title: "Cust id:",
                  value: data.account?.accountNumber ?? '',
                  titleTextStyle: TextStyle(fontWeight: bold),
                  valueTextStyle: const TextStyle(),
                ),
                CustomLabelText(
                  title: "Contact Person:",
                  value: data.shipper?.contact ?? data.shipper?.name ?? '-',
                  titleTextStyle: TextStyle(fontWeight: bold),
                  valueTextStyle: const TextStyle(),
                ),
                CustomLabelText(
                  title: "Detail Goods:",
                  value: data.goods?.desc ?? '-',
                  titleTextStyle: TextStyle(fontWeight: bold),
                  valueTextStyle: const TextStyle(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomLabelText(
                          title: "Qty:",
                          value: data.goods?.quantity.toString() ?? '-',
                          titleTextStyle: TextStyle(fontWeight: bold),
                          valueTextStyle: const TextStyle(),
                          isHorizontal: true,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomLabelText(
                              title: "Goods Type:",
                              value: data.goods?.type ?? '-',
                              titleTextStyle: TextStyle(fontWeight: bold),
                              valueTextStyle: const TextStyle(),
                            ),
                            const SizedBox(width: 25),
                            Text(data.delivery?.serviceCode ?? '',
                                style:
                                    TextStyle(fontSize: 38, fontWeight: bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabelText(
                      title: "Insurance:",
                      value: data.delivery?.insuranceFlag == "Y" ? "YES" : "NO",
                      titleTextStyle: TextStyle(fontWeight: bold),
                      valueTextStyle: const TextStyle(),
                      isHorizontal: true,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomLabelText(
                              title: "Packing Kayu:",
                              value: data.delivery?.woodPackaging == "Y"
                                  ? "YES"
                                  : "NO",
                              titleTextStyle: TextStyle(fontWeight: bold),
                              valueTextStyle: const TextStyle(),
                            ),
                            data.type == 'COD'
                                ? const SizedBox(width: 10)
                                : const SizedBox(width: 85),
                            Text(data.type == 'COD' ? data.type ?? '' : '',
                                // data.account?.accountService == 'COD' ||
                                //         data.account?.accountService == 'JLC'
                                //     ? data.account?.accountService ?? ''
                                //     : data.account?.accountService ==
                                //             'COD ONGKIR'
                                //         ? 'COD'
                                //         : '',
                                style:
                                    TextStyle(fontSize: 38, fontWeight: bold)),
                          ],
                        ),
                      ],
                    ),
                    // CustomLabelText(
                    //   title: "Packing Kayu:   ",
                    //   value: data.delivery?.woodPackaging == "Y" ? "YES" : "NO",
                    //   titleTextStyle: TextStyle(fontWeight: bold),
                    //   valueTextStyle: const TextStyle(),
                    // ),
                    // Row(
                    //   children: [
                    //     const SizedBox(width: 10),
                    //     Text(data.account?.accountService ?? '',
                    //         style: TextStyle(fontSize: 38, fontWeight: bold)),
                    //   ],
                    // ),
                  ],
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLabelText(
                      title: "Estimasi Ongkir: Rp",
                      value:
                          '${shippingCost ? 0 : data.delivery?.insuranceFlag == "Y" ? data.delivery?.freightChargeWithInsurance?.toInt().toCurrency() ?? '0' : data.delivery?.freightCharge?.toInt().toCurrency() ?? '0'}',
                      titleTextStyle: TextStyle(fontWeight: bold),
                      valueTextStyle: const TextStyle(),
                    ),
                    const SizedBox(width: 15),
                    CustomLabelText(
                      title: "Weight:   ",
                      value: '${data.goods?.weight ?? '0'} Kg',
                      titleTextStyle: TextStyle(fontWeight: bold),
                      valueTextStyle: const TextStyle(),
                      isHorizontal: true,
                    ),
                  ],
                ),
                CustomLabelText(
                  title: "Goods Amount  :   ",
                  value:
                      'Rp ${data.goods?.amount?.toInt().toCurrency() ?? '0'}',
                  titleTextStyle: TextStyle(fontWeight: bold),
                  valueTextStyle: const TextStyle(),
                  isHorizontal: true,
                ),
                CustomLabelText(
                  title: "COD Amount :   ",
                  value:
                      "Rp ${data.delivery?.codFee?.toInt().toCurrency() ?? '0'}",
                  titleTextStyle: TextStyle(fontWeight: bold),
                  valueTextStyle: const TextStyle(),
                  isHorizontal: true,
                ),
                Center(
                  child: Text(
                    // "${data.destination?.destinationCode?.substring(0, 3) ?? ''}-${data.receiver?.destinationCode ?? ''}",
                    data.receiver?.destinationCode ?? '',
                    style: TextStyle(
                      fontWeight: bold,
                      fontSize: 21,
                    ),
                  ),
                ),
                const DashedBorder(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Text(
                        "Airwaybill Number",
                        style: TextStyle(
                          fontWeight: extraBold,
                          fontSize: 21,
                        ),
                      ),
                      BarcodeWidget(
                        barcode: Barcode.code128(
                          useCode128A: true,
                          // escapes: true,
                        ),
                        data: data.awb ?? '',
                        drawText: true,
                        style: const TextStyle(fontSize: 20),
                        // height: 80,
                        // width: Get.width ,
                      )
                    ],
                  ),
                ),
                const DashedBorder(),
                const SizedBox(height: 10),
                CustomLabelText(
                  title: "Special Instruction :   ",
                  value: data.delivery?.specialInstruction ?? '-',
                  titleTextStyle: TextStyle(fontWeight: bold),
                  valueTextStyle: const TextStyle(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text(
                        "This Label Copyright By JNE",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Print date : ${DateTime.now().toString().toDateTimeFormat()}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontWeight: bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

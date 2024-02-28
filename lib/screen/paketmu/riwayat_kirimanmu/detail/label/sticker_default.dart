import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/dashed_border.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickerDefault extends StatelessWidget {
  final TransactionModel data;

  const StickerDefault({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all()),
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
                        data: data.orderId ?? '',
                        drawText: true,
                        height: 80,
                        width: Get.width / 1.7,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From :", style: TextStyle(fontWeight: bold)),
                      Text(data.shipper?.name ?? ''),
                      Text(data.shipper?.origin?.originName ?? ''),
                      Text(data.shipper?.city ?? data.shipper?.origin?.originName ?? ''),
                      Text(data.shipper?.address ?? ''),
                      Text("\n\nKode Pos : ${data.shipper?.zip}"),
                      Text(data.shipper?.phone ?? '')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("To :", style: TextStyle(fontWeight: bold)),
                      Text("${data.receiver?.name}\n"),
                      Text(data.receiver?.destinationDescription ?? ''),
                      Text(data.receiver?.city ?? ''),
                      Text(data.receiver?.address ?? ''),
                      Text("\n\nKode Pos : ${data.receiver?.zip}"),
                      Text(data.receiver?.phone ?? ''),
                      Text(data.receiver?.destinationCode?.substring(0, 3) ?? '-', style: TextStyle(fontSize: 38, fontWeight: bold)),
                      Text(
                        data.account?.accountType ?? '',
                        style: TextStyle(fontWeight: bold),
                      )
                    ],
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
                value: '-',
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
                        value: '-',
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
                            title: "Goods Type:   ",
                            value: '-',
                            titleTextStyle: TextStyle(fontWeight: bold),
                            valueTextStyle: const TextStyle(),
                          ),
                          const SizedBox(width: 25),
                          Text("${data.service}", style: TextStyle(fontSize: 38, fontWeight: bold)),
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
                    value: "-",
                    titleTextStyle: TextStyle(fontWeight: bold),
                    valueTextStyle: const TextStyle(),
                    isHorizontal: true,
                  ),
                  Row(
                    children: [
                      CustomLabelText(
                        title: "Packing Kayu:   ",
                        value: '-',
                        titleTextStyle: TextStyle(fontWeight: bold),
                        valueTextStyle: const TextStyle(),
                      ),
                      Text(data.account?.accountService ?? '', style: TextStyle(fontSize: 38, fontWeight: bold)),
                    ],
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabelText(
                    title: "Estimasi Ongkir: Rp",
                    value: "-",
                    titleTextStyle: TextStyle(fontWeight: bold),
                    valueTextStyle: const TextStyle(),
                  ),
                  const SizedBox(width: 15),
                  CustomLabelText(
                    title: "Weight:   ",
                    value: '1Kg',
                    titleTextStyle: TextStyle(fontWeight: bold),
                    valueTextStyle: const TextStyle(),
                    isHorizontal: true,
                  ),
                ],
              ),
              CustomLabelText(
                title: "Goods Value  :   ",
                value: 'Rp 1,00',
                titleTextStyle: TextStyle(fontWeight: bold),
                valueTextStyle: const TextStyle(),
                isHorizontal: true,
              ),
              CustomLabelText(
                title: "COD Amount :   ",
                value: "Rp ${data.codAmount?.toInt().toCurrency()}",
                titleTextStyle: TextStyle(fontWeight: bold),
                valueTextStyle: const TextStyle(),
                isHorizontal: true,
              ),
              Center(
                child: Text(
                  data.receiver?.destinationCode ?? 'DTB10102',
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
                value: "-",
                titleTextStyle: TextStyle(fontWeight: bold),
                valueTextStyle: const TextStyle(),
                isHorizontal: true,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "This Label Copyright By JNE",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "Print date : ${DateTime.now().toString().toDateTimeFormat()}",
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

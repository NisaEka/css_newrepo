import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
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
                      Text(data.shipper?.origin ?? ''),
                      Text(data.shipper?.city ?? ''),
                      Text(data.shipper?.address ?? ''),
                      Text("\n\nKode Pos : ${data.shipper?.zip}" ?? ''),
                      Text(data.shipper?.phone ?? '')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("To :", style: TextStyle(fontWeight: bold)),
                      Text("${data.receiver?.name}\n" ?? ''),
                      Text(data.receiver?.subDistrict ?? ''),
                      Text(data.receiver?.city ?? ''),
                      Text(data.receiver?.address ?? ''),
                      Text("\n\nKode Pos : ${data.receiver?.zip}" ?? ''),
                      Text(data.receiver?.phone ?? ''),
                      Text(data.receiver?.destinationCode ?? '', style: TextStyle(fontSize: 38, fontWeight: bold)),
                      // Text(data.service)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

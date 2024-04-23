import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickerA6 extends StatelessWidget {
  final DataTransactionModel data;
  final bool shippingCost;

  const StickerA6({
    super.key,
    required this.data,
    this.shippingCost = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all()),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(border: Border(right: BorderSide())),
                    child: Image.asset(
                      ImageConstant.logoJNE,
                      height: 40,
                    ),
                  ),
                  Container(
                    width: Get.width / 1.75,
                    alignment: Alignment.center,
                    child: Text(
                      data.awb ?? '',
                      style: appTitleTextStyle.copyWith(color: Colors.black),
                    ),
                  )
                ],
              ),
              const Divider(height: 1),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: BarcodeWidget(
                  barcode: Barcode.code128(
                    useCode128A: true,
                    // escapes: true,
                  ),
                  data: data.awb ?? '',
                  drawText: false,
                  style: const TextStyle(fontSize: 20),
                  // height: 80,
                  // width: Get.width ,
                ),
              ),
              Table(
                border: const TableBorder(
                  top: BorderSide(),
                  bottom: BorderSide(),
                  verticalInside: BorderSide(),
                ),
                children: <TableRow>[
                  TableRow(
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.account?.accountService ?? '-',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: bold),
                          ),
                          const Divider(height: 1),
                          Text(data.createdDate?.toShortDateFormat() ?? ''),
                        ],
                      ),
                      CustomLabelText(
                        title: 'Origin',
                        value: data.origin?.originCode ?? '-',
                        fontColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      ),
                      CustomLabelText(
                        title: 'Dest',
                        value: data.destination?.destinationCode ?? '-',
                        fontColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      CustomLabelText(
                        title: 'Account No',
                        value: data.account?.accountNumber ?? '-',
                        fontColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: 'center',
                        titleTextStyle: TextStyle(fontWeight: bold),
                        valueTextStyle: const TextStyle(),
                      ),
                      CustomLabelText(
                        title: 'Qty',
                        value: data.goods?.quantity.toString() ?? '-',
                        fontColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: 'center',
                        titleTextStyle: TextStyle(fontWeight: bold),
                        valueTextStyle: const TextStyle(),
                      ),
                      CustomLabelText(
                        title: 'Weight',
                        value: '${data.goods?.weight} Kg',
                        fontColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: 'center',
                        titleTextStyle: TextStyle(fontWeight: bold),
                        valueTextStyle: const TextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            title: 'Shipper : ',
                            value: "${data.shipper?.name ?? ''}\n${data.shipper?.address ?? ''}\n\n",
                            titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                            valueTextStyle: sublistTitleTextStyle.copyWith(),
                            isHorizontal: true,
                            valueMaxline: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'City : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.shipper?.city ?? data.shipper?.origin?.originName ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                                TextSpan(
                                  text: ' Province : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.shipper?.region ??'',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                                // TextSpan(
                                //   text: 'City \t\t\t\t\t\t\t\t\t: ',
                                //   style: sublistTitleTextStyle.copyWith(fontWeight: bold, color: Colors.white),
                                // ),
                                // TextSpan(
                                //   text: data.shipper?.region ?? '',
                                //   style: sublistTitleTextStyle.copyWith(),
                                // ),
                                TextSpan(
                                  text: ' Phone : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.shipper?.phone ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                                TextSpan(
                                  text: ' Zip Code : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.shipper?.zip ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(data.delivery?.serviceCode ?? '-', style: TextStyle(fontSize: 38, fontWeight: bold)),
                        Text(data.type ?? '-', style: TextStyle(fontSize: 38, fontWeight: bold)),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (Get.width / 1.5) - 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabelText(
                            title: 'Consignee : ',
                            value: "${data.receiver?.name ?? ''}\n${data.shipper?.address ?? ''}\n\n",
                            titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                            valueTextStyle: sublistTitleTextStyle.copyWith(),
                            isHorizontal: true,
                            valueMaxline: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'City : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.receiver?.city ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                                TextSpan(
                                  text: ' Province : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                // TextSpan(
                                //   text: 'City \t\t\t\t\t\t\t\t\t: ',
                                //   style: sublistTitleTextStyle.copyWith(fontWeight: bold, color: Colors.white),
                                // ),
                                TextSpan(
                                  text: data.receiver?.region ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                                TextSpan(
                                  text: ' Phone : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.receiver?.phone ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                                TextSpan(
                                  text: ' Zip Code : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.receiver?.zip ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                                TextSpan(
                                  text: ' Contact Person : ',
                                  style: sublistTitleTextStyle.copyWith(fontWeight: bold),
                                ),
                                TextSpan(
                                  text: data.receiver?.contact ?? '',
                                  style: sublistTitleTextStyle.copyWith(),
                                ),
                              ],
                            ),
                          ),

                          // CustomLabelText(
                          //   title: 'Contact\nPerson ',
                          //   value: "\t: ${data.receiver?.contact ?? data.receiver?.name}",
                          //   titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                          //   valueTextStyle: sublistTitleTextStyle.copyWith(),
                          //   isHorizontal: true,
                          //   valueMaxline: 5,
                          //   alignment: 'center',
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text("${data.destination?.destinationCode?.substring(0, 3) ?? '-'}-${data.receiver?.destinationCode ?? ''}",
                            style: TextStyle(fontSize: 20, fontWeight: bold)),
                        Text(data.account?.accountType ?? '-', style: TextStyle(fontSize: 12.5, fontWeight: bold)),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: BarcodeWidget(
                  barcode: Barcode.code128(
                    useCode128A: true,
                    // escapes: true,
                  ),
                  data: data.orderId ?? '',
                  drawText: true,
                  style: const TextStyle(fontSize: 20),
                  height: 80,
                  // width: Get.width ,
                ),
              ),
              const Divider(height: 1),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: (Get.width / 1.5) - 50,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(),
                      ),
                    ),
                    child: CustomLabelText(
                      title: 'Good Description',
                      value: data.goods?.desc ?? '-',
                      titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                      valueTextStyle: sublistTitleTextStyle.copyWith(),
                      valueMaxline: 5,
                    ),
                  ),
                  const SizedBox(width: 5),
                  CustomLabelText(
                    title: 'Goods Value',
                    value: "Rp ${data.goods?.amount?.toInt().toCurrency() ?? '0'}",
                    titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                    valueTextStyle: sublistTitleTextStyle.copyWith(),
                    valueMaxline: 5,
                  ),
                ],
              ),
              const Divider(height: 1),
              CustomLabelText(
                title: 'Instruction : ',
                value: data.delivery?.specialInstruction ?? '-',
                titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                valueTextStyle: sublistTitleTextStyle.copyWith(),
                // isHorizontal: true,
                margin: const EdgeInsets.all(5),
                valueMaxline: 5,
                // width: 50,
              ),
              Table(
                border: const TableBorder(
                  top: BorderSide(),
                  bottom: BorderSide(),
                  verticalInside: BorderSide(),
                ),
                children: <TableRow>[
                  TableRow(
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                    children: <Widget>[
                      CustomLabelText(
                        title: 'Insurance ',
                        value: data.delivery?.insuranceFlag == "Y" ? "YES" : "NO",
                        titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                        valueTextStyle: sublistTitleTextStyle.copyWith(),
                        margin: const EdgeInsets.all(5),
                      ),
                      CustomLabelText(
                        title: 'Insurance Amount',
                        value: "Rp ${data.delivery?.insuranceFee ?? '0'}",
                        titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                        valueTextStyle: sublistTitleTextStyle.copyWith(),
                        margin: const EdgeInsets.all(5),
                      ),
                      CustomLabelText(
                        title: 'Packing Kayu  ',
                        value: data.delivery?.woodPackaging == "Y" ? "YES" : "NO",
                        titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                        valueTextStyle: sublistTitleTextStyle.copyWith(),
                        margin: const EdgeInsets.all(5),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  CustomLabelText(
                    title: 'Est.Ongkir',
                    value:
                        "Rp ${shippingCost ? 0 : data.delivery?.insuranceFlag == "Y" ? data.delivery?.flatRateWithInsurance?.toInt().toCurrency() : data.delivery?.flatRate?.toInt().toCurrency() ?? '0'}",
                    titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                    valueTextStyle: sublistTitleTextStyle.copyWith(),
                    margin: const EdgeInsets.all(5),
                    isHorizontal: true,
                  ),
                  CustomLabelText(
                    title: 'COD Amountr',
                    value: "Rp ${data.delivery?.codFee?.toInt().toCurrency() ?? '0'},00",
                    titleTextStyle: sublistTitleTextStyle.copyWith(fontWeight: bold),
                    valueTextStyle: sublistTitleTextStyle.copyWith(),
                    margin: const EdgeInsets.all(5),
                    isHorizontal: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

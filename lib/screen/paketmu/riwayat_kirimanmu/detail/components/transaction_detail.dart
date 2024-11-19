import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_screen.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/services.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailRiwayatKirimanController>(
        init: DetailRiwayatKirimanController(),
        builder: (c) {
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
                          backgroundColor: AppConst.isLightTheme(context)
                              ? greyLightColor2
                              : greyDarkColor2,
                          noBorder: true,
                          isLoading: c.isLoading,
                        ),
                        CustomTextFormField(
                          controller: c.pickupStatus,
                          label: 'Status Pickup'.tr,
                          width: Get.width / 2.5,
                          readOnly: true,
                          hintText: '',
                          backgroundColor: AppConst.isLightTheme(context)
                              ? greyLightColor2
                              : greyDarkColor2,
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
                          color:
                              AppConst.isLightTheme(context) ? blueJNE : redJNE,
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
                      color: c.isLoading
                          ? greyColor
                          : (AppConst.isLightTheme(context)
                              ? whiteColor
                              : greyDarkColor2),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: AppConst.isLightTheme(context)
                              ? greyLightColor3
                              : greyDarkColor2,
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
                          value: c.transactionModel?.createdDateSearch
                                  ?.toLongDateTimeFormat() ??
                              '-',
                          titleTextStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 10, fontWeight: medium),
                          valueTextStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 10),
                          alignment: 'end',
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("No Resi".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    GestureDetector(
                                      onTap: () => Clipboard.setData(
                                          ClipboardData(
                                              text: c.transactionModel?.awb ??
                                                  '')),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          size: 10,
                                          Icons.copy_rounded,
                                          color: AppConst.isLightTheme(context)
                                              ? blueJNE
                                              : redJNE,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Tipe".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Service".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Dana COD".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Petugas Entry".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Pengirim".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Kota Pengiriman".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Penerima".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Kontak Penerima".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Row(
                                  children: [
                                    Text("Order ID".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    GestureDetector(
                                      onTap: () => Clipboard.setData(
                                          ClipboardData(
                                              text:
                                                  c.transactionModel?.orderId ??
                                                      '')),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          size: 10,
                                          Icons.copy_rounded,
                                          color: AppConst.isLightTheme(context)
                                              ? blueJNE
                                              : redJNE,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Account".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text("Deskripsi".tr,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.transactionModel?.awb ?? '-',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: medium,
                                      ),
                                ),
                                Text(
                                  c.transactionModel?.type ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.transactionModel?.serviceCode ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  'Rp. ${c.transactionModel?.deliveryPrice?.toInt().toCurrency() ?? '-'}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.transactionModel?.petugasEntry ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.transactionModel?.shipperName ?? '-',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: medium),
                                ),
                                Text(
                                  "${c.transactionModel?.receiverCity} / ${c.transactionModel?.receiverDistrict}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.transactionModel?.receiverName ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.transactionModel?.receiverPhone ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.transactionModel?.orderId ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(
                                  width: Get.width - 200,
                                  child: Text(
                                    '${c.transactionModel?.accountNumber}/ ${c.transactionModel?.accountName} / ${c.transactionModel?.accountType}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  c.transactionModel?.goodsDesc ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
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
                          'data': DataTransactionModel(
                            destination: Destination(
                              destinationCode:
                                  c.transactionModel?.destinationCode,
                              zipCode: c.transactionModel?.receiverZip,
                              cityName: c.transactionModel?.receiverCity,
                              countryName: c.transactionModel?.receiverCountry,
                              districtName:
                                  c.transactionModel?.receiverDistrict,
                              provinceName: c.transactionModel?.receiverRegion,
                              subdistrictName:
                                  c.transactionModel?.receiverSubdistrict,
                            ),
                            dataDestination: Destination(
                              destinationCode:
                                  c.transactionModel?.destinationCode,
                              zipCode: c.transactionModel?.receiverZip,
                              cityName: c.transactionModel?.receiverCity,
                              countryName: c.transactionModel?.receiverCountry,
                              districtName:
                                  c.transactionModel?.receiverDistrict,
                              provinceName: c.transactionModel?.receiverRegion,
                              subdistrictName:
                                  c.transactionModel?.receiverSubdistrict,
                            ),
                            receiver: ReceiverModel(
                                name: c.transactionModel?.receiverName,
                                zipCode: c.transactionModel?.receiverZip,
                                destinationCode:
                                    c.transactionModel?.destinationCode,
                                destinationDescription:
                                    c.transactionModel?.destinationDesc,
                                city: c.transactionModel?.receiverCity,
                                country: c.transactionModel?.receiverCountry,
                                contact: c.transactionModel?.receiverContact,
                                phone: c.transactionModel?.receiverPhone,
                                address: c.transactionModel?.receiverAddr,
                                region: c.transactionModel?.receiverRegion,
                                district: c.transactionModel?.receiverDistrict,
                                subDistrict:
                                    c.transactionModel?.receiverSubdistrict),
                            shipper: ShipperModel(
                              name: c.transactionModel?.shipperName,
                              address: c.transactionModel?.shipperAddr,
                              address1: c.transactionModel?.shipperAddr1,
                              address2: c.transactionModel?.shipperAddr2,
                              address3: c.transactionModel?.shipperAddr3,
                              country: c.transactionModel?.shipperCountry,
                              region: Region(
                                name: c.transactionModel?.shipperRegion,
                              ),
                              city: c.transactionModel?.shipperCity,
                              phone: c.transactionModel?.shipperPhone,
                              contact: c.transactionModel?.shipperContact,
                              zipCode: c.transactionModel?.shipperZip,
                              origin: OriginModel(
                                originCode: c.transactionModel?.originCode,
                                originName: c.transactionModel?.originDesc,
                                branchCode: c.transactionModel?.branch,
                                branch: BranchModel(
                                    region: Region(
                                  name: c.transactionModel?.shipperRegion,
                                )),
                              ),
                            ),
                            origin: OriginModel(
                              originCode: c.transactionModel?.originCode,
                              originName: c.transactionModel?.originDesc,
                              branchCode: c.transactionModel?.branch,
                              branch: BranchModel(
                                  region: Region(
                                name: c.transactionModel?.shipperRegion,
                              )),
                            ),
                            registrationId: c.transactionModel?.registrationId,
                            status: c.transactionModel?.statusAwb,
                            createdDate: c.transactionModel?.createdDateSearch,
                            awb: c.transactionModel?.awb,
                            type: c.transactionModel?.apiType,
                            awbType: c.transactionModel?.apiType,
                            createAt: c.transactionModel?.createdDate,
                            delivery: Delivery(
                                serviceCode: c.transactionModel?.serviceCode,
                                insuranceFlag:
                                    c.transactionModel?.insuranceFlag,
                                codFlag: c.transactionModel?.codFlag,
                                codFee: c.transactionModel?.codAmount,
                                codOngkir: c.transactionModel?.codOngkir,
                                flatRate: c.transactionModel?.deliveryPrice,
                                freightCharge:
                                    c.transactionModel?.deliveryPrice,
                                specialInstruction:
                                    c.transactionModel?.specialIns,
                                woodPackaging:
                                    c.transactionModel?.packingkayuFlag,
                                flatRateWithInsurance:
                                    c.transactionModel?.insuranceAmount,
                                freightChargeWithInsurance:
                                    c.transactionModel?.insuranceAmount,
                                insuranceFee:
                                    c.transactionModel?.insuranceAmount),
                            goods: Goods(
                              weight: c.transactionModel?.weight,
                              type: c.transactionModel?.goodsType,
                              amount: c.transactionModel?.goodsAmount,
                              desc: c.transactionModel?.goodsDesc,
                              quantity: c.transactionModel?.qty,
                            ),
                            officerEntry: c.transactionModel?.petugasEntry,
                            orderId: c.transactionModel?.orderId,
                          ),
                        })
                      : null,
                  isLoading: c.isLoading,
                ),
              ],
            ),
          );
        });
  }
}

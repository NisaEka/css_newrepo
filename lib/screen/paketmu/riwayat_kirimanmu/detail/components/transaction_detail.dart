import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_controller.dart';
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
    return GetBuilder<DetailTransactionController>(
        init: DetailTransactionController(),
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
                          controller: c.state.transStatus,
                          // controller: TextEditingController(text: c.state.transactionModel?.status?.isNotEmpty.toString() ?? ''),
                          label: 'Status Transaksi'.tr,
                          width: Get.width / 2.5,
                          readOnly: true,
                          hintText: '',
                          backgroundColor: AppConst.isLightTheme(context) ? greyLightColor2 : greyDarkColor2,
                          noBorder: true,
                          isLoading: c.state.isLoading,
                        ),
                        CustomTextFormField(
                          controller: c.state.pickupStatus,
                          label: 'Status Pickup'.tr,
                          width: Get.width / 2.5,
                          readOnly: true,
                          hintText: '',
                          backgroundColor: AppConst.isLightTheme(context) ? greyLightColor2 : greyDarkColor2,
                          noBorder: true,
                          isLoading: c.state.isLoading,
                        ),
                      ],
                    ),
                    Shimmer(
                      isLoading: c.state.transactionModel == null,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: c.state.isLoading ? greyColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: c.state.transactionModel?.awb ?? '',
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
                  isLoading: c.state.transactionModel == null,
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: c.state.isLoading ? greyColor : (AppConst.isLightTheme(context) ? whiteColor : greyDarkColor2),
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
                          value: c.state.transactionModel?.createdDateSearch?.toLongDateTimeFormat() ?? '-',
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
                                      onTap: () => Clipboard.setData(ClipboardData(text: c.state.transactionModel?.awb ?? '')),
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
                                      onTap: () => Clipboard.setData(ClipboardData(text: c.state.transactionModel?.orderId ?? '')),
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
                                Text("Deskripsi".tr, style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.state.transactionModel?.awb ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: medium,
                                      ),
                                ),
                                Text(
                                  c.state.transactionModel?.type ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.state.transactionModel?.serviceCode ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  'Rp. ${c.state.transactionModel?.deliveryPrice?.toInt().toCurrency() ?? '-'}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.state.transactionModel?.petugasEntry ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.state.transactionModel?.shipperName ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: medium),
                                ),
                                Text(
                                  "${c.state.transactionModel?.receiverCity} / ${c.state.transactionModel?.receiverDistrict}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.state.transactionModel?.receiverName ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.state.transactionModel?.receiverPhone ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  c.state.transactionModel?.orderId ?? '-',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(
                                  width: Get.width - 200,
                                  child: Text(
                                    '${c.state.transactionModel?.accountNumber}/ ${c.state.transactionModel?.accountName} / ${c.state.transactionModel?.accountType}',
                                    style: Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  c.state.transactionModel?.goodsDesc ?? '-',
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
                  onPressed: () => c.state.transactionModel != null
                      ? Get.to(const LabelScreen(), arguments: {
                          'data': DataTransactionModel(
                            destination: Destination(
                              destinationCode: c.state.transactionModel?.destinationCode,
                              zipCode: c.state.transactionModel?.receiverZip,
                              cityName: c.state.transactionModel?.receiverCity,
                              countryName: c.state.transactionModel?.receiverCountry,
                              districtName: c.state.transactionModel?.receiverDistrict,
                              provinceName: c.state.transactionModel?.receiverRegion,
                              subdistrictName: c.state.transactionModel?.receiverSubdistrict,
                            ),
                            dataDestination: Destination(
                              destinationCode: c.state.transactionModel?.destinationCode,
                              zipCode: c.state.transactionModel?.receiverZip,
                              cityName: c.state.transactionModel?.receiverCity,
                              countryName: c.state.transactionModel?.receiverCountry,
                              districtName: c.state.transactionModel?.receiverDistrict,
                              provinceName: c.state.transactionModel?.receiverRegion,
                              subdistrictName: c.state.transactionModel?.receiverSubdistrict,
                            ),
                            receiver: ReceiverModel(
                                name: c.state.transactionModel?.receiverName,
                                zipCode: c.state.transactionModel?.receiverZip,
                                destinationCode: c.state.transactionModel?.destinationCode,
                                destinationDescription: c.state.transactionModel?.destinationDesc,
                                city: c.state.transactionModel?.receiverCity,
                                country: c.state.transactionModel?.receiverCountry,
                                contact: c.state.transactionModel?.receiverContact,
                                phone: c.state.transactionModel?.receiverPhone,
                                address: c.state.transactionModel?.receiverAddr,
                                region: c.state.transactionModel?.receiverRegion,
                                district: c.state.transactionModel?.receiverDistrict,
                                subDistrict: c.state.transactionModel?.receiverSubdistrict),
                            shipper: ShipperModel(
                              name: c.state.transactionModel?.shipperName,
                              address: c.state.transactionModel?.shipperAddr,
                              address1: c.state.transactionModel?.shipperAddr1,
                              address2: c.state.transactionModel?.shipperAddr2,
                              address3: c.state.transactionModel?.shipperAddr3,
                              country: c.state.transactionModel?.shipperCountry,
                              region: RegionModel(
                                name: c.state.transactionModel?.shipperRegion,
                              ),
                              city: c.state.transactionModel?.shipperCity,
                              phone: c.state.transactionModel?.shipperPhone,
                              contact: c.state.transactionModel?.shipperContact,
                              zipCode: c.state.transactionModel?.shipperZip,
                              origin: OriginModel(
                                originCode: c.state.transactionModel?.originCode,
                                originName: c.state.transactionModel?.originDesc,
                                branchCode: c.state.transactionModel?.branch,
                                branch: BranchModel(
                                    region: RegionModel(
                                  name: c.state.transactionModel?.shipperRegion,
                                )),
                              ),
                            ),
                            origin: OriginModel(
                              originCode: c.state.transactionModel?.originCode,
                              originName: c.state.transactionModel?.originDesc,
                              branchCode: c.state.transactionModel?.branch,
                              branch: BranchModel(
                                  region: RegionModel(
                                name: c.state.transactionModel?.shipperRegion,
                              )),
                            ),
                            registrationId: c.state.transactionModel?.registrationId,
                            status: c.state.transactionModel?.statusAwb,
                            createdDate: c.state.transactionModel?.createdDateSearch,
                            awb: c.state.transactionModel?.awb,
                            type: c.state.transactionModel?.apiType,
                            awbType: c.state.transactionModel?.apiType,
                            createAt: c.state.transactionModel?.createdDate,
                            delivery: Delivery(
                                serviceCode: c.state.transactionModel?.serviceCode,
                                insuranceFlag: c.state.transactionModel?.insuranceFlag,
                                codFlag: c.state.transactionModel?.codFlag,
                                codFee: c.state.transactionModel?.codAmount,
                                codOngkir: c.state.transactionModel?.codOngkir,
                                flatRate: c.state.transactionModel?.deliveryPrice,
                                freightCharge: c.state.transactionModel?.deliveryPrice,
                                specialInstruction: c.state.transactionModel?.specialIns,
                                woodPackaging: c.state.transactionModel?.packingkayuFlag,
                                flatRateWithInsurance: c.state.transactionModel?.insuranceAmount,
                                freightChargeWithInsurance: c.state.transactionModel?.insuranceAmount,
                                insuranceFee: c.state.transactionModel?.insuranceAmount),
                            goods: Goods(
                              weight: c.state.transactionModel?.weight,
                              type: c.state.transactionModel?.goodsType,
                              amount: c.state.transactionModel?.goodsAmount,
                              desc: c.state.transactionModel?.goodsDesc,
                              quantity: c.state.transactionModel?.qty,
                            ),
                            officerEntry: c.state.transactionModel?.petugasEntry,
                            orderId: c.state.transactionModel?.orderId,
                          ),
                        })
                      : null,
                  isLoading: c.state.isLoading,
                ),
              ],
            ),
          );
        });
  }
}

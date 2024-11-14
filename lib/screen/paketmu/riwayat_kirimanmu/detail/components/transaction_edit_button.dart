import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionEditButton extends StatelessWidget {
  final bool isLoading;
  final TransactionModel data;

  const TransactionEditButton({super.key, required this.isLoading, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomFilledButton(
      title: data.statusAwb == "MASIH DI KAMU"
          // &&
          // data.account?.accountType != "CASHLESS" &&
          // data.account?.accountService != "JLC" &&
          // data.account?.accountNumber?.substring(0, 1) != "3"
          ? "Edit Kiriman".tr
          : "Hubungi Aku".tr,
      color: data.statusAwb == "MASIH DI KAMU"
          // &&
          // data.account?.accountService != "JLC" &&
          // data.account?.accountType != "CASHLESS" &&
          // data.account?.accountNumber?.substring(0, 1) != "3"
          ? successLightColor3
          : errorLightColor3,
      margin: const EdgeInsets.all(20),
      isLoading: isLoading,
      onPressed: () {
        if (data.statusAwb == "MASIH DI KAMU"
            // &&
            // data.account?.accountService != "JLC" &&
            // data.account?.accountType != "CASHLESS" &&
            // data.account?.accountNumber?.substring(0, 1) != "3"
            ) {
          Get.to(
            const InformasiPengirimScreen(),
            arguments: {
              'isEdit':true,
              'data': DataTransactionModel(
                shipper: ShipperModel(
                  name: data.shipperName,
                  phone: data.shipperPhone,
                  contact: data.shipperContact,
                  address: data.shipperAddr,
                  address1: data.shipperAddr1,
                  address2: data.shipperAddr2,
                  address3: data.shipperAddr3,
                  country: data.shipperCountry,
                  region: Region(
                    name: data.shipperRegion,
                  ),
                  city: data.shipperCity,
                  zipCode: data.shipperZip,
                  origin: Origin(
                    originCode: data.originCode,
                    originName: data.originDesc,
                    region: Region(
                      name: data.shipperRegion,
                    ),
                    branchCode: data.branch,
                  ),
                ),
                origin: Origin(
                  originCode: data.originCode,
                  originName: data.originDesc,
                  region: Region(
                    name: data.shipperRegion,
                  ),
                  branchCode: data.branch,
                ),
                awb: data.awb,
                type: data.goodsType,
                orderId: data.orderId,
                officerEntry: data.petugasEntry,
                goods: Goods(
                  type: data.goodsType,
                  quantity: data.qty,
                  desc: data.goodsDesc,
                  amount: data.goodsAmount,
                  weight: data.weight,
                ),
                status: data.statusAwb,
                createAt: data.createdDateSearch,
                account: Account(
                  accountNumber: data.accountNumber,
                  accountName: data.accountName,
                  accountType: data.accountType,
                  accountService: data.accountService,
                  accountBranch: data.branch,
                ),
                createdDate: data.createdDateSearch,
                delivery: Delivery(
                  insuranceFee: data.insuranceAmount,
                  woodPackaging: data.packingkayuFlag,
                  specialInstruction: data.specialIns,
                  insuranceFlag: data.insuranceFlag,
                  serviceCode: data.serviceCode,
                  codFlag: data.codFlag,
                  freightCharge: data.deliveryPrice,
                  codFee: data.codAmount,
                  codOngkir: data.codOngkir,
                ),
                dataAccount: Account(
                  accountNumber: data.accountNumber,
                  accountName: data.accountName,
                  accountType: data.accountType,
                  accountService: data.accountService,
                  accountBranch: data.branch,
                ),
                registrationId: data.registrationId,
                receiver: ReceiverModel(
                  name: data.receiverName,
                  phone: data.receiverPhone,
                  contact: data.receiverContact,
                  address: data.receiverAddr,
                  // address1: data.receiverAddr1,
                  // address2: data.receiverAddr2,
                  // address3: data.receiverAddr3,
                  country: data.receiverCountry,
                  region: data.receiverRegion,
                  city: data.receiverCity,
                  zipCode: data.receiverZip,
                  district: data.receiverDistrict,
                  subDistrict: data.receiverSubdistrict,
                  destinationCode: data.destinationCode,
                  destinationDescription: data.destinationDesc,
                ),
                dataDestination: Destination(
                  destinationCode: data.destinationCode,
                  zipCode: data.receiverZip,
                  districtName: data.receiverDistrict,
                  subdistrictName: data.receiverSubdistrict,
                  provinceName: data.receiverRegion,
                  countryName: data.receiverCountry,
                  cityName: data.receiverCity,
                  cityZone: data.receiverDistrict,
                ),
                destination: Destination(
                  destinationCode: data.destinationCode,
                  zipCode: data.receiverZip,
                  districtName: data.receiverDistrict,
                  subdistrictName: data.receiverSubdistrict,
                  provinceName: data.receiverRegion,
                  countryName: data.receiverCountry,
                  cityName: data.receiverCity,
                  cityZone: data.receiverDistrict,
                ),
              ),
            },
          );
        }
      },
    );
  }
}

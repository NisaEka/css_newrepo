import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_detail_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PantauPaketmuDetailController extends BaseController {
  final network = Get.find<NetworkCore>();
  String awbNo = Get.arguments["awbNo"];

  bool isLoading = false;

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _showContent = false;
  bool get showContent => _showContent;

  bool _showEmptyContainer = false;
  bool get showEmptyContainer => _showEmptyContainer;

  bool _showErrorContainer = false;
  bool get showErrorContainer => _showErrorContainer;

  late PantauPaketmuDetailModel _pantauPaketmu;
  PantauPaketmuDetailModel get pantauPaketmu => _pantauPaketmu;

  DataTransactionModel? transactionData;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_getRequestPickupByAwb()]);
  }

  Future<void> _getRequestPickupByAwb() async {
    isLoading = true;
    _showLoadingIndicator = true;
    update();

    try {
      var response =
          await network.base.get('/transaction/tracks/count/details/$awbNo');
      var result = BaseResponse<PantauPaketmuDetailModel>.fromJson(
        response.data,
        (json) =>
            PantauPaketmuDetailModel.fromJson(json as Map<String, dynamic>),
      );

      if (result.code == HttpStatus.ok && result.data != null) {
        _pantauPaketmu = result.data!;
        _showContent = true;
        transactionData = DataTransactionModel(
          destination: Destination(
            destinationCode: result.data?.transaction?.destinationCode,
            zipCode: result.data?.cnoteReceiverZip,
            cityName: result.data?.transaction?.receiverCity,
            countryName: result.data?.transaction?.receiverCountry,
            districtName: result.data?.transaction?.receiverDistrict,
            provinceName: result.data?.transaction?.receiverRegion,
            subdistrictName: result.data?.transaction?.receiverSubdistrict,
          ),
          account: Account(
            accountNumber: result.data?.custNo,
            accountService: result.data?.transaction?.accountService,
            accountName: result.data?.custName,
            accountType: result.data?.transaction?.accountType,
          ),
          dataAccount: Account(
            accountNumber: result.data?.custNo,
            accountService: result.data?.transaction?.accountService,
            accountName: result.data?.custName,
            accountType: result.data?.transaction?.accountType,
          ),
          dataDestination: Destination(
            destinationCode: result.data?.transaction?.destinationCode,
            zipCode: result.data?.cnoteReceiverZip,
            cityName: result.data?.transaction?.receiverCity,
            countryName: result.data?.transaction?.receiverCountry,
            districtName: result.data?.transaction?.receiverDistrict,
            provinceName: result.data?.transaction?.receiverRegion,
            subdistrictName: result.data?.transaction?.receiverSubdistrict,
          ),
          receiver: ReceiverModel(
              name: result.data?.receiverName,
              zipCode: result.data?.cnoteReceiverZip,
              destinationCode: result.data?.transaction?.destinationCode,
              destinationDescription: result.data?.transaction?.destinationDesc,
              city: result.data?.transaction?.receiverCity,
              country: result.data?.transaction?.receiverCountry,
              contact: result.data?.cnoteReceiverContact,
              phone: result.data?.cnoteReceiverPhone,
              address:
                  '${result.data?.cnoteReceiverAddr1}${result.data?.cnoteReceiverAddr2}${result.data?.cnoteReceiverAddr3}',
              region: result.data?.transaction?.receiverRegion,
              district: result.data?.transaction?.receiverDistrict,
              subDistrict: result.data?.transaction?.receiverSubdistrict),
          shipper: ShipperModel(
            name: result.data?.cnoteShipperName,
            address:
                '${result.data?.cnoteShipperAddr1}${result.data?.cnoteShipperAddr2}${result.data?.cnoteShipperAddr3}',
            address1: result.data?.cnoteShipperAddr1,
            address2: result.data?.cnoteShipperAddr2,
            address3: result.data?.cnoteShipperAddr3,
            country: result.data?.transaction?.shipperCountry,
            region: RegionModel(
              name: result.data?.transaction?.shipperRegion,
            ),
            city: result.data?.originName,
            phone: result.data?.cnoteShipperPhone,
            contact: result.data?.cnoteShipperContact,
            zipCode: result.data?.cnoteShipperZip,
            origin: OriginModel(
              originCode: result.data?.transaction?.originCode,
              originName: result.data?.originName,
              branchCode: result.data?.branchId,
              branch: BranchModel(
                  region: RegionModel(
                name: result.data?.transaction?.shipperRegion,
              )),
            ),
          ),
          origin: OriginModel(
            originCode: result.data?.transaction?.originCode,
            originName: result.data?.originName,
            branchCode: result.data?.branchId,
            branch: BranchModel(
                region: RegionModel(
              name: result.data?.transaction?.shipperRegion,
            )),
          ),
          registrationId: result.data?.registrationId,
          status: result.data?.transaction?.statusAwb,
          createdDate: result.data?.transaction?.createdDateSearch,
          awb: result.data?.awbNo,
          type: result.data?.transaction?.apiType,
          awbType: result.data?.transaction?.apiType,
          createAt: result.data?.createDate,
          delivery: Delivery(
              serviceCode: result.data?.transaction?.serviceCode,
              insuranceFlag: result.data?.transaction?.insuranceFlag,
              codFlag: result.data?.codFlag,
              codFee: result.data?.codAmount,
              codOngkir: result.data?.repcssNetCodAmt.toString(),
              flatRate: result.data?.awbAmount,
              freightCharge: result.data?.awbAmount,
              specialInstruction: result.data?.awbSpecialIns,
              woodPackaging: result.data?.transaction?.packingkayuFlag,
              flatRateWithInsurance: result.data?.awbInsuranceValue,
              freightChargeWithInsurance: result.data?.awbInsuranceValue,
              insuranceFee: result.data?.awbInsuranceValue),
          goods: Goods(
            weight: result.data?.weightAwb,
            type: result.data?.transaction?.goodsType,
            amount: result.data?.awbGoodsValue,
            desc: result.data?.awbGoodsDescr,
            quantity: result.data?.qtyAwb,
          ),
          officerEntry: result.data?.transaction?.petugasEntry,
          orderId: result.data?.transaction?.orderId,
        );
      } else if (result.code == HttpStatus.notFound) {
        _showEmptyContainer = true;
      }

      update();
    } on DioException catch (e) {
      var result = BaseResponse<PantauPaketmuDetailModel>.fromJson(
        e.response?.data,
        (json) =>
            PantauPaketmuDetailModel.fromJson(json as Map<String, dynamic>),
      );
      AppLogger.e('error fetching data: $e');
      AppSnackBar.error('error fetching data: ${result.message}');
      _showErrorContainer = true;
      update();
    }

    _showLoadingIndicator = false;

    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    update();
  }
}

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_detail_model.dart';
import 'package:css_mobile/data/model/pantau/pantauu_paketmu_detail_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:get/get.dart';

class PantauPaketmuDetailController extends BaseController {
  final network = Get.find<NetworkCore>();
  String awbNo = Get.arguments["awbNo"];

  bool isLoading = false;

  bool _showLoadingIndicator = false;

  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _showContent = false;

  bool get showContent => _showContent;

  final bool _showEmptyContainer = false;

  bool get showEmptyContainer => _showEmptyContainer;

  bool _showErrorContainer = false;

  bool get showErrorContainer => _showErrorContainer;

  late PantauuPaketmuDetailModel _pantauuPaketmu;

  PantauuPaketmuDetailModel get pantauuPaketmu => _pantauuPaketmu;

  late PantauPaketmuDetailModel _pantauPaketmu;

  PantauPaketmuDetailModel get pantauPaketmu => _pantauPaketmu;

  DataTransactionModel? transactionData;
  MenuModel? allow;

  @override
  void onInit() async {
    super.onInit();
    Future.wait([getPantauDetail()]);
    allow = MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
  }

  Future<void> getPantauDetail() async {
    isLoading = true;
    _showLoadingIndicator = true;
    update();

    try {
      await pantau.getPantauDetail(awbNo).then((result) {
        _pantauPaketmu = result.data!;
        _showContent = true;
        transactionData = DataTransactionModel(
          destination: Destination(
            destinationCode: _pantauPaketmu.destination ??
                _pantauPaketmu.transaction?.destinationCode,
            cityZone: _pantauPaketmu.destination?.split('-').last,
            zipCode: _pantauPaketmu.cnoteReceiverZip,
            cityName: _pantauPaketmu.transaction?.receiverCity,
            countryName: _pantauPaketmu.transaction?.receiverCountry,
            districtName: _pantauPaketmu.transaction?.receiverDistrict,
            provinceName: _pantauPaketmu.transaction?.receiverRegion,
            subdistrictName: _pantauPaketmu.transaction?.receiverSubdistrict,
          ),
          account: Account(
            accountNumber: _pantauPaketmu.custNo,
            // accountService: _pantauPaketmu.transaction?.accountService,
            accountName: _pantauPaketmu.custName,
            // accountType: _pantauPaketmu.transaction?.accountType,
          ),
          dataAccount: Account(
            accountNumber: _pantauPaketmu.custNo,
            accountService: _pantauPaketmu.transaction?.apiType,
            accountName: _pantauPaketmu.custName,
            // accountType: _pantauPaketmu.transaction?.accountType,
          ),
          dataDestination: Destination(
            destinationCode: _pantauPaketmu.transaction?.destinationCode,
            zipCode: _pantauPaketmu.cnoteReceiverZip,
            cityName: _pantauPaketmu.transaction?.receiverCity,
            countryName: _pantauPaketmu.transaction?.receiverCountry,
            districtName: _pantauPaketmu.transaction?.receiverDistrict,
            provinceName: _pantauPaketmu.transaction?.receiverRegion,
            subdistrictName: _pantauPaketmu.transaction?.receiverSubdistrict,
          ),
          receiver: ReceiverModel(
              name: _pantauPaketmu.receiverName,
              zipCode: _pantauPaketmu.cnoteReceiverZip,
              destinationCode: _pantauPaketmu.transaction?.destinationCode,
              destinationDescription:
                  _pantauPaketmu.transaction?.destinationDesc,
              city: _pantauPaketmu.transaction?.receiverCity,
              country: _pantauPaketmu.transaction?.receiverCountry,
              contact: _pantauPaketmu.cnoteReceiverContact,
              phone: _pantauPaketmu.cnoteReceiverPhone,
              address:
                  '${_pantauPaketmu.cnoteReceiverAddr1}${_pantauPaketmu.cnoteReceiverAddr2}${_pantauPaketmu.cnoteReceiverAddr3}',
              region: _pantauPaketmu.transaction?.receiverRegion,
              district: _pantauPaketmu.transaction?.receiverDistrict,
              subDistrict: _pantauPaketmu.transaction?.receiverSubdistrict),
          shipper: ShipperModel(
            name: _pantauPaketmu.cnoteShipperName,
            address:
                '${_pantauPaketmu.cnoteShipperAddr1}${_pantauPaketmu.cnoteShipperAddr2}${_pantauPaketmu.cnoteShipperAddr3}',
            address1: _pantauPaketmu.cnoteShipperAddr1,
            address2: _pantauPaketmu.cnoteShipperAddr2,
            address3: _pantauPaketmu.cnoteShipperAddr3,
            country: _pantauPaketmu.transaction?.shipperCountry,
            region: RegionModel(
              name: _pantauPaketmu.transaction?.shipperRegion,
            ),
            city: _pantauPaketmu.originName,
            phone: _pantauPaketmu.cnoteShipperPhone,
            contact: _pantauPaketmu.cnoteShipperContact,
            zipCode: _pantauPaketmu.cnoteShipperZip,
            origin: OriginModel(
              originCode: _pantauPaketmu.transaction?.originCode,
              originName: _pantauPaketmu.originName,
              branchCode: _pantauPaketmu.branchId,
              branch: BranchModel(
                  region: RegionModel(
                name: _pantauPaketmu.transaction?.shipperRegion,
              )),
            ),
          ),
          origin: OriginModel(
            originCode: _pantauPaketmu.transaction?.originCode,
            originName: _pantauPaketmu.originName,
            branchCode: _pantauPaketmu.branchId,
            branch: BranchModel(
                region: RegionModel(
              name: _pantauPaketmu.transaction?.shipperRegion,
            )),
          ),
          registrationId: _pantauPaketmu.registrationId,
          // status: _pantauPaketmu.transaction?.statusAwb,
          createdDate: _pantauPaketmu.transaction?.createdDateSearch,
          awb: _pantauPaketmu.awbNo,
          type: _pantauPaketmu.transaction?.apiType ??
              (_pantauPaketmu.codFlag == 'Y' ? 'COD' : 'NON COD'),
          awbType: _pantauPaketmu.transaction?.apiType,
          createAt: _pantauPaketmu.createDate,
          delivery: Delivery(
              serviceCode: _pantauPaketmu.service ??
                  _pantauPaketmu.transaction?.serviceCode,
              insuranceFlag: _pantauPaketmu.transaction?.insuranceFlag,
              codFlag: _pantauPaketmu.codFlag,
              codFee: _pantauPaketmu.codAmount,
              codOngkir: _pantauPaketmu.repcssNetCodAmt.toString(),
              flatRate: _pantauPaketmu.awbAmount,
              freightCharge: _pantauPaketmu.awbAmount,
              specialInstruction: _pantauPaketmu.awbSpecialIns,
              woodPackaging: _pantauPaketmu.transaction?.packingkayuFlag,
              flatRateWithInsurance: _pantauPaketmu.awbInsuranceValue,
              freightChargeWithInsurance: _pantauPaketmu.awbInsuranceValue,
              insuranceFee: _pantauPaketmu.awbInsuranceValue),
          goods: Goods(
            weight: _pantauPaketmu.weightAwb,
            type: _pantauPaketmu.transaction?.goodsType,
            amount: _pantauPaketmu.awbGoodsValue,
            desc: _pantauPaketmu.awbGoodsDescr,
            quantity: _pantauPaketmu.qtyAwb,
          ),
          officerEntry: _pantauPaketmu.transaction?.petugasEntry,
          orderId: _pantauPaketmu.transaction?.orderId,
        );
        update();
      });
    } catch (e, i) {
      AppLogger.e('error fetching data: $e');
      AppLogger.e('error fetching data: $i');
      _showErrorContainer = true;
      update();
    }
    _showLoadingIndicator = false;

    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    update();
  }

// Future<void> _getRequestPickupByAwb() async {
//   isLoading = true;
//   _showLoadingIndicator = true;
//   update();
//
//   try {
//     var response =
//         await network.base.get('/transaction/tracks/count/details/$awbNo');
//     var result = BaseResponse<PantauuPaketmuDetailModel>.fromJson(
//       response.data,
//       (json) =>
//           PantauuPaketmuDetailModel.fromJson(json as Map<String, dynamic>),
//     );
//
//     if (result.code == HttpStatus.ok && result.data != null) {
//       _pantauuPaketmu = result.data!;
//       _showContent = true;
//       transactionData = DataTransactionModel(
//         destination: Destination(
//           destinationCode: _pantauuPaketmu.transaction?.destinationCode,
//           zipCode: _pantauuPaketmu.cnoteReceiverZip,
//           cityName: _pantauuPaketmu.transaction?.receiverCity,
//           countryName: _pantauuPaketmu.transaction?.receiverCountry,
//           districtName: _pantauuPaketmu.transaction?.receiverDistrict,
//           provinceName: _pantauuPaketmu.transaction?.receiverRegion,
//           subdistrictName: _pantauuPaketmu.transaction?.receiverSubdistrict,
//         ),
//         account: Account(
//           accountNumber: _pantauuPaketmu.custNo,
//           accountService: _pantauuPaketmu.transaction?.accountService,
//           accountName: _pantauuPaketmu.custName,
//           accountType: _pantauuPaketmu.transaction?.accountType,
//         ),
//         dataAccount: Account(
//           accountNumber: _pantauuPaketmu.custNo,
//           accountService: _pantauuPaketmu.transaction?.accountService,
//           accountName: _pantauuPaketmu.custName,
//           accountType: _pantauuPaketmu.transaction?.accountType,
//         ),
//         dataDestination: Destination(
//           destinationCode: _pantauuPaketmu.transaction?.destinationCode,
//           zipCode: _pantauuPaketmu.cnoteReceiverZip,
//           cityName: _pantauuPaketmu.transaction?.receiverCity,
//           countryName: _pantauuPaketmu.transaction?.receiverCountry,
//           districtName: _pantauuPaketmu.transaction?.receiverDistrict,
//           provinceName: _pantauuPaketmu.transaction?.receiverRegion,
//           subdistrictName: _pantauuPaketmu.transaction?.receiverSubdistrict,
//         ),
//         receiver: ReceiverModel(
//             name: _pantauuPaketmu.receiverName,
//             zipCode: _pantauuPaketmu.cnoteReceiverZip,
//             destinationCode: _pantauuPaketmu.transaction?.destinationCode,
//             destinationDescription:
//             _pantauuPaketmu.transaction?.destinationDesc,
//             city: _pantauuPaketmu.transaction?.receiverCity,
//             country: _pantauuPaketmu.transaction?.receiverCountry,
//             contact: _pantauuPaketmu.cnoteReceiverContact,
//             phone: _pantauuPaketmu.cnoteReceiverPhone,
//             address:
//                 '${_pantauuPaketmu.cnoteReceiverAddr1}${_pantauPaketmu.cnoteReceiverAddr2}${_pantauPaketmu.cnoteReceiverAddr3}',
//             region: _pantauuPaketmu.transaction?.receiverRegion,
//             district: _pantauuPaketmu.transaction?.receiverDistrict,
//             subDistrict: _pantauuPaketmu.transaction?.receiverSubdistrict),
//         shipper: ShipperModel(
//           name: _pantauuPaketmu.cnoteShipperName,
//           address:
//               '${_pantauuPaketmu.cnoteShipperAddr1}${_pantauPaketmu.cnoteShipperAddr2}${_pantauPaketmu.cnoteShipperAddr3}',
//           address1: _pantauuPaketmu.cnoteShipperAddr1,
//           address2: _pantauuPaketmu.cnoteShipperAddr2,
//           address3: _pantauuPaketmu.cnoteShipperAddr3,
//           country: _pantauuPaketmu.transaction?.shipperCountry,
//           region: RegionModel(
//             name: _pantauuPaketmu.transaction?.shipperRegion,
//           ),
//           city: _pantauuPaketmu.originName,
//           phone: _pantauuPaketmu.cnoteShipperPhone,
//           contact: _pantauuPaketmu.cnoteShipperContact,
//           zipCode: _pantauuPaketmu.cnoteShipperZip,
//           origin: OriginModel(
//             originCode: _pantauuPaketmu.transaction?.originCode,
//             originName: _pantauuPaketmu.originName,
//             branchCode: _pantauuPaketmu.branchId,
//             branch: BranchModel(
//                 region: RegionModel(
//               name: _pantauuPaketmu.transaction?.shipperRegion,
//             )),
//           ),
//         ),
//         origin: OriginModel(
//           originCode: _pantauuPaketmu.transaction?.originCode,
//           originName: _pantauuPaketmu.originName,
//           branchCode: _pantauuPaketmu.branchId,
//           branch: BranchModel(
//               region: RegionModel(
//             name: _pantauuPaketmu.transaction?.shipperRegion,
//           )),
//         ),
//         registrationId: _pantauuPaketmu.registrationId,
//         status: _pantauuPaketmu.transaction?.statusAwb,
//         createdDate: _pantauuPaketmu.transaction?.createdDateSearch,
//         awb: _pantauuPaketmu.awbNo,
//         type: _pantauuPaketmu.transaction?.apiType,
//         awbType: _pantauuPaketmu.transaction?.apiType,
//         createAt: _pantauuPaketmu.createDate,
//         delivery: Delivery(
//             serviceCode: _pantauuPaketmu.transaction?.serviceCode,
//             insuranceFlag: _pantauuPaketmu.transaction?.insuranceFlag,
//             codFlag: _pantauuPaketmu.codFlag,
//             codFee: _pantauuPaketmu.codAmount,
//             codOngkir: _pantauuPaketmu.repcssNetCodAmt.toString(),
//             flatRate: _pantauuPaketmu.awbAmount,
//             freightCharge: _pantauuPaketmu.awbAmount,
//             specialInstruction: _pantauuPaketmu.awbSpecialIns,
//             woodPackaging: _pantauuPaketmu.transaction?.packingkayuFlag,
//             flatRateWithInsurance: _pantauuPaketmu.awbInsuranceValue,
//             freightChargeWithInsurance: _pantauuPaketmu.awbInsuranceValue,
//             insuranceFee: _pantauuPaketmu.awbInsuranceValue),
//         goods: Goods(
//           weight: _pantauuPaketmu.weightAwb,
//           type: _pantauuPaketmu.transaction?.goodsType,
//           amount: _pantauuPaketmu.awbGoodsValue,
//           desc: _pantauuPaketmu.awbGoodsDescr,
//           quantity: _pantauuPaketmu.qtyAwb,
//         ),
//         officerEntry: _pantauuPaketmu.transaction?.petugasEntry,
//         orderId: _pantauuPaketmu.transaction?.orderId,
//       );
//     } else if (result.code == HttpStatus.notFound) {
//       _showEmptyContainer = true;
//     }
//
//     update();
//   } on DioException catch (e) {
//     var result = BaseResponse<PantauuPaketmuDetailModel>.fromJson(
//       e.response?.data,
//       (json) =>
//           PantauuPaketmuDetailModel.fromJson(json as Map<String, dynamic>),
//     );
//     AppLogger.e('error fetching data: $e');
//     AppSnackBar.error('error fetching data: ${result.message}');
//     _showErrorContainer = true;
//     update();
//   }
//
//   _showLoadingIndicator = false;
//
//   await Future.delayed(const Duration(seconds: 2));
//   isLoading = false;
//   update();
// }
}

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
  String awbNo = Get.arguments?["awbNo"];

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
            accountName: _pantauPaketmu.custName,
          ),
          dataAccount: Account(
            accountNumber: _pantauPaketmu.custNo,
            accountService: _pantauPaketmu.transaction?.apiType,
            accountName: _pantauPaketmu.custName,
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
}

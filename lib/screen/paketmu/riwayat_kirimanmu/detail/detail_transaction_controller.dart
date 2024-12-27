import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:get/get.dart';

class DetailTransactionController extends BaseController {
  final state = DetailTransactionState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    state.isLoading = true;
    state.locale = await storage.readString(StorageCore.localeApp);
    update();
    state.allow =
        MenuModel.fromJson(await storage.readData(StorageCore.userMenu));

    state.transStatus.text = state.data?.statusAwb ?? '';
    state.pickupStatus.text = state.data?.pickupStatus ?? '';
    update();

    try {
      transaction.getTransactionByAWB(state.awb).then((value) {
        state.transactionModel = value.data?.copyWith(
          statusAwb: state.data?.statusAwb,
        );
        var data = value.data;

        state.transactionData = DataTransactionModel(
          destination: data?.destination,
          account: data?.account,
          dataAccount: data?.account,
          dataDestination: data?.destination,
          receiver: ReceiverModel(
            name: data?.receiverName,
            zipCode: data?.receiverZip,
            destinationCode: data?.destinationCode,
            destinationDescription: data?.destinationDesc,
            city: data?.receiverCity,
            country: data?.receiverCountry,
            contact: data?.receiverContact,
            phone: data?.receiverPhone,
            address: data?.receiverAddr,
            region: data?.receiverRegion,
            district: data?.receiverDistrict,
            subDistrict: data?.receiverSubdistrict,
          ),
          shipper: ShipperModel(
            name: data?.shipperName,
            address: data?.shipperAddr,
            address1: data?.shipperAddr1,
            address2: data?.shipperAddr2,
            address3: data?.shipperAddr3,
            country: data?.shipperCountry,
            region: RegionModel(
              name: data?.shipperRegion,
            ),
            city: data?.shipperCity,
            phone: data?.shipperPhone,
            contact: data?.shipperContact,
            zipCode: data?.shipperZip,
            origin: OriginModel(
              originCode: data?.originCode,
              originName: data?.originDesc,
              branchCode: data?.branch,
              branch: BranchModel(
                  region: RegionModel(
                name: data?.shipperRegion,
              )),
            ),
          ),
          origin: OriginModel(
            originCode: data?.originCode,
            originName: data?.originDesc,
            branchCode: data?.branch,
            branch: BranchModel(
              region: RegionModel(
                name: data?.shipperRegion,
              ),
            ),
          ),
          registrationId: data?.registrationId,
          status: data?.statusAwb,
          createdDate: data?.createdDateSearch,
          awb: data?.awb,
          type: data?.codOngkir == "YES" || data?.codFlag == "YES"
              ? "COD"
              : "NON COD",
          awbType: data?.apiType,
          createAt: data?.createdDate,
          delivery: Delivery(
              serviceCode: data?.serviceCode,
              insuranceFlag: data?.insuranceFlag,
              codFlag: data?.codFlag,
              codFee: data?.codAmount,
              codOngkir: data?.codOngkir,
              flatRate: data?.deliveryPrice,
              freightCharge: data?.deliveryPrice,
              specialInstruction: data?.specialIns,
              woodPackaging: data?.packingkayuFlag,
              flatRateWithInsurance: data?.insuranceAmount,
              freightChargeWithInsurance: data?.insuranceAmount,
              insuranceFee: data?.insuranceAmount),
          goods: Goods(
            weight: data?.weight,
            type: data?.goodsType,
            amount: data?.goodsAmount,
            desc: data?.goodsDesc,
            quantity: data?.qty,
          ),
          officerEntry: data?.petugasEntry,
          orderId: data?.orderId,
        );

        // state.transStatus.text = state.transactionModel?.statusAwb ?? '';
        // state.pickupStatus.text = state.transactionModel?.state.pickupStatus ?? '';
        update();
      });
    } catch (e, i) {
      AppLogger.e('error initData detail riwayat kiriman $e, $i');
    }
    Timer(const Duration(seconds: 2), () {
      state.isLoading = false;
      update();
    });
  }

  Future<void> deleteTransaction() async {
    try {
      await transaction
          .deleteTransaction(state.transactionModel?.awb?.toString() ?? '')
          .then((value) {
        if (value.code == 400) {
          AppSnackBar.error(value.message!.tr);
        } else {
          initData();
          update();
        }
      });
    } catch (e) {
      AppLogger.e('error delete transaction $e');
      AppSnackBar.error('Bad Request'.tr);
    }

    update();
  }

  bool isEdit() {
    if (state.transactionModel?.statusAwb == "MASIH DI KAMU") {
      if (state.transactionModel?.apiStatus == 2 ||
          state.transactionModel?.apiStatus == 7) {
        return false;
      }
      return true;
    }
    return false;
  }
}

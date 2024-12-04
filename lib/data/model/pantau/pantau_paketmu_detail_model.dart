import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';

class PantauPaketmuDetailModel {
  String awbNo;
  String? manifestInbNo;
  String? repcssDailyPayAggDatefrom;
  num? awbInsuranceValue;
  num? repcssRtFchargeAftDiscAmt;
  String? receivingCourier;
  String? receivingUserId;
  String? statusPod;
  num? repcssPaymentAmt;
  String? puLastAttempStatusDesc;
  String? cnoteReceiverAddr1;
  String? cnoteReceiverAddr2;
  num? repcssRtSurcharge;
  String? tglReceived;
  String? origin;
  String? hvoNo;
  num? repcssVatFchargeAftDisc;
  String? cnoteCancel;
  String? rdoDate;
  String? awbUserName;
  num? costWeightManifest;
  String? doDate;
  String? repcssInvoiceDate;
  num? repcssCodFee;
  String? cnoteReceiverName;
  String? hoCourierName;
  String? repcssPaymentReffid;
  String? pushFlag;
  String? manifestTransitAgen;
  String? hviNo;
  String? custName;
  String? cnoteReceiverPhone;
  String? cnoteReceiverContact;
  String? runsheetUid;
  String? codingPod;
  String? manifestApproved;
  num? repcssRtDiscAmt;
  String? userZoneCode;
  String? repcssPaytype;
  String? repcssPaymentDate;
  String? manifestTransitInbound;
  String? receivingNo;
  String? cnoteShipperAddr1;
  num? repcssSurcharge;
  String? hvoDate;
  String? originName;
  String? hvoHubName;
  String? runsheetDate;
  num? actWeightManifest;
  String? manifestDate;
  String? masterBagSmuNtu;
  String? cnoteReceiverAddr3;
  num? smuBagBux;
  String? repcssPaymentSdate;
  String? cnoteShipperAddr2;
  String? cnoteShipperAddr3;
  String? repcssPaymentCustid;
  String? smuDate;
  String? podlEpodUrl;
  num? qtyAwb;
  String? manBagNo;
  String? awbGoodsDescr;
  String createDate;
  String? hvoHubDestinationName;
  String? repcssInvoiceNo;
  String? manifestOutb;
  String? awbDate;
  num? repcssNetCodAmt;
  String? awbInsuranceId;
  num? repcssVatRtFchargeAftDisc;
  String? manifestInbDate;
  String? receivedReason;
  num? repcssInsuranceValue;
  String? commissionProcessDate;
  String? hoCourier;
  String? repcssTxinvNo;
  String? rdoNo;
  String? service;
  String? branchId;
  String? codFlag;
  String? cnoteShipperPhone;
  String? dateTransitInb;
  String? tglTransit;
  String? receiverName;
  String? manifestDestinationSmu;
  num? repcssVatCodFee;
  String? cnoteCardNo;
  num? repcssRtPackingFee;
  String? custNo;
  String? hviDate;
  String? puLastAttempStatusCode;
  String? smuEta;
  num? repcssPackingFee;
  String? podlEpodUrlPic;
  num? repcssFreightCharge;
  num? awbGoodsValue;
  String? tglUpdatePod;
  String? smSchdNo;
  String? awbRefno;
  String? dateTransitAgen;
  num? smuWeight;
  num? repcssDiscountAmt;
  String? puLastAttempStatusDate;
  String? smSchDate;
  String? userMasterBagSmu;
  String? repcssEpayTrxid;
  String? repcssEpayVend;
  String? smuFlagApprove;
  num? awbAmount;
  String? hvoHub;
  num? repcssCustDiscDm;
  String? manifestUserId;
  String? paymentType;
  String? repcssDailyPayAggDatethru;
  String? cnoteShipperContact;
  String? destination;
  String? hoCourierDate;
  String? repcssDiscRevType;
  String? cnoteShipperZip;
  String? runsheetNo;
  String? destinationName;
  String? smuDestination;
  String? tglMasterBag;
  String? smuRemarks;
  String? cnoteShipperName;
  String? awbSpecialIns;
  String? doNo;
  String? repcssRtRsheetInsSys;
  String? awbUserId;
  num? smuQty;
  String? smuFlagCancel;
  String? smuRemarksDate;
  num? repcssCustDiscIc;
  String? groupOwner;
  String? cnoteDestination;
  String? cnoteReceiverZip;
  String? noTransit;
  num? commissionAmt;
  String? smNo;
  num? awbAdditionalFee;
  num? repcssFchargeAftDiscAmt;
  String? receivingDate;
  num? codAmount;
  String? cnotePaymentType;
  String? repcssPaymentNo;
  String? runsheetCourierId;
  num? repcssRtFreightCharge;
  String? smuEtd;
  String? registrationId;
  String? hvoHubDestination;
  num? weightAwb;
  TransactionModel? transaction;
  TicketModel? ticket;

  PantauPaketmuDetailModel({
    required this.awbNo,
    this.manifestInbNo,
    this.repcssDailyPayAggDatefrom,
    this.awbInsuranceValue,
    this.repcssRtFchargeAftDiscAmt,
    this.receivingCourier,
    this.receivingUserId,
    this.statusPod,
    this.repcssPaymentAmt,
    this.puLastAttempStatusDesc,
    this.cnoteReceiverAddr1,
    this.cnoteReceiverAddr2,
    this.repcssRtSurcharge,
    this.tglReceived,
    this.origin,
    this.hvoNo,
    this.repcssVatFchargeAftDisc,
    this.cnoteCancel,
    this.rdoDate,
    this.awbUserName,
    this.costWeightManifest,
    this.doDate,
    this.repcssInvoiceDate,
    this.repcssCodFee,
    this.cnoteReceiverName,
    this.hoCourierName,
    this.repcssPaymentReffid,
    this.pushFlag,
    this.manifestTransitAgen,
    this.hviNo,
    this.custName,
    this.cnoteReceiverPhone,
    this.cnoteReceiverContact,
    this.runsheetUid,
    this.codingPod,
    this.manifestApproved,
    this.repcssRtDiscAmt,
    this.userZoneCode,
    this.repcssPaytype,
    this.repcssPaymentDate,
    this.manifestTransitInbound,
    this.receivingNo,
    this.cnoteShipperAddr1,
    this.repcssSurcharge,
    this.hvoDate,
    this.originName,
    this.hvoHubName,
    this.runsheetDate,
    this.actWeightManifest,
    this.manifestDate,
    this.masterBagSmuNtu,
    this.cnoteReceiverAddr3,
    this.smuBagBux,
    this.repcssPaymentSdate,
    this.cnoteShipperAddr2,
    this.cnoteShipperAddr3,
    this.repcssPaymentCustid,
    this.smuDate,
    this.podlEpodUrl,
    this.qtyAwb,
    this.manBagNo,
    this.awbGoodsDescr,
    required this.createDate,
    this.hvoHubDestinationName,
    this.repcssInvoiceNo,
    this.manifestOutb,
    this.awbDate,
    this.repcssNetCodAmt,
    this.awbInsuranceId,
    this.repcssVatRtFchargeAftDisc,
    this.manifestInbDate,
    this.receivedReason,
    this.repcssInsuranceValue,
    this.commissionProcessDate,
    this.hoCourier,
    this.repcssTxinvNo,
    this.rdoNo,
    this.service,
    this.branchId,
    this.codFlag,
    this.cnoteShipperPhone,
    this.dateTransitInb,
    this.tglTransit,
    this.receiverName,
    this.manifestDestinationSmu,
    this.repcssVatCodFee,
    this.cnoteCardNo,
    this.repcssRtPackingFee,
    this.custNo,
    this.hviDate,
    this.puLastAttempStatusCode,
    this.smuEta,
    this.repcssPackingFee,
    this.podlEpodUrlPic,
    this.repcssFreightCharge,
    this.awbGoodsValue,
    this.tglUpdatePod,
    this.smSchdNo,
    this.awbRefno,
    this.dateTransitAgen,
    this.smuWeight,
    this.repcssDiscountAmt,
    this.puLastAttempStatusDate,
    this.smSchDate,
    this.userMasterBagSmu,
    this.repcssEpayTrxid,
    this.repcssEpayVend,
    this.smuFlagApprove,
    this.awbAmount,
    this.hvoHub,
    this.repcssCustDiscDm,
    this.manifestUserId,
    this.paymentType,
    this.repcssDailyPayAggDatethru,
    this.cnoteShipperContact,
    this.destination,
    this.hoCourierDate,
    this.repcssDiscRevType,
    this.cnoteShipperZip,
    this.runsheetNo,
    this.destinationName,
    this.smuDestination,
    this.tglMasterBag,
    this.smuRemarks,
    this.cnoteShipperName,
    this.awbSpecialIns,
    this.doNo,
    this.repcssRtRsheetInsSys,
    this.awbUserId,
    this.smuQty,
    this.smuFlagCancel,
    this.smuRemarksDate,
    this.repcssCustDiscIc,
    this.groupOwner,
    this.cnoteDestination,
    this.cnoteReceiverZip,
    this.noTransit,
    this.commissionAmt,
    this.smNo,
    this.awbAdditionalFee,
    this.repcssFchargeAftDiscAmt,
    this.receivingDate,
    this.codAmount,
    this.cnotePaymentType,
    this.repcssPaymentNo,
    this.runsheetCourierId,
    this.repcssRtFreightCharge,
    this.smuEtd,
    this.registrationId,
    this.hvoHubDestination,
    this.weightAwb,
    this.transaction,
    this.ticket,
  });

  // Factory constructor
  factory PantauPaketmuDetailModel.fromJson(Map<String, dynamic> json) {
    return PantauPaketmuDetailModel(
      awbNo: json['awbNo'] ?? '',
      manifestInbNo: json['manifestInbNo'],
      repcssDailyPayAggDatefrom: json['repcssDailyPayAggDatefrom'],
      awbInsuranceValue: json['awbInsuranceValue'],
      repcssRtFchargeAftDiscAmt: json['repcssRtFchargeAftDiscAmt'],
      receivingCourier: json['receivingCourier'],
      receivingUserId: json['receivingUserId'],
      statusPod: json['statusPod'],
      repcssPaymentAmt: json['repcssPaymentAmt'],
      puLastAttempStatusDesc: json['puLastAttempStatusDesc'],
      cnoteReceiverAddr1: json['cnoteReceiverAddr1'],
      cnoteReceiverAddr2: json['cnoteReceiverAddr2'],
      repcssRtSurcharge: json['repcssRtSurcharge'],
      tglReceived: json['tglReceived'],
      origin: json['origin'],
      hvoNo: json['hvoNo'],
      repcssVatFchargeAftDisc: json['repcssVatFchargeAftDisc'],
      cnoteCancel: json['cnoteCancel'],
      rdoDate: json['rdoDate'],
      awbUserName: json['awbUserName'],
      costWeightManifest: json['costWeightManifest'],
      doDate: json['doDate'],
      repcssInvoiceDate: json['repcssInvoiceDate'],
      repcssCodFee: json['repcssCodFee'],
      cnoteReceiverName: json['cnoteReceiverName'],
      hoCourierName: json['hoCourierName'],
      repcssPaymentReffid: json['repcssPaymentReffid'],
      pushFlag: json['pushFlag'],
      manifestTransitAgen: json['manifestTransitAgen'],
      hviNo: json['hviNo'],
      custName: json['custName'],
      cnoteReceiverPhone: json['cnoteReceiverPhone'],
      cnoteReceiverContact: json['cnoteReceiverContact'],
      runsheetUid: json['runsheetUid'],
      codingPod: json['codingPod'],
      manifestApproved: json['manifestApproved'],
      repcssRtDiscAmt: json['repcssRtDiscAmt'],
      userZoneCode: json['userZoneCode'],
      repcssPaytype: json['repcssPaytype'],
      repcssPaymentDate: json['repcssPaymentDate'],
      manifestTransitInbound: json['manifestTransitInbound'],
      receivingNo: json['receivingNo'],
      cnoteShipperAddr1: json['cnoteShipperAddr1'],
      repcssSurcharge: json['repcssSurcharge'],
      hvoDate: json['hvoDate'],
      originName: json['originName'],
      hvoHubName: json['hvoHubName'],
      runsheetDate: json['runsheetDate'],
      actWeightManifest: json['actWeightManifest'],
      manifestDate: json['manifestDate'],
      masterBagSmuNtu: json['masterBagSmuNtu'],
      cnoteReceiverAddr3: json['cnoteReceiverAddr3'],
      smuBagBux: json['smuBagBux'],
      repcssPaymentSdate: json['repcssPaymentSdate'],
      cnoteShipperAddr2: json['cnoteShipperAddr2'],
      cnoteShipperAddr3: json['cnoteShipperAddr3'],
      repcssPaymentCustid: json['repcssPaymentCustid'],
      smuDate: json['smuDate'],
      podlEpodUrl: json['podlEpodUrl'],
      qtyAwb: json['qtyAwb'],
      manBagNo: json['manBagNo'],
      awbGoodsDescr: json['awbGoodsDescr'],
      createDate: json['createDate'] ?? '',
      hvoHubDestinationName: json['hvoHubDestinationName'],
      repcssInvoiceNo: json['repcssInvoiceNo'],
      manifestOutb: json['manifestOutb'],
      awbDate: json['awbDate'],
      repcssNetCodAmt: json['repcssNetCodAmt'],
      awbInsuranceId: json['awbInsuranceId'],
      repcssVatRtFchargeAftDisc: json['repcssVatRtFchargeAftDisc'],
      manifestInbDate: json['manifestInbDate'],
      receivedReason: json['receivedReason'],
      repcssInsuranceValue: json['repcssInsuranceValue'],
      commissionProcessDate: json['commissionProcessDate'],
      hoCourier: json['hoCourier'],
      repcssTxinvNo: json['repcssTxinvNo'],
      rdoNo: json['rdoNo'],
      service: json['service'],
      branchId: json['branchId'],
      codFlag: json['codFlag'],
      cnoteShipperPhone: json['cnoteShipperPhone'],
      dateTransitInb: json['dateTransitInb'],
      tglTransit: json['tglTransit'],
      receiverName: json['receiverName'],
      manifestDestinationSmu: json['manifestDestinationSmu'],
      repcssVatCodFee: json['repcssVatCodFee'],
      cnoteCardNo: json['cnoteCardNo'],
      repcssRtPackingFee: json['repcssRtPackingFee'],
      custNo: json['custNo'],
      hviDate: json['hviDate'],
      puLastAttempStatusCode: json['puLastAttempStatusCode'],
      smuEta: json['smuEta'],
      repcssPackingFee: json['repcssPackingFee'],
      podlEpodUrlPic: json['podlEpodUrlPic'],
      repcssFreightCharge: json['repcssFreightCharge'],
      awbGoodsValue: json['awbGoodsValue'],
      tglUpdatePod: json['tglUpdatePod'],
      smSchdNo: json['smSchdNo'],
      awbRefno: json['awbRefno'],
      dateTransitAgen: json['dateTransitAgen'],
      smuWeight: json['smuWeight'],
      repcssDiscountAmt: json['repcssDiscountAmt'],
      puLastAttempStatusDate: json['puLastAttempStatusDate'],
      smSchDate: json['smSchDate'],
      userMasterBagSmu: json['userMasterBagSmu'],
      repcssEpayTrxid: json['repcssEpayTrxid'],
      repcssEpayVend: json['repcssEpayVend'],
      smuFlagApprove: json['smuFlagApprove'],
      awbAmount: json['awbAmount'],
      hvoHub: json['hvoHub'],
      repcssCustDiscDm: json['repcssCustDiscDm'],
      manifestUserId: json['manifestUserId'],
      paymentType: json['paymentType'],
      repcssDailyPayAggDatethru: json['repcssDailyPayAggDatethru'],
      cnoteShipperContact: json['cnoteShipperContact'],
      destination: json['destination'],
      hoCourierDate: json['hoCourierDate'],
      repcssDiscRevType: json['repcssDiscRevType'],
      cnoteShipperZip: json['cnoteShipperZip'],
      runsheetNo: json['runsheetNo'],
      destinationName: json['destinationName'],
      smuDestination: json['smuDestination'],
      tglMasterBag: json['tglMasterBag'],
      smuRemarks: json['smuRemarks'],
      cnoteShipperName: json['cnoteShipperName'],
      awbSpecialIns: json['awbSpecialIns'],
      doNo: json['doNo'],
      repcssRtRsheetInsSys: json['repcssRtRsheetInsSys'],
      awbUserId: json['awbUserId'],
      smuQty: json['smuQty'],
      smuFlagCancel: json['smuFlagCancel'],
      smuRemarksDate: json['smuRemarksDate'],
      repcssCustDiscIc: json['repcssCustDiscIc'],
      groupOwner: json['groupOwner'],
      cnoteDestination: json['cnoteDestination'],
      cnoteReceiverZip: json['cnoteReceiverZip'],
      noTransit: json['noTransit'],
      commissionAmt: json['commissionAmt'],
      smNo: json['smNo'],
      awbAdditionalFee: json['awbAdditionalFee'],
      repcssFchargeAftDiscAmt: json['repcssFchargeAftDiscAmt'],
      receivingDate: json['receivingDate'],
      codAmount: json['codAmount'],
      cnotePaymentType: json['cnotePaymentType'],
      repcssPaymentNo: json['repcssPaymentNo'],
      runsheetCourierId: json['runsheetCourierId'],
      repcssRtFreightCharge: json['repcssRtFreightCharge'],
      smuEtd: json['smuEtd'],
      registrationId: json['registrationId'],
      hvoHubDestination: json['hvoHubDestination'],
      weightAwb: json['weightAwb'],
      transaction: json['transaction'],
      ticket: json['ticket'],
    );
  }
}

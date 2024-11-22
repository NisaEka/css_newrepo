class RequestPickupDetailModel {
  final String awb;
  final String createdDateSearch;
  final String apiType;
  final String serviceCode;
  final String shipperName;
  final String shipperCity;
  final String receiverName;
  final String receiverCity;
  final String receiverPhone;
  final num? codAmount;
  final String? pickupName;
  final String? pickupPicPhone;
  final String? pickupCity;
  final String? pickupDistrict;
  final String? pickupAddress;
  final String? pickupService;
  final String? pickupVehicle;
  final String? pickupDate;
  final String? pickupTime;
  final String? pickupPic;
  final String? statusDesc;
  final String? custId;
  final String petugasEntry;
  final String? goodDesc;
  final num? weight;
  final String status;
  final String? pickupStatus;
  final String? infoStatus;

  RequestPickupDetailModel({
    required this.awb,
    required this.createdDateSearch,
    required this.apiType,
    required this.serviceCode,
    required this.shipperName,
    required this.shipperCity,
    required this.receiverName,
    required this.receiverCity,
    required this.receiverPhone,
    this.codAmount,
    this.pickupName,
    this.pickupPicPhone,
    this.pickupCity,
    this.pickupDistrict,
    this.pickupAddress,
    this.pickupService,
    this.pickupVehicle,
    this.pickupDate,
    this.pickupTime,
    this.pickupPic,
    this.statusDesc,
    this.custId,
    required this.petugasEntry,
    this.goodDesc,
    this.weight,
    required this.status,
    this.pickupStatus,
    this.infoStatus,
  });

  factory RequestPickupDetailModel.fromJson(Map<String, dynamic> json) =>
      RequestPickupDetailModel(
        awb: json['awb'] ?? '',
        petugasEntry: json['petugasEntry'] ?? '',
        createdDateSearch: json['createdDateSearch'] ?? '',
        apiType: json['apiType'] ?? '',
        serviceCode: json['serviceCode'] ?? '',
        codAmount: json['codAmount'],
        shipperName: json['shipperName'] ?? '',
        shipperCity: json['shipperCity'] ?? '',
        receiverName: json['receiverName'] ?? '',
        receiverCity: json['receiverCity'] ?? '',
        receiverPhone: json['receiverPhone'] ?? '',
        status: json['status'] ?? '',
        pickupStatus: json['pickupStatus'] ?? '',
        // Optional fields with nullable handling
        pickupName: json['pickupName'],
        pickupPicPhone: json['pickupPicPhone'],
        pickupCity: json['pickupCity'],
        pickupDistrict: json['pickupDistrict'],
        pickupAddress: json['pickupAddress'],
        pickupService: json['pickupService'],
        pickupVehicle: json['pickupVehicle'],
        pickupDate: json['pickupDate'],
        pickupTime: json['pickupTime'],
        pickupPic: json['pickupPic'],
        statusDesc: json['statusDesc'],
        custId: json['custId'],
        goodDesc: json['goodDesc'],
        weight: json['weight'],
        infoStatus: json['infoStatus'],
      );
}

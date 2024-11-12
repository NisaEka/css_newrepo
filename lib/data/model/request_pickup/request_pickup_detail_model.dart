class RequestPickupDetailModel {
  final String awb;
  final String petugasEntry;
  final String createdDateSearch;
  final String apiType;
  final String serviceCode;
  final num? codAmount;
  final String shipperName;
  final String shipperCity;
  final String receiverName;
  final String receiverCity;
  final String receiverPhone;
  final String status;
  final String? pickupStatus;

  RequestPickupDetailModel({
    required this.awb,
    required this.petugasEntry,
    required this.createdDateSearch,
    required this.apiType,
    required this.serviceCode,
    required this.codAmount,
    required this.shipperName,
    required this.shipperCity,
    required this.receiverName,
    required this.receiverCity,
    required this.receiverPhone,
    required this.status,
    required this.pickupStatus,
  });

  factory RequestPickupDetailModel.fromJson(Map<String, dynamic> json) =>
      RequestPickupDetailModel(
        awb: json['awb'] ?? '',
        petugasEntry: json['petugasEntry'] ?? '',
        createdDateSearch: json['createdDateSearch'] ?? '',
        apiType: json['apiType'] ?? '',
        serviceCode: json['serviceCode'] ?? '',
        codAmount: json['codAmount'] ?? 0,
        shipperName: json['shipperName'] ?? '',
        shipperCity: json['shipperCity'] ?? '',
        receiverName: json['receiverName'] ?? '',
        receiverCity: json['receiverCity'] ?? '',
        receiverPhone: json['receiverPhone'] ?? '',
        status: json['status'] ?? '',
        pickupStatus: json['pickupStatus'] ?? '',
      );
}

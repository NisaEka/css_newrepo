class RequestPickupDetailModel {

  final String awb;
  final String officerEntry;
  final String date;
  final String type;
  final String service;
  final num? codFee;
  final String shipperName;
  final String shipperCity;
  final String receiverName;
  final String receiverCity;
  final String receiverPhone;
  final String status;
  final String? statusPickup;

  RequestPickupDetailModel({
    required this.awb,
    required this.officerEntry,
    required this.date,
    required this.type,
    required this.service,
    required this.codFee,
    required this.shipperName,
    required this.shipperCity,
    required this.receiverName,
    required this.receiverCity,
    required this.receiverPhone,
    required this.status,
    required this.statusPickup,
  });

  factory RequestPickupDetailModel.fromJson(Map<String, dynamic> json) => RequestPickupDetailModel(
    awb: json['awb'] ?? '',
    officerEntry: json['officer_entry'] ?? '',
    date: json['date'] ?? '',
    type: json['type'] ?? '',
    service: json['service'] ?? '',
    codFee: json['cod_fee'] ?? 0,
    shipperName: json['shipper_name'] ?? '',
    shipperCity: json['shipper_city'] ?? '',
    receiverName: json['receiver_name'] ?? '',
    receiverCity: json['receiver_city'] ?? '',
    receiverPhone: json['receiver_phone'] ?? '',
    status: json['status'] ?? '',
    statusPickup: json['status_pickup'] ?? '',
  );

}
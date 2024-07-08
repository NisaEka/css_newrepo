class RequestPickupDetailModel {

  final String awb;
  final String officerEntry;
  final String date;
  final String type;
  final String service;
  final int codFee;
  final String shipperName;
  final String shipperCity;
  final String receiverName;
  final String receiverCity;
  final String receiverPhone;
  final String status;
  final String statusPickup;

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
    awb: json['awb'] as String,
    officerEntry: json['officer_entry'] as String,
    date: json['date'] as String,
    type: json['type'] as String,
    service: json['service'] as String,
    codFee: json['cod_fee'] as int,
    shipperName: json['shipper_name'] as String,
    shipperCity: json['shipper_city'] as String,
    receiverName: json['receiver_name'] as String,
    receiverCity: json['receiver_city'] as String,
    receiverPhone: json['receiver_phone'] as String,
    status: json['status'] as String,
    statusPickup: json['status_pickup'] as String,
  );

}
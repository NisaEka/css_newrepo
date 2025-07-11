class RequestPickupCreateRequestModel {
  final List<String> awbs;
  final String pickupAddressId;
  final String pickupTime;
  final String vehicle;

  RequestPickupCreateRequestModel({
    required this.awbs,
    required this.pickupAddressId,
    required this.pickupTime,
    required this.vehicle,
  });

  Map<String, dynamic> toJson() => {
        'awbs': awbs,
        'pickupDataId': pickupAddressId,
        'pickupTime': pickupTime,
        "pickupVehicle": vehicle,
      };
}

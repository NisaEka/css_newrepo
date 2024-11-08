class RequestPickupCreateRequestModel {
  final List<String> awbs;
  final String pickupAddressId;
  final String pickupTime;

  RequestPickupCreateRequestModel({
    required this.awbs,
    required this.pickupAddressId,
    required this.pickupTime,
  });

  Map<String, dynamic> toJson() => {
        'awbs': awbs,
        'pickupDataId': pickupAddressId,
        'pickupTime': pickupTime,
      };
}

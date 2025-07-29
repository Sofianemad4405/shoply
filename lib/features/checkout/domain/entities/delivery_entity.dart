class DeliveryEntity {
  final String street;
  final String city;
  final String governate;
  final String country;
  final String zipCode;
  final String building;
  final String apartment;
  final String landmark;
  final bool isDeliveryStandard;

  DeliveryEntity({
    required this.street,
    required this.city,
    required this.governate,
    required this.country,
    required this.zipCode,
    required this.building,
    required this.apartment,
    required this.landmark,
    required this.isDeliveryStandard,
  });
}

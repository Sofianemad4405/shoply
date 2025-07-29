import 'package:shopify/features/checkout/domain/entities/delivery_entity.dart';

class Delivery {
  final String street;
  final String city;
  final String governate;
  final String country;
  final String zipCode;
  final String building;
  final String apartment;
  final String landmark;

  final bool isDeliveryStandard;

  Delivery({
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

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    street: json["street"],
    city: json["city"],
    governate: json["governate"],
    country: json["country"],
    zipCode: json["zipCode"],
    building: json["building"],
    apartment: json["apartment"],
    landmark: json["landmark"],
    isDeliveryStandard: json["isDeliveryStandard"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "governate": governate,
    "country": country,
    "zipCode": zipCode,
    "building": building,
    "apartment": apartment,
    "landmark": landmark,
    "isDeliveryStandard": isDeliveryStandard,
  };

  DeliveryEntity toEntity() => DeliveryEntity(
    street: street,
    city: city,
    governate: governate,
    country: country,
    zipCode: zipCode,
    building: building,
    apartment: apartment,
    landmark: landmark,
    isDeliveryStandard: isDeliveryStandard,
  );

  factory Delivery.fromEntity(DeliveryEntity entity) => Delivery(
    street: entity.street,
    city: entity.city,
    governate: entity.governate,
    country: entity.country,
    zipCode: entity.zipCode,
    building: entity.building,
    apartment: entity.apartment,
    landmark: entity.landmark,
    isDeliveryStandard: entity.isDeliveryStandard,
  );
}

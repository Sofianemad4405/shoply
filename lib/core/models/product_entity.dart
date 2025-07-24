class ProductEntity {
  final int id;
  final String name;
  final String details;
  final double price;
  final int stock;
  int quantity;

  final String? image;
  final String? brand;
  final List<String>? tags;
  final String? availabilityStatus;
  final List<String>? images;
  final double? discountPercentage;
  final num? rating;
  final List<Map<String, dynamic>> reviews;
  final Map<String, double>? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.details,
    required this.price,
    required this.stock,
    required this.quantity,
    this.brand,
    this.tags,
    this.availabilityStatus,
    this.images,
    this.discountPercentage,
    this.rating,
    required this.reviews,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
  });
}

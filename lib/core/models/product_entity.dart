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

  ProductEntity copyWith({
    int? id,
    String? name,
    String? image,
    double? price,
    int? quantity,
    int? stock,
    String? details,
    List<String>? tags,
    String? availabilityStatus,
    List<String>? images,
    double? discountPercentage,
    num? rating,
    // List<Map<String, dynamic>> reviews,
    Map<String, double>? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      stock: stock ?? this.stock,
      details: details ?? this.details,
      tags: tags ?? this.tags,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      images: images ?? this.images,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      reviews: reviews,
      dimensions: dimensions ?? this.dimensions,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      shippingInformation: shippingInformation ?? this.shippingInformation,
    );
  }
}

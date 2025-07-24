import 'package:shopify/core/models/product_entity.dart';

class Product extends ProductEntity {
  Product({
    required int productId,
    required String? thumbnail,
    required String? title,
    required String? description,
    required double? productPrice,
    required super.discountPercentage,
    required super.rating,
    required super.tags,
    required super.brand,
    required super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.images,
    required super.reviews,
    int? qt,
    required super.stock,
  }) : super(
         id: productId,
         name: title ?? '',
         image: thumbnail ?? '',
         details: description ?? '',
         price: productPrice ?? 0.0,
         quantity: qt ?? 1,
       );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["id"] ?? 0,
      thumbnail: json["thumbnail"],
      title: json["title"],
      description: json["description"],
      productPrice: (json["price"] as num?)?.toDouble(),
      discountPercentage: (json["discountPercentage"] as num?)?.toDouble(),
      rating: json["rating"],
      stock: json["stock"] ?? 0,
      tags: json["tags"] != null ? List<String>.from(json["tags"]) : [],
      brand: json["brand"],
      dimensions:
          json["dimensions"] != null
              ? Map<String, double>.from(
                (json["dimensions"] as Map).map(
                  (key, value) =>
                      MapEntry(key.toString(), (value as num).toDouble()),
                ),
              )
              : {},
      warrantyInformation: json["warrantyInformation"],
      shippingInformation: json["shippingInformation"],
      availabilityStatus: json["availabilityStatus"],
      images: json["images"] != null ? List<String>.from(json["images"]) : [],
      qt: json["qt"] ?? 1,
      reviews:
          json["reviews"] != null
              ? List<Map<String, dynamic>>.from(json["reviews"])
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "thumbnail": image,
      "title": name,
      "description": details,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "tags": tags,
      "brand": brand,
      "availabilityStatus": availabilityStatus,
      "images": images,
      "qt": quantity,
      "reviews": reviews,
      "dimensions": dimensions,
      "warrantyInformation": warrantyInformation,
      "shippingInformation": shippingInformation,
    };
  }

  factory Product.fromEntity(ProductEntity entity) {
    return Product(
      productId: entity.id,
      thumbnail: entity.image,
      title: entity.name,
      description: entity.details,
      productPrice: entity.price,
      discountPercentage: entity.discountPercentage,
      rating: entity.rating,
      stock: entity.stock,
      tags: entity.tags,
      brand: entity.brand,
      availabilityStatus: entity.availabilityStatus,
      images: entity.images,
      qt: entity.quantity,
      reviews: entity.reviews,
      dimensions: entity.dimensions,
      warrantyInformation: entity.warrantyInformation,
      shippingInformation: entity.shippingInformation,
    );
  }

  ProductEntity toEntity() => this;
}

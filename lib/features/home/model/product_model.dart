import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? thumbnail;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final double? price;
  @HiveField(5)
  final double? discountPercentage;
  @HiveField(6)
  final num? rating;
  @HiveField(7)
  final int stock;
  @HiveField(8)
  final List<String>? tags;
  @HiveField(9)
  final String? brand;
  @HiveField(10)
  final Map<String, double>? dimensions;
  @HiveField(11)
  final String? warrantyInformation;
  @HiveField(12)
  final String? shippingInformation;
  @HiveField(13)
  final String? availabilityStatus;
  @HiveField(14)
  final List<Review>? reviews;
  @HiveField(15)
  final List<String>? images;
  @HiveField(16)
  final Meta? meta;
  @HiveField(17)
  int? qt;
  @HiveField(18)
  bool isLiked;
  @HiveField(19)
  bool isAddedToCart;

  Product({
    this.isLiked = false,
    this.isAddedToCart = false,
    this.qt = 1,
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.images,
    required this.meta,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      thumbnail: json["thumbnail"],
      title: json["title"],
      description: json["description"],
      price: (json["price"] is num) ? (json["price"] as num).toDouble() : null,
      discountPercentage:
          (json["discountPercentage"] is num)
              ? (json["discountPercentage"] as num).toDouble()
              : null,
      rating: (json["rating"] is num) ? json["rating"] as num : null,
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
      reviews:
          json["reviews"] != null
              ? List<Review>.from(
                json["reviews"].map((r) => Review.fromJson(r)),
              )
              : [],
      images: json["images"] != null ? List<String>.from(json["images"]) : [],
      meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : null,
    );
  }
}

@HiveType(typeId: 1)
class Meta extends HiveObject {
  @HiveField(0)
  final String createdAt;
  @HiveField(1)
  final String updatedAt;
  @HiveField(2)
  final String barcode;
  @HiveField(3)
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      barcode: json["barcode"],
      qrCode: json["qrCode"],
    );
  }
}

@HiveType(typeId: 2)
class Review extends HiveObject {
  @HiveField(0)
  final int rating;
  @HiveField(1)
  final String comment;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String reviewerName;
  @HiveField(4)
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json["rating"],
      comment: json["comment"],
      date: json["date"],
      reviewerName: json["reviewerName"],
      reviewerEmail: json["reviewerEmail"],
    );
  }
}

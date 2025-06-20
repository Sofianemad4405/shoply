class Product {
  final int id;
  final String? thumbnail;
  final String? title;
  final String? description;
  final double? price;
  final double? discountPercentage;
  final num? rating;
  final int stock;
  final List<String>? tags;
  final String? brand;
  final Map<String, double>? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review>? reviews;
  final List<String>? images;
  final Meta? meta;
  int? qt;
  bool isLiked;
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

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
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

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
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

// class Category {
//   final String slug;
//   final String name;
//   final String url;

//   Category({required this.slug, required this.name, required this.url});

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(slug: json["slug"], name: json["name"], url: json["url"]);
//   }
// }

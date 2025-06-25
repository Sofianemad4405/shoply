// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      isLiked: fields[18] as bool,
      isAddedToCart: fields[19] as bool,
      qt: fields[17] as int?,
      id: fields[0] as int,
      thumbnail: fields[1] as String?,
      title: fields[2] as String?,
      description: fields[3] as String?,
      price: fields[4] as double?,
      discountPercentage: fields[5] as double?,
      rating: fields[6] as num?,
      stock: fields[7] as int,
      tags: (fields[8] as List?)?.cast<String>(),
      brand: fields[9] as String?,
      dimensions: (fields[10] as Map?)?.cast<String, double>(),
      warrantyInformation: fields[11] as String?,
      shippingInformation: fields[12] as String?,
      availabilityStatus: fields[13] as String?,
      reviews: (fields[14] as List?)?.cast<Review>(),
      images: (fields[15] as List?)?.cast<String>(),
      meta: fields[16] as Meta?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.discountPercentage)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.stock)
      ..writeByte(8)
      ..write(obj.tags)
      ..writeByte(9)
      ..write(obj.brand)
      ..writeByte(10)
      ..write(obj.dimensions)
      ..writeByte(11)
      ..write(obj.warrantyInformation)
      ..writeByte(12)
      ..write(obj.shippingInformation)
      ..writeByte(13)
      ..write(obj.availabilityStatus)
      ..writeByte(14)
      ..write(obj.reviews)
      ..writeByte(15)
      ..write(obj.images)
      ..writeByte(16)
      ..write(obj.meta)
      ..writeByte(17)
      ..write(obj.qt)
      ..writeByte(18)
      ..write(obj.isLiked)
      ..writeByte(19)
      ..write(obj.isAddedToCart);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetaAdapter extends TypeAdapter<Meta> {
  @override
  final int typeId = 1;

  @override
  Meta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meta(
      createdAt: fields[0] as String,
      updatedAt: fields[1] as String,
      barcode: fields[2] as String,
      qrCode: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Meta obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.barcode)
      ..writeByte(3)
      ..write(obj.qrCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReviewAdapter extends TypeAdapter<Review> {
  @override
  final int typeId = 2;

  @override
  Review read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Review(
      rating: fields[0] as int,
      comment: fields[1] as String,
      date: fields[2] as String,
      reviewerName: fields[3] as String,
      reviewerEmail: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Review obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.rating)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.reviewerName)
      ..writeByte(4)
      ..write(obj.reviewerEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

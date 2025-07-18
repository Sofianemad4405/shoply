// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'user_model.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class UserModelAdapter extends TypeAdapter<UserModel> {
//   @override
//   final int typeId = 3;

//   @override
//   UserModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return UserModel(
//       following: fields[5] as int,
//       name: fields[0] as String,
//       location: fields[1] as String,
//       bio: fields[2] as String?,
//       profileImage: fields[3] as String?,
//       followedBrands: (fields[4] as List?)?.cast<Brand>(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, UserModel obj) {
//     writer
//       ..writeByte(6)
//       ..writeByte(0)
//       ..write(obj.name)
//       ..writeByte(1)
//       ..write(obj.location)
//       ..writeByte(2)
//       ..write(obj.bio)
//       ..writeByte(3)
//       ..write(obj.profileImage)
//       ..writeByte(4)
//       ..write(obj.followedBrands)
//       ..writeByte(5)
//       ..write(obj.following);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }

// class BrandAdapter extends TypeAdapter<Brand> {
//   @override
//   final int typeId = 4;

//   @override
//   Brand read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Brand(
//       id: fields[0] as int,
//       name: fields[1] as String,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Brand obj) {
//     writer
//       ..writeByte(2)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.name);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is BrandAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }

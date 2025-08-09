import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopify/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.location,
    required super.email,
    required super.uId,
  });
  factory UserModel.empty() =>
      UserModel(name: "", location: "", email: "", uId: "");
  factory UserModel.fromJson(json) {
    return UserModel(
      name: json['name'] ?? "",
      location: json['location'] ?? "",
      email: json['email'] ?? "",
      uId: json['uId'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'location': location, 'email': email, 'uId': uId};
  }

  factory UserModel.fromUserEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      location: user.location,
      email: user.email,
      uId: user.uId,
    );
  }
  factory UserModel.fromFireBase(User user) {
    return UserModel(
      name: user.displayName!,
      location: user.email!,
      email: user.email!,
      uId: user.uid,
    );
  }
  toMap() {
    return {'name': name, 'email': email, 'uId': uId};
  }
}

// @HiveType(typeId: 4)
// class Brand extends HiveObject {
//   @HiveField(0)
//   final int id;
//   @HiveField(1)
//   final String name;

//   Brand({required this.id, required this.name});
// }

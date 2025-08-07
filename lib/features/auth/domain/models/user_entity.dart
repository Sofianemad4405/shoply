import 'package:shopify/features/auth/data/model/user_model.dart';

class UserEntity {
  final String name;
  final String location;
  final String email;
  final String uId;
  UserEntity({
    required this.name,
    required this.location,
    required this.email,
    required this.uId,
  });
  factory UserEntity.fromUserModel(UserModel userModel) {
    return UserEntity(
      name: userModel.name,
      location: userModel.location,
      email: userModel.email,
      uId: userModel.uId,
    );
  }
  UserEntity copyWith({
    String? name,
    String? location,
    String? email,
    String? uId,
  }) {
    return UserEntity(
      name: name ?? this.name,
      location: location ?? this.location,
      email: email ?? this.email,
      uId: uId ?? this.uId,
    );
  }
}

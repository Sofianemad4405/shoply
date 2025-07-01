import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String location;
  @HiveField(2)
  final String? bio;
  @HiveField(3)
  final String? profileImage;
  @HiveField(4)
  final List<Brand>? followedBrands;
  @HiveField(5)
  int following;

  UserModel({
    this.following = 0,
    required this.name,
    required this.location,
    this.bio,
    this.profileImage,
    this.followedBrands,
  });
}

@HiveType(typeId: 4)
class Brand extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  Brand({required this.id, required this.name});
}

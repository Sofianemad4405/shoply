class User {
  final String name;
  final String location;
  final String bio;
  final String birthDate;
  final String userName;
  final String profileImage;
  final List<Brand> followedBrands;
  int following;

  User({
    required this.bio,
    required this.following,
    required this.name,
    required this.location,
    required this.birthDate,
    required this.userName,
    required this.profileImage,
    required this.followedBrands,
  });
}

class Brand {
  final int id;
  final String name;

  Brand({required this.id, required this.name});
}

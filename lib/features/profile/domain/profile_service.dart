import 'package:shopify/features/auth/data/model/user_model.dart';

abstract class ProfileService {
  Future<UserModel> getUserData();
  Future<void> updateUserData(UserModel user);
}

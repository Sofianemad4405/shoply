import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/features/auth/data/model/user_model.dart';
import 'package:shopify/features/profile/domain/profile_service.dart';

class ProfileServiceImpl implements ProfileService {
  final FireStoreService fireStoreService;
  final FireBaseAuthService fireBaseAuthService;
  ProfileServiceImpl({
    required this.fireBaseAuthService,
    required this.fireStoreService,
  });
  @override
  Future<UserModel> getUserData() async {
    final uid = await fireBaseAuthService.getCurrentUserId();
    if (uid == null) {
      throw Exception("User is not logged in");
    }
    final user = await fireStoreService.getUserData(userId: uid);
    return user;
  }

  @override
  Future<void> updateUserData(UserModel user) async {
    final uid = await fireBaseAuthService.getCurrentUserId();
    if (uid == null) {
      throw Exception("User is not logged in");
    }
    await fireStoreService.updateUserData(
      path: Constants.kUser,
      documentId: uid,
      data: user.toMap(),
    );
  }
}

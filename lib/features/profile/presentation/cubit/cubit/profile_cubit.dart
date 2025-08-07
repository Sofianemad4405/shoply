import 'package:bloc/bloc.dart';
import 'package:shopify/core/services/fire_store_service.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/features/auth/domain/models/user_entity.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.fireBaseAuthService, required this.authService})
    : super(ProfileInitial());
  final FireBaseAuthService fireBaseAuthService;
  final FireStoreService authService;
  UserEntity user = UserEntity(name: "", location: "", email: "", uId: "");
  Future<void> init() async {
    await getUserData();
  }

  Future<void> getUserData() async {
    emit(ProfileLoading());
    try {
      final uid = await fireBaseAuthService.getCurrentUserId();
      if (uid == null) {
        emit(ProfileError(error: "User is not logged in"));
        return;
      }
      final userData = await authService.getUserData(userId: uid);
      user = UserEntity.fromUserModel(userData);
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String location,
  }) async {
    emit(ProfileLoading());
    try {
      final uid = await fireBaseAuthService.getCurrentUserId();
      if (uid == null) {
        emit(ProfileError(error: "User is not logged in"));
        return;
      }
      await authService.updateUserData(
        path: Constants.kUser,
        documentId: uid,
        data: {"name": name, "email": email, "location": location},
      );
      emit(ProfileUpdated());
      emit(
        ProfileLoaded(
          user: user.copyWith(name: name, email: email, location: location),
        ),
      );
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }
}

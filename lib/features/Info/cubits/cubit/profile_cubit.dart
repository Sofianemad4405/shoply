import 'package:bloc/bloc.dart';
import 'package:shopify/features/Info/model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  List<Brand> brands = [];
  UserModel user = UserModel(
    name: "",
    location: "",
    bio: "",
    profileImage: "",
    followedBrands: [],
    following: 0,
  );
  ProfileCubit() : super(ProfileInitial());

  void addBrandToFollowing(String brandName) {
    user.followedBrands?.add(Brand(name: brandName, id: brands.length));
    user.following = user.following + 1;
    brands.add(Brand(name: brandName, id: brands.length));
    emit(ProfileLoaded(brands: user.followedBrands, user: user));
  }

  void removeBrandFromFollowing(String brandName) {
    emit(ProfileLoading());
    user.followedBrands?.remove(Brand(name: brandName, id: brands.length));
    user.following = user.following - 1;
    brands.remove(Brand(name: brandName, id: brands.length));
    emit(ProfileLoaded(brands: user.followedBrands, user: user));
  }
}

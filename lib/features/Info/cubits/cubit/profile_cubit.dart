import 'package:bloc/bloc.dart';
import 'package:shopify/features/Info/model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  List<String> brands = [];
  User user = User(
    name: "",
    location: "",
    bio: "",
    birthDate: "",
    userName: "",
    profileImage: "",
    followedBrands: [],
    following: 0,
  );
  ProfileCubit() : super(ProfileInitial());

  void addBrandToFollowing() {
    user.followedBrands.add(Brand(name: brands.last, id: brands.length));
    user.following = user.following + 1;
    emit(ProfileLoaded(brands: brands, user: user));
  }

  void removeBrandFromFollowing() {
    user.followedBrands.remove(Brand(name: brands.last, id: brands.length));
    user.following = user.following - 1;
    emit(ProfileLoaded(brands: brands, user: user));
  }
}

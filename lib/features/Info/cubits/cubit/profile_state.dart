part of 'profile_cubit.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final List<Brand>? brands;
  final UserModel user;

  ProfileLoaded({required this.brands, required this.user});
}

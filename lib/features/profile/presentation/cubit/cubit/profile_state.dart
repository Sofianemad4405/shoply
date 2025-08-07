part of 'profile_cubit.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserEntity user;
  ProfileLoaded({required this.user});
}

final class ProfileUpdated extends ProfileState {}

final class ProfileError extends ProfileState {
  final String error;
  ProfileError({required this.error});
}

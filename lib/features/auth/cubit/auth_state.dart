part of 'auth_cubit.dart';

/// Base class for all Auth states
abstract class AuthState {}

/// Initial state when the AuthCubit is first created
final class AuthInitial extends AuthState {}

/// -----------------------
/// Sign Up States
/// -----------------------

final class SignUpInitial extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final UserCredential userCredential;
  final Map<String, dynamic>? userData;

  SignUpSuccess({required this.userCredential, this.userData});
}

final class SignUpError extends AuthState {
  final String message;

  SignUpError(this.message);
}

/// -----------------------
/// Sign In States
/// -----------------------

final class SignInInitial extends AuthState {}

final class SignInLoading extends AuthState {}

final class SignInSuccess extends AuthState {
  final UserCredential userCredential;
  final Map<String, dynamic>? userData;

  SignInSuccess({required this.userCredential, this.userData});
}

final class SignInError extends AuthState {
  final String message;

  SignInError(this.message);
}

final class Logout extends AuthState {}

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shopify/features/Info/model/user_model.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserModel userData = UserModel(
    name: "",
    location: "",
    bio: "",
    profileImage: "",
    followedBrands: [],
    following: 0,
  );

  // ========== SIGN UP ==========
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String location,
  }) async {
    emit(SignUpLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        userData = UserModel(
          name: name,
          location: location,
          bio: "",
          profileImage: "",
          followedBrands: [],
          following: 0,
        );
        await saveUserData(userData);
        emit(SignUpSuccess(userCredential: userCredential));
      } else {
        emit(SignUpError("User is null"));
      }
    } on FirebaseAuthException catch (e) {
      final map = {
        'weak-password': 'The password provided is too weak.',
        'email-already-in-use': 'The account already exists for that email.',
        'invalid-email': 'The email address is invalid.',
      };
      emit(SignUpError(map[e.code] ?? e.message ?? 'Unknown error'));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> logout() async {
    log("logged out");
    await FirebaseAuth.instance.signOut();
    emit(Logout());
  }

  // ========== HIVE STORAGE ==========
  Future<void> saveUserData(UserModel user) async {
    final userBox = Hive.box('userBox');
    await userBox.put('isLoggedIn', true);
    await userBox.put('userData', user);
    log("✅ User data saved to Hive.");
  }

  // ========== SIGN IN ==========
  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());
    try {
      log("Signed in Successfully");
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SignInSuccess(userCredential: userCredential));
    } on FirebaseAuthException catch (e) {
      final map = {
        'user-not-found': 'No user found for that email.',
        'wrong-password': 'Wrong password provided.',
        'invalid-email': 'The email address is invalid.',
        'user-disabled': 'This account has been disabled.',
        'too-many-requests': 'Too many attempts. Try again later.',
        'operation-not-allowed': 'Email/password accounts not enabled.',
      };
      emit(SignInError(map[e.code] ?? e.message ?? 'Login error'));
    } catch (e) {
      emit(SignInError('Unexpected error: $e'));
    }
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopify/core/errors/fire_base_auth_failure.dart';

class FireBaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FireBaseAuthFailure("Password Provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        throw FireBaseAuthFailure("Email already in use");
      }
      throw FireBaseAuthFailure(e.code);
    } catch (e) {
      throw FireBaseAuthFailure("Unexpected error: $e");
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FireBaseAuthFailure("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw FireBaseAuthFailure("Wrong password provided.");
      }
      log(e.message.toString());
      throw FireBaseAuthFailure(e.code);
    } catch (e) {
      throw FireBaseAuthFailure("Unexpected error: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw FireBaseAuthFailure("Unexpected error: $e");
    }
  }

  Future<bool> isLoggedIn() async {
    return auth.currentUser != null;
  }

  Future<String?> getCurrentUserId() async {
    return auth.currentUser?.uid;
  }

  // Future<User> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  // }
}

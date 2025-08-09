import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/errors/failure.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';
import 'package:shopify/core/utils/prefs.dart';
import 'package:shopify/core/services/database_service.dart';
import 'package:shopify/features/auth/data/model/user_model.dart';
import 'package:shopify/features/auth/domain/entities/user_entity.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FireBaseAuthService authService;
  final DatabaseService databaseService;

  AuthRepoImpl({required this.authService, required this.databaseService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String location,
  }) async {
    try {
      final user = await authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(
        name: name,
        location: location,
        email: email,
        uId: user.uid,
      );
      await addUserData(user: userEntity);
      return right(userEntity);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.code));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserEntity userEntity = await getUserData(uid: user.uid);
      log(userEntity.name);
      saveUserData(user: userEntity);
      log("data saved");
      return right(userEntity);
    } on FirebaseAuthException catch (e) {
      log("ana ${e.code}");
      return left(Failure(e.code));
    }
  }

  //save data locally
  @override
  Future<void> saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromUserEntity(user).toMap());
    await Prefs.setString(Constants.kUser, jsonData);
  }

  //save data in firestore
  @override
  Future<void> addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: Constants.kUser,
      data: UserModel.fromUserEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  //get data from firestore
  @override
  Future<UserEntity> getUserData({required String uid}) async {
    try {
      log("getUserData called");
      var user = await databaseService.getData(
        path: Constants.kUser,
        documentId: uid,
      );
      log("getUserData returned");
      log(user.toString());
      return UserModel.fromJson(user);
    } catch (e) {
      log("error at getUserData ${e.toString()}");
      return UserModel.empty();
    }
  }

  // @override
  // Future<UserCredential> signInWithGoogle() async {

  // }
}

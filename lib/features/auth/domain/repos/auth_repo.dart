import 'package:dartz/dartz.dart';
import 'package:shopify/core/errors/failure.dart';
import 'package:shopify/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String location,
  });

  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  });

  // Future<Either<Failure, UserEntity>> signinWithGoogle();

  Future addUserData({required UserEntity user});
  Future saveUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uid});
}

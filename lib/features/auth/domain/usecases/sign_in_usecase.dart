import 'package:dartz/dartz.dart';
import 'package:shopify/core/errors/failure.dart';
import 'package:shopify/features/auth/domain/entities/user_entity.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';

class SignInUseCase {
  final AuthRepo repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signinWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

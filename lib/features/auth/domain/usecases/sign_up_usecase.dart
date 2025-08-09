import 'package:dartz/dartz.dart';
import 'package:shopify/core/errors/failure.dart';
import 'package:shopify/features/auth/domain/entities/user_entity.dart';
import 'package:shopify/features/auth/domain/repos/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String name,
    required String location,
  }) {
    return repository.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      location: location,
    );
  }
}

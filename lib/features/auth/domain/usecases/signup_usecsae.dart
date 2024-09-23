import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/auth/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) {
    return repository.signup(email, password);
  }
}

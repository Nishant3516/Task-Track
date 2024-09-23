import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signup(String email, String password);
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Stream<Either<Failure, UserEntity?>> getUser();
}

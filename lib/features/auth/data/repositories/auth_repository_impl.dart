import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/auth/data/models/user_model.dart';
import 'package:taskmgmt/features/auth/domain/entities/user.dart';
import 'package:taskmgmt/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Stream<Either<Failure, UserEntity?>> getUser() {
    return firebaseAuth
        .authStateChanges()
        .map<Either<Failure, UserEntity?>>((firebaseUser) {
      if (firebaseUser != null) {
        return Right(UserModel.fromFirebaseUser(firebaseUser));
      } else {
        return const Right(null);
      }
    }).handleError((error) {
      return Left(AuthFailure(error.toString()));
    });
  }

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signup(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmgmt/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required String uid,
    required String email,
  }) : super(uid: uid, email: email);

  factory UserModel.fromFirebaseUser(User firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
    );
  }
}

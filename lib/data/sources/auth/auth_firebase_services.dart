import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq CreateUserReq);

  Future<Either> signin(SigninUserReq SigninUserReq);
}

class AuthFirebaseServicesImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq SigninUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: SigninUserReq.email,
        password: SigninUserReq.password,
      );

      return Right('Signin was Successful ');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = "Not user found for that email";
      } else if (e.code == 'invalid-credential') {
        message = 'wrong creditails provided.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq CreateUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: CreateUserReq.email,
        password: CreateUserReq.password,
      );

      return Right('Signup was Successful ');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = "The password provide is too weak";
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with the email.';
      }
      return Left(message);
    }
  }
}

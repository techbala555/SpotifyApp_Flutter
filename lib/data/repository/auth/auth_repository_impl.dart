import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/data/models/auth/signin_user_req.dart';
import 'package:spotify_app/data/sources/auth/auth_firebase_services.dart';
import 'package:spotify_app/domain/repositories/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(SigninUserReq SigninUserReq) async {
  return await sl <AuthFirebaseService> ().signin(SigninUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq CreateUserReq) async {
  return await sl <AuthFirebaseService> ().signup(CreateUserReq);
  }
}
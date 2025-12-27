import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/data/models/auth/signin_user_req.dart';

abstract class AuthRepository {

  Future <Either> signup(CreateUserReq CreateUserReq); 

  Future <Either> signin(SigninUserReq SigninUserReq);
}
import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/config/usecases/usecases.dart';
import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/data/models/auth/signin_user_req.dart';
import 'package:spotify_app/domain/repositories/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class SigninUseCase implements Usecases<Either, SigninUserReq> {
  @override
 Future<Either>call ({SigninUserReq ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
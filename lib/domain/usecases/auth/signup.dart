import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/config/usecases/usecases.dart';
import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/domain/repositories/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class SignupUseCase implements Usecases<Either, CreateUserReq> {
  @override
  Future<Either<dynamic, dynamic>> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
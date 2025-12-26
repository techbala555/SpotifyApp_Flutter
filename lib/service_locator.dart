import 'package:get_it/get_it.dart';
import 'package:spotify_app/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_app/data/sources/auth/auth_firebase_services.dart';
import 'package:spotify_app/domain/repositories/auth/auth.dart';
import 'package:spotify_app/domain/usecases/auth/signup.dart';

final sl = GetIt.instance;

Future <void> inintializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServicesImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );
}
import 'package:chess_app/src/core/injection_container.config.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => 'https://lichess.org/api/games/user/';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chess_app/src/core/injection_container.dart' as _i10;
import 'package:chess_app/src/features/auth_gate/presentation/cubit/auth_gate_cubit.dart'
    as _i5;
import 'package:chess_app/src/features/chess_game/presentation/cubit/chess_game_cubit.dart'
    as _i3;
import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart'
    as _i7;
import 'package:chess_app/src/features/home_page/domain/repositories/user_chess_games_repository.dart'
    as _i8;
import 'package:chess_app/src/features/home_page/presentation/cubit/home_page_cubit.dart'
    as _i9;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.ChessGameCubit>(() => _i3.ChessGameCubit());
    gh.lazySingleton<_i4.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<_i5.AuthGateCubit>(
        () => _i5.AuthGateCubit(firebaseAuth: gh<_i4.FirebaseAuth>()));
    gh.lazySingleton<_i6.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.factory<_i7.ChessGameRemoteRetrofitDataSource>(
        () => _i7.ChessGameRemoteRetrofitDataSource(gh<_i6.Dio>()));
    gh.factory<_i8.UserChessGamesRepository>(() => _i8.UserChessGamesRepository(
        chessGameDataSource: gh<_i7.ChessGameRemoteRetrofitDataSource>()));
    gh.factory<_i9.HomePageCubit>(() => _i9.HomePageCubit(
        userChessGamesRepository: gh<_i8.UserChessGamesRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chess_app/src/core/injection_container.dart' as _i9;
import 'package:chess_app/src/features/auth_gate/presentation/cubit/auth_gate_cubit.dart'
    as _i3;
import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart'
    as _i6;
import 'package:chess_app/src/features/home_page/domain/repositories/user_chess_games_repository.dart'
    as _i7;
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart'
    as _i4;
import 'package:chess_app/src/features/home_page/presentation/cubits/home_page_cubit/home_page_cubit.dart'
    as _i8;
import 'package:dio/dio.dart' as _i5;
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
    gh.factory<_i3.AuthGateCubit>(() => _i3.AuthGateCubit());
    gh.factory<_i4.ChessGameCubit>(() => _i4.ChessGameCubit());
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i5.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.factory<_i6.ChessGameRemoteRetrofitDataSource>(
        () => _i6.ChessGameRemoteRetrofitDataSource(gh<_i5.Dio>()));
    gh.factory<_i7.UserChessGamesRepository>(() => _i7.UserChessGamesRepository(
        chessGameDataSource: gh<_i6.ChessGameRemoteRetrofitDataSource>()));
    gh.factory<_i8.HomePageCubit>(() => _i8.HomePageCubit(
        userChessGamesRepository: gh<_i7.UserChessGamesRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i9.RegisterModule {}

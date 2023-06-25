// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chess_app/src/core/injection_container.dart' as _i12;
import 'package:chess_app/src/data/data_sources/chess_game_data_source.dart'
    as _i9;
import 'package:chess_app/src/domain/repositories/favourites_page_repository.dart'
    as _i4;
import 'package:chess_app/src/domain/repositories/user_chess_games_repository.dart'
    as _i10;
import 'package:chess_app/src/features/auth_gate/cubit/auth_gate_cubit.dart'
    as _i6;
import 'package:chess_app/src/features/chess_game/cubit/chess_game_cubit.dart'
    as _i3;
import 'package:chess_app/src/features/favourites/cubit/cubit/favourites_cubit.dart'
    as _i8;
import 'package:chess_app/src/features/home_page/cubit/home_page_cubit.dart'
    as _i11;
import 'package:dio/dio.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
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
    gh.factory<_i4.FavouritesPageRepository>(
        () => _i4.FavouritesPageRepository());
    gh.lazySingleton<_i5.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<_i6.AuthGateCubit>(
        () => _i6.AuthGateCubit(firebaseAuth: gh<_i5.FirebaseAuth>()));
    gh.lazySingleton<_i7.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.factory<_i8.FavouritesCubit>(() => _i8.FavouritesCubit(
        favouritesPageRepository: gh<_i4.FavouritesPageRepository>()));
    gh.factory<_i9.ChessGameRemoteRetrofitDataSource>(
        () => _i9.ChessGameRemoteRetrofitDataSource(gh<_i7.Dio>()));
    gh.factory<_i10.UserChessGamesRepository>(() =>
        _i10.UserChessGamesRepository(
            chessGameDataSource: gh<_i9.ChessGameRemoteRetrofitDataSource>()));
    gh.factory<_i11.HomePageCubit>(() => _i11.HomePageCubit(
        userChessGamesRepository: gh<_i10.UserChessGamesRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}

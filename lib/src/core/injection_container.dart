import 'package:chess_app/src/features/auth_gate/presentation/cubit/cubit/auth_gate_cubit.dart';
import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/data/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Bloc
  getIt.registerFactory(() => HomePageCubit(userChessGamesRepository: getIt()));
  getIt.registerFactory(() => ChessGameCubit());
  getIt.registerFactory(() => AuthGateCubit());

  // Repositories
  getIt.registerFactory(
      () => UserChessGamesRepository(chessGameDataSource: getIt()));

  // RemoteDataSource
  getIt.registerFactory(() => ChessGameRemoteRetrofitDataSource(Dio()));
}

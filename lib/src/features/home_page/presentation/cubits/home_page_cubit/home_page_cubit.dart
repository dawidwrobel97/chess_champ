import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/data/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._userChessGamesRepository) : super(const HomePageState());

  final UserChessGamesRepository _userChessGamesRepository;

  Future<void> getUserChessGamesFromId(String id) async {
    emit(const HomePageState(status: Status.loading));
    try {
      final chessGames =
          await _userChessGamesRepository.getUserChessGamesFromId(id);
      emit(
        HomePageState(
          listOfChessGamesModels: chessGames,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        HomePageState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}

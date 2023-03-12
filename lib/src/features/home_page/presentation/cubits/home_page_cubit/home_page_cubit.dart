import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/data/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.dart';
part 'home_page_cubit.freezed.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._userChessGamesRepository)
      : super(const HomePageState(status: Status.initial));

  final UserChessGamesRepository _userChessGamesRepository;

  Future<void> getUserChessGamesFromId(String id) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final chessGames =
          await _userChessGamesRepository.getUserChessGamesFromId(id);
      emit(
        state.copyWith(
          listOfChessGamesModels: chessGames,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          errorMessage: error.toString(),
          status: Status.error,
        ),
      );
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/features/home_page/data/repositories/chess_game_repository.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._chessGameRepository) : super(const HomePageState());

  final ChessGameRepository _chessGameRepository;

  Future<void> getUserChessGamesFromId(String id) async {
    final chessGames = await _chessGameRepository.getUserChessGamesFromId(id);
    emit(HomePageState(listOfChessGamesModels: chessGames));
  }
}

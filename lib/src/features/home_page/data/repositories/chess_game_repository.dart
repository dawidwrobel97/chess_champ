import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model/chess_game_model.dart';

class ChessGameRepository {
  ChessGameRepository(this._chessGameDataSource);

  final ChessGameDataSource _chessGameDataSource;

  Future<List<ChessGameModel>?> getUserChessGamesFromId(String id) async {
    final json = await _chessGameDataSource.getChessGames(id);

    if (json == null) {
      return null;
    }

    return json.map((e) => ChessGameModel.fromJson(e)).toList();
  }
}

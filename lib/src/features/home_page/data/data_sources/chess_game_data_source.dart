import 'package:dio/dio.dart';

class ChessGameDataSource {
  Future<List<Map<String, dynamic>>?> getChessGame() async {
    final response = await Dio()
        .get<List<dynamic>>('https://lichess.org/api/game/export/J9iArtcQwqN8');
    final listDynamic = response.data;
    if (listDynamic == null) {
      return null;
    }
    return listDynamic.map((e) => e as Map<String, dynamic>).toList();
  }
}

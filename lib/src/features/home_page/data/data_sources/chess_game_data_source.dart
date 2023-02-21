import 'package:dio/dio.dart';

class ChessGameDataSource {
  Future<List<Map<String, dynamic>>?> getChessGame(String id) async {
    try {
      final response = await Dio()
          .get<List<dynamic>>('https://lichess.org/api/game/export/$id');
      final listDynamic = response.data;
      if (listDynamic == null) {
        return null;
      }
      return listDynamic.map((e) => e as Map<String, dynamic>).toList();
    } on DioError catch (error) {
      throw Exception(error.response?.data ?? '');
    }
  }
}

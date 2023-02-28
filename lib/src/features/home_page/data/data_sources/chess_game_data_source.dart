import 'dart:convert';

import 'package:dio/dio.dart';

class ChessGameDataSource {
  Future<List<Map<String, dynamic>>?> getChessGames(String id) async {
    final dio = Dio();
    dio.options.headers = {"Accept": "application/x-ndjson"};

    try {
      final response = await dio.get(
          'https://lichess.org/api/games/user/$id?max=10&rated=true&analysed=true&evals=true');
      if (response.data == null) {
        return null;
      }
      List<dynamic> responseAsDynamicList =
          const LineSplitter().convert(response.data);
      final List<Map<String, dynamic>> responseAsMapList = [];
      for (final response in responseAsDynamicList) {
        responseAsMapList.add(jsonDecode(response));
      }
      return responseAsMapList;
    } on DioError catch (error) {
      throw Exception(error.response?.data ?? '');
    }
  }
}

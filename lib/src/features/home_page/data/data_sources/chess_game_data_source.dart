import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'chess_game_data_source.g.dart';

@RestApi(baseUrl: 'https://lichess.org/api/games/user/')
abstract class ChessGameRemoteRetrofitDataSource {
  factory ChessGameRemoteRetrofitDataSource(Dio dio, {String baseUrl}) =
      _ChessGameRemoteRetrofitDataSource;

  @GET("/{id}?max=10&lastFen=true&analysed=true&evals=true")
  @Headers(<String, dynamic>{"Accept": "application/x-ndjson"})
  Future<String> getUserChessGamesFromId(@Path("id") String id);
}













// Old code, keeping just in case
//
// class ChessGameRemoteRetrofitDataSource {
//   Future<List<Map<String, dynamic>>?> getUserChessGamesFromId(String id) async {
//     final dio = Dio();
//     dio.options.headers = {"Accept": "application/x-ndjson"};

//     try {
//       final response = await dio.get(
//           'https://lichess.org/api/games/user/$id?max=10&lastFen=true&analysed=true&evals=true');
//       if (response.data == null) {
//         return null;
//       }
//       // Lichess API sends it's response in a specific way where each line is it's own json string
//       // so we need to seperate them and put them in a List first
//       List<String> responseAsListOfStrings =
//           const LineSplitter().convert(response.data);
//       final List<Map<String, dynamic>> responseAsListMap = [];
//       for (var i = 0; i < responseAsListOfStrings.length; i++) {
//         responseAsListMap.add(jsonDecode(responseAsListOfStrings[i]));
//         responseAsListMap[i].addAll({'userId': id});
//         // Analysis doesn't have the starting position analysis in it so I have to add one myself
//         responseAsListMap[i]['analysis'].insert(0, {'eval': 26});
//         List<dynamic> movesAsList = responseAsListMap[i]['moves'].split(' ');
//         responseAsListMap[i].addAll({'movesAsList': movesAsList});
//       }
//       return responseAsListMap;
//     } on DioError catch (error) {
//       throw Exception(
//           error.response?.data['error']['message'] ?? 'Unknown error');
//     }
//   }
// }

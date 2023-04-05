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

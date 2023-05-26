import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'chess_game_data_source.g.dart';

@injectable
@RestApi()
abstract class ChessGameRemoteRetrofitDataSource {
  @factoryMethod
  factory ChessGameRemoteRetrofitDataSource(Dio dio) =
      _ChessGameRemoteRetrofitDataSource;

  @GET(
      "/{id}?max=10&lastFen=true&analysed=true&evals=true&perfType=ultraBullet,bullet,blitz,rapid,classical")
  @Headers(<String, dynamic>{"Accept": "application/x-ndjson"})
  Future<String> getUserChessGamesFromId(@Path("id") String id);
}

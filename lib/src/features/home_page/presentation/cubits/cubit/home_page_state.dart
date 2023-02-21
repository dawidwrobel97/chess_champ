part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  const HomePageState({
    this.chessModel = const [],
  });

  final List<ChessGameModel> chessModel;
}

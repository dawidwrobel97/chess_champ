import 'package:bloc_test/bloc_test.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ChessGameCubit sut;
  late ChessBoardController controller;

  setUp(
    () {
      controller = ChessBoardController();
      sut = ChessGameCubit();
    },
  );

  group('start', () {
    blocTest('description', build: ()=>sut,act: (cubit) => cubit.start(ChessGameModel(
                'GameId123',
                'TestUser',
                'Fen123',
                'players',
                ['move1', 'move2'],
                ['e4', 'e5'],
                12345,
                ['d4', 'd5'],
                100,
                10,
                'c5c6')), expect: () => ChessGameState(status: status, enabledMoves: enabledMoves, madeWrongMove: madeWrongMove, madeTheSameMistake: madeTheSameMistake, madeTheBestMove: madeTheBestMove, pressedButtonForSolution: pressedButtonForSolution));
   });
}

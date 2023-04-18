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

  group('makeTheBestMove', () {
    blocTest('description',
        build: () => sut,
        act: (cubit) => cubit.makeTheBestMove(ChessGameModel(
            'GameId123',
            'TestUser',
            'Fen123',
            'players',
            [
              'move1',
              'move2',
              'move3',
              'move4',
              'move5',
              'move6',
              'move7',
            ],
            ['e4', 'e5'],
            12345,
            ['d4', 'd5'],
            100,
            2,
            'c5c6')),
        expect: () => [
              const ChessGameState(
                  enabledMoves: false,
                  pressedButtonForSolution: true,
                  madeTheBestMove: false,
                  madeTheSameMistake: false,
                  madeWrongMove: false),
            ]);
  });
}

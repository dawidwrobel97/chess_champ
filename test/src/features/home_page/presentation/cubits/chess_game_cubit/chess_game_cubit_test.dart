import 'package:bloc_test/bloc_test.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ChessGameCubit sut;

  setUp(
    () {
      sut = ChessGameCubit();
    },
  );

  group('start', () {
    blocTest(
      'description',
      build: () => sut,
      act: (cubit) => cubit.start(
        ChessGameModel(
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
            ['e4', 'e5', 'e6', 'e7'],
            12345,
            ['d4', 'd5'],
            100,
            1,
            'c5c6'),
      ),
      expect: () => [
        const ChessGameState(status: Status.loading),
        ChessGameState(
          status: Status.success,
          chessGameModel: ChessGameModel(
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
              ['e4', 'e5', 'e6', 'e7'],
              12345,
              ['d4', 'd5'],
              100,
              1,
              'c5c6'),
        )
      ],
    );
  });

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

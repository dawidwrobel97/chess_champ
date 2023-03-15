import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/bottom_container/widgets/made_the_best_move_widget.dart';
import 'package:flutter/material.dart';

class MiddleText extends StatelessWidget {
  const MiddleText({
    super.key,
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state.madeTheSameMistake == true) {
          return const Text(
            'Oops! That\'s the mistake you did! Try again! :)',
            style: TextStyle(
              fontSize: 18,
            ),
          );
        } else if (state.madeWrongMove == true) {
          return const Text(
            'That\'s not it... Try again!',
            style: TextStyle(
              fontSize: 18,
            ),
          );
        } else if (state.pressedButtonForSolution == true) {
          return Text(
            'The best move was moving the piece\n from ${game.bestMove[0]} to ${game.bestMove[1]}. Try again with diffrent game!',
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          );
        } else if (state.madeTheBestMove == true) {
          return MadeTheBestMoveWidget(game: game);
        }
        return const Text(
          'Can you find the best move instead?',
          style: TextStyle(
            fontSize: 18,
          ),
        );
      },
    );
  }
}

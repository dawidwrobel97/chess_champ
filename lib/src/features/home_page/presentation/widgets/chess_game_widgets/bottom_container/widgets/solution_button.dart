import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolutionButton extends StatelessWidget {
  const SolutionButton({
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
        if (state.madeTheBestMove == false &&
            state.pressedButtonForSolution == false) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: ElevatedButton(
              onPressed: () {
                context.read<ChessGameCubit>().makeTheBestMove(game);
              },
              child: const Text(
                'I give up! Show me the best move!',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        } else if (state.pressedButtonForSolution == true) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Go back',
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

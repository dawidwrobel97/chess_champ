import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';

class UpperRow extends StatelessWidget {
  const UpperRow({
    super.key,
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (state.madeTheBestMove == false) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Text(
                'That move cost you ${game.biggestScoreDifference} points of material',
                textAlign: TextAlign.center,
              ),
            ),
            Builder(
              builder: (context) {
                if (game.biggestScoreDifference <= 2) {
                  return Flexible(
                    child: Row(
                      children: [
                        const Flexible(
                          child: Text(
                              'For comparison, 1 point of material equals a pawn!'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                          child: WhitePawn(
                            size: 60,
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (game.biggestScoreDifference > 2 &&
                    game.biggestScoreDifference <= 4) {
                  return Flexible(
                    child: Row(
                      children: [
                        const Flexible(
                          child: Text(
                              'For comparison, 3 points of material equals a knight!'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                          child: WhiteKnight(
                            size: 60,
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (game.biggestScoreDifference > 4 &&
                    game.biggestScoreDifference <= 6) {
                  return Flexible(
                    child: Row(
                      children: [
                        const Flexible(
                          child: Text(
                              'For comparison, 5 points of material equals a rook!'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                          child: WhiteRook(
                            size: 60,
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Flexible(
                  child: Row(
                    children: [
                      const Flexible(
                        child: Text(
                            'For comparison, 8 points of material equals a queen!'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: WhiteQueen(
                          size: 60,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}

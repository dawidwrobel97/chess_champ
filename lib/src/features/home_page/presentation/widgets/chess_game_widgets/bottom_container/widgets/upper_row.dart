import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';

class UpperRow extends StatelessWidget {
  const UpperRow({
    super.key,
    required this.state,
  });

  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (state.madeTheBestMove == false) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Text(
                'That move cost you ${state.chessGameModel!.biggestScoreDifference} points of material',
                textAlign: TextAlign.center,
              ),
            ),
            Builder(
              builder: (context) {
                if (state.chessGameModel!.biggestScoreDifference <= 2) {
                  return _TextWithIcon(
                    text: 'For comparison, 1 point of material equals a pawn!',
                    icon: WhitePawn(
                      size: 60,
                    ),
                  );
                }
                if (state.chessGameModel!.biggestScoreDifference > 2 &&
                    state.chessGameModel!.biggestScoreDifference <= 4) {
                  return _TextWithIcon(
                      text:
                          'For comparison, 3 points of material equals a knight!',
                      icon: WhiteKnight(
                        size: 60,
                      ));
                }
                if (state.chessGameModel!.biggestScoreDifference > 4 &&
                    state.chessGameModel!.biggestScoreDifference <= 6) {
                  return _TextWithIcon(
                      text:
                          'For comparison, 5 points of material equals a rook!',
                      icon: WhiteRook(
                        size: 60,
                      ));
                }
                return _TextWithIcon(
                    text:
                        'For comparison, 8 points of material equals a queen!',
                    icon: WhiteQueen(
                      size: 60,
                    ));
              },
            )
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class _TextWithIcon extends StatelessWidget {
  const _TextWithIcon({
    required this.text,
    required this.icon,
  });

  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: icon,
          )
        ],
      ),
    );
  }
}

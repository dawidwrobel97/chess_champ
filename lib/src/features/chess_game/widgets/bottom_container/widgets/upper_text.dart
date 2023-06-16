import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/features/chess_game/cubit/chess_game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpperText extends StatelessWidget {
  const UpperText({
    super.key,
    required this.state,
  });

  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state.madeTheBestMove == false) {
          return Column(
            children: [
              Text(
                'Your biggest mistake in game was on move ${(state.chessGameModel!.moveOnWhichMistakeHappened / 2).round()}\n when you played ${state.chessGameModel!.worstMove}',
                style: GoogleFonts.oswald(
                    textStyle: const TextStyle(fontSize: 20)),
                textAlign: TextAlign.center,
              ),
              Divider(
                thickness: 1.5,
                color: AppTheme.borderColor,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpperText extends StatelessWidget {
  const UpperText({
    super.key,
    required this.game,
    required this.state,
  });

  final ChessGameModel game;
  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state.madeTheBestMove == false) {
          return Column(
            children: [
              Text(
                'Your biggest mistake in game was on move ${(game.moveOnWhichMistakeHappened / 2).round()}\n when you played ${game.worstMove}',
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

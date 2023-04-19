import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpperBox extends StatelessWidget {
  const UpperBox({
    super.key,
    required this.state,
  });
  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: Column(
        children: [
          Text(
            'Game between',
            style: GoogleFonts.oswald(
              textStyle: TextStyle(
                fontSize: 17,
                color: AppTheme.fontColor,
              ),
            ),
          ),
          Text(
            '${state.chessGameModel!.whitePlayer()} and ${state.chessGameModel!.blackPlayer()}',
            style: GoogleFonts.oswald(
              textStyle: TextStyle(
                color: AppTheme.fontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

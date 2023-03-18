import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/pages/chess_game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameDescription extends StatelessWidget {
  const GameDescription({
    super.key,
    required this.chessGamesModel,
  });

  final ChessGameModel chessGamesModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppTheme.lighterContainerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Played on ${chessGamesModel.playedGameAt()}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                        textStyle: const TextStyle(fontSize: 17)),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          'Biggest mistake: \n${chessGamesModel.biggestScoreDifference}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        'Biggest mistake was made on move ${(chessGamesModel.moveOnWhichMistakeHappened / 2).round()}',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PopupMenuButton<MenuItem>(
              onSelected: (value) async {
                if (MenuItem.select == value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChessGame(
                        chessGameModel: chessGamesModel,
                      ),
                    ),
                  );
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: MenuItem.select,
                  child: Text('Wybierz'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

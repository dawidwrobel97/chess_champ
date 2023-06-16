import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/chess_game/presentation/chess_game.dart';
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
        child: Builder(builder: (context) {
          if (chessGamesModel.isPerfectGame == false) {
            return _GameDescription(chessGamesModel: chessGamesModel);
          }
          return const _PerfectGameDescription();
        }),
      ),
    );
  }
}

class _PerfectGameDescription extends StatelessWidget {
  const _PerfectGameDescription();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Center(
          child: Text(
            'This is a perfect game\n Congratulations!',
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 17)),
          ),
        ),
      ),
    );
  }
}

class _GameDescription extends StatelessWidget {
  const _GameDescription({
    required this.chessGamesModel,
  });

  final ChessGameModel chessGamesModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
              child: Text('Select'),
            ),
          ],
        ),
      ],
    );
  }
}

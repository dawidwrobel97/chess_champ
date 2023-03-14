import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    super.key,
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 7, 10, 12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowColor,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(3, 5),
            ),
            BoxShadow(
              color: AppTheme.shadowColor,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(-3, 5),
            ),
          ],
          border: Border.all(width: 2, color: AppTheme.borderColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: AppTheme.contanierColor,
        ),
        child: _EntireContainer(game: game),
      ),
    );
  }
}

class _EntireContainer extends StatelessWidget {
  const _EntireContainer({
    required this.game,
  });

  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TO DO: The mistake lost you NUMBER, and was consider a (mistake blunder or inaccuaryc, the color changes basend on what).
            // Add at end... Not that bad! or whoops! that's quite the mistake. Maybe even show the equvialent in chess piecies.
            // And the rest of logic ofc, make button actually show the best move and change enitre text based on wheter you found it youyself
            UpperText(game: game),
            Divider(
              thickness: 1.5,
              color: AppTheme.borderColor,
            ),
            Column(
              children: [
                _MainColumn(game: game),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UpperText extends StatelessWidget {
  const UpperText({
    super.key,
    required this.game,
  });

  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your biggest mistake in game was on move ${(game.moveOnWhichMistakeHappened / 2).round()}\n when you played ${game.worstMove}',
      style: GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 20)),
      textAlign: TextAlign.center,
    );
  }
}

class _MainColumn extends StatelessWidget {
  const _MainColumn({
    required this.game,
  });

  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'That move cost you ${game.biggestScoreDifference} points of material!',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: const [
                    Flexible(
                      child: Text(
                          'For comparison, 3 points of material equals a knight!'),
                    ),
                    Placeholder(
                      fallbackHeight: 50,
                      fallbackWidth: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
          child: Text(
            'Can you find the best move instead?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              'I give up! Show me the best move!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

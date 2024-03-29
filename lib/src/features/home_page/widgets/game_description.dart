import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/chess_game/pages/chess_game.dart';
import 'package:chess_app/src/features/home_page/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        _GameDescriptionText(chessGamesModel: chessGamesModel),
        _GameDescriptionPopupMenuButton(chessGamesModel: chessGamesModel),
      ],
    );
  }
}

class _GameDescriptionText extends StatelessWidget {
  const _GameDescriptionText({
    required this.chessGamesModel,
  });

  final ChessGameModel chessGamesModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Played on ${chessGamesModel.playedGameAt()}',
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 17)),
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
    );
  }
}

class _GameDescriptionPopupMenuButton extends StatelessWidget {
  const _GameDescriptionPopupMenuButton({
    required this.chessGamesModel,
  });

  final ChessGameModel chessGamesModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
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
        if (MenuItem.favourite == value) {
          context.read<HomePageCubit>().saveToFavourites(chessGamesModel);
        }
        if (MenuItem.delete == value) {
          context.read<HomePageCubit>().deleteGame(chessGamesModel.gameId);
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: MenuItem.select,
          child: Text('Select'),
        ),
        PopupMenuItem(
          value: MenuItem.favourite,
          child: Text('Favourite'),
        ),
        PopupMenuItem(
          value: MenuItem.delete,
          child: Text('Delete'),
        ),
      ],
    );
  }
}

import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/chess_game/pages/chess_game.dart';
import 'package:chess_app/src/features/favourites/cubit/favourites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesGameDescription extends StatelessWidget {
  const FavouritesGameDescription({
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
            return _FavouritesGameDescription(chessGamesModel: chessGamesModel);
          }
          return const _PerfectFavouritesGameDescription();
        }),
      ),
    );
  }
}

class _PerfectFavouritesGameDescription extends StatelessWidget {
  const _PerfectFavouritesGameDescription();

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

class _FavouritesGameDescription extends StatelessWidget {
  const _FavouritesGameDescription({
    required this.chessGamesModel,
  });

  final ChessGameModel chessGamesModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _FavouritesGameDescriptionText(chessGamesModel: chessGamesModel),
        _FavouritesGameDescriptionPopupMenuButton(
            chessGamesModel: chessGamesModel),
      ],
    );
  }
}

class _FavouritesGameDescriptionText extends StatelessWidget {
  const _FavouritesGameDescriptionText({
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

class _FavouritesGameDescriptionPopupMenuButton extends StatelessWidget {
  const _FavouritesGameDescriptionPopupMenuButton({
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
        if (MenuItem.delete == value) {
          context.read<FavouritesCubit>().deleteGame(chessGamesModel.gameId);
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: MenuItem.select,
          child: Text('Select'),
        ),
        PopupMenuItem(
          value: MenuItem.delete,
          child: Text('Delete'),
        ),
      ],
    );
  }
}

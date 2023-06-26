import 'package:chess_app/src/common_widgets/my_container.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/favourites/widgets/favourites__game_thumbnail.dart';
import 'package:chess_app/src/features/favourites/widgets/favourites_game_description.dart';
import 'package:flutter/material.dart';

class FavouritesChessGamesList extends StatelessWidget {
  const FavouritesChessGamesList({
    super.key,
    required this.chessGamesModels,
  });

  final List<ChessGameModel>? chessGamesModels;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: chessGamesModels?.length ?? 0,
        itemBuilder: (context, index) {
          return MyContainer(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Row(
                children: [
                  FavouritesChessGameThumbnail(
                    chessGameModel: chessGamesModels![index],
                  ),
                  FavouritesGameDescription(
                      chessGamesModel: chessGamesModels![index])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

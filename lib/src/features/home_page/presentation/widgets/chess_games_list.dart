import 'package:chess_app/src/common_widgets/my_container.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_thumbnail.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/game_description.dart';
import 'package:flutter/material.dart';

class ChessGamesList extends StatelessWidget {
  const ChessGamesList({
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
                  ChessGameThumbnail(
                    chessGameModel: chessGamesModels![index],
                  ),
                  GameDescription(chessGamesModel: chessGamesModels![index])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

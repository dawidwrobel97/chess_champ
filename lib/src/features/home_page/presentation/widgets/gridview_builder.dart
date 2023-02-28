import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';

class GridviewBuilder extends StatelessWidget {
  const GridviewBuilder({
    super.key,
    required this.chessGamesModels,
  });

  final List<ChessGameModel>? chessGamesModels;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: chessGamesModels?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Column(
                children: [
                  Text(chessGamesModels![index].id),
                  Text(chessGamesModels![index].rated.toString()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

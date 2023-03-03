import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/chess_game/presentation/chess_game.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_thumbnail.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: chessGamesModels?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  ChessGameThumbnail(
                    chessGameModel: chessGamesModels![index],
                  ),
                  _GameDescription(chessGamesModel: chessGamesModels![index])
                ],
              ),
            );
          },
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
    return Expanded(
      child: Container(
        height: 150,
        color: Colors.white,
        child: Center(
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gra ${chessGamesModel.id} \nNajwiększa róznica: ${chessGamesModel.largestNumberDifference}',
                    ),
                  ),
                ],
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
      ),
    );
  }
}

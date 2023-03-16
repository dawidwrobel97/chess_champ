import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/pages/chess_game.dart';
import 'package:flutter/material.dart';

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
        color: Colors.white,
        child: Center(
          child: Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Game ${chessGamesModel.gameId}'),
                          Text(
                              'Biggest mistake: ${chessGamesModel.biggestScoreDifference}'),
                          Text(
                              'Biggest mistake was made on move ${(chessGamesModel.moveOnWhichMistakeHappened / 2).round()}')
                        ],
                      ),
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
      ),
    );
  }
}

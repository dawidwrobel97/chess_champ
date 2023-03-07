import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/chess_game/presentation/chess_game.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
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
                  const Divider(),
                  _ChessGameThumbnail(
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
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Game ${chessGamesModel.gameId}'),
                          Text(
                              'Biggest mistake: ${chessGamesModel.biggestMistakeInGame['biggestDifference']}'),
                          Text(
                              'Biggest mistake was made on move ${chessGamesModel.biggestMistakeInGame['moveOnWhichMistakeHappened']}')
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

class _ChessGameThumbnail extends StatefulWidget {
  const _ChessGameThumbnail({
    required this.chessGameModel,
  });

  final ChessGameModel chessGameModel;
  @override
  State<_ChessGameThumbnail> createState() => _ChessGameThumbnailState();
}

class _ChessGameThumbnailState extends State<_ChessGameThumbnail> {
  ChessBoardController controller = ChessBoardController();

  @override
  void initState() {
    super.initState();
    controller.loadFen(widget.chessGameModel.lastFen);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.chessGameModel.gameId,
      child: SizedBox(
        height: 150,
        child: IgnorePointer(
          child: ChessBoard(
            controller: controller,
            boardOrientation: widget.chessGameModel.userId ==
                    widget.chessGameModel.whitePlayer
                ? PlayerColor.white
                : PlayerColor.black,
          ),
        ),
      ),
    );
  }
}

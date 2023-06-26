import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class FavouritesChessGameThumbnail extends StatefulWidget {
  const FavouritesChessGameThumbnail({
    super.key,
    required this.chessGameModel,
  });

  final ChessGameModel chessGameModel;
  @override
  State<FavouritesChessGameThumbnail> createState() => FavouritesChessGameThumbnailState();
}

class FavouritesChessGameThumbnailState extends State<FavouritesChessGameThumbnail> {
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
        child: IgnorePointer(
          child: ChessBoard(
            controller: controller,
            boardOrientation: widget.chessGameModel.userId.toLowerCase() ==
                    widget.chessGameModel.whitePlayer().toLowerCase()
                ? PlayerColor.white
                : PlayerColor.black,
          ),
        ),
      ),
    );
  }
}

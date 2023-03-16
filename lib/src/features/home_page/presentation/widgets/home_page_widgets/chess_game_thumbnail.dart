import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class ChessGameThumbnail extends StatefulWidget {
  const ChessGameThumbnail({
    super.key,
    required this.chessGameModel,
  });

  final ChessGameModel chessGameModel;
  @override
  State<ChessGameThumbnail> createState() => ChessGameThumbnailState();
}

class ChessGameThumbnailState extends State<ChessGameThumbnail> {
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

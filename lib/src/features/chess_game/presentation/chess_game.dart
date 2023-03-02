import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({
    super.key,
    required this.chessGameModel,
  });

  final ChessGameModel chessGameModel;

  @override
  State<ChessGame> createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  ChessBoardController controller = ChessBoardController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
    controller.loadFen(widget.chessGameModel.lastFen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Hero(
          tag: widget.chessGameModel.id,
          child: ChessBoard(
            controller: controller,
            boardOrientation: widget.chessGameModel.userID ==
                    widget.chessGameModel.whitePlayer
                ? PlayerColor.white
                : PlayerColor.black,
          ),
        ),
      ),
    );
  }
}

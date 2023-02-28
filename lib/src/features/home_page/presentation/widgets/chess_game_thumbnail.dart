import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class ChessGameThumbnail extends StatefulWidget {
  const ChessGameThumbnail({
    super.key,
    required this.chessGameModel,
  });

  final ChessGameModel chessGameModel;
  @override
  State<ChessGameThumbnail> createState() => _ChessGameThumbnailState();
}

class _ChessGameThumbnailState extends State<ChessGameThumbnail> {
  ChessBoardController controller = ChessBoardController();

  @override
  void initState() {
    super.initState();
    controller.loadFen(widget.chessGameModel.lastFen);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      child: ChessBoard(
        controller: controller,
        enableUserMoves: false,
      ),
    );
  }
}

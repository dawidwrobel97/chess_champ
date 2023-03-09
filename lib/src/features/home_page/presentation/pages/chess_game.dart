import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart' as chess;

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
  List<String> squareNames = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChessGameCubit()..start(widget.chessGameModel),
      child: BlocBuilder<ChessGameCubit, ChessGameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const MyAppBar(),
            body: Container(
              color: AppTheme.backgroundColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Stack(
                    children: [
                      Hero(
                        tag: widget.chessGameModel.gameId,
                        child: chess.ChessBoard(
                          controller: state.chessBoardController!,
                          boardOrientation: widget.chessGameModel.userId ==
                                  widget.chessGameModel.whitePlayer
                              ? chess.PlayerColor.white
                              : chess.PlayerColor.black,
                        ),
                      ),
                      for (var i = 0; i < 8; i++)
                        BottomSquareAnnotation(
                          squareName: squareNames[i],
                          squareNumber: i,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BottomSquareAnnotation extends StatelessWidget {
  const BottomSquareAnnotation({
    super.key,
    required this.squareName,
    required this.squareNumber,
  });

  final String squareName;
  final int squareNumber;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 2,
      left: (MediaQuery.of(context).size.width - 2) / 8 -
          ((MediaQuery.of(context).size.width - 2) / 8 / 6) +
          squareNumber * ((MediaQuery.of(context).size.width - 2) / 8),
      child: Text(
        squareName,
        style: TextStyle(
            color: squareNumber % 2 == 0
                ? const Color(0xFFf0d9b5)
                : const Color(0xFFb58863)),
      ),
    );
  }
}

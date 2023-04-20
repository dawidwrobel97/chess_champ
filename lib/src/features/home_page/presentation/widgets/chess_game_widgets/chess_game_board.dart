import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/chess_game_annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart' as ch;
import 'package:flutter/material.dart';

class ChessGameBoard extends StatelessWidget {
  ChessGameBoard({
    super.key,
    required this.state,
  });

  final ChessGameState state;
  final List<String> squareNames = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: state.chessGameModel!.gameId,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: AppTheme.containerShadows,
            ),
            child: ch.ChessBoard(
              size: MediaQuery.of(context).size.height * 0.45,
              enableUserMoves: state.enabledMoves,
              onMove: () {
                context
                    .read<ChessGameCubit>()
                    .madeMove(state.chessGameModel!.moveOnWhichMistakeHappened);
              },
              controller: state.chessBoardController!,
              boardOrientation: state.chessGameModel!.userId.toLowerCase() ==
                      state.chessGameModel!.whitePlayer().toLowerCase()
                  ? ch.PlayerColor.white
                  : ch.PlayerColor.black,
              arrows: state.enabledMoves == true
                  ? [
                      ch.BoardArrow(
                        from: state.wrongMove!.move.fromAlgebraic.toString(),
                        to: state.wrongMove!.move.toAlgebraic.toString(),
                        color: Colors.red.withOpacity(0.8),
                      ),
                    ]
                  : [
                      ch.BoardArrow(
                        from: state.chessGameModel!.bestMove[0],
                        to: state.chessGameModel!.bestMove[1],
                        color: Colors.green.withOpacity(0.8),
                      ),
                    ],
            ),
          ),
        ),
        if (state.chessGameModel!.userId.toLowerCase() ==
            state.chessGameModel!.whitePlayer().toLowerCase())
          ..._buildWhiteAnnotations(squareNames),
        if (state.chessGameModel!.userId.toLowerCase() ==
            state.chessGameModel!.blackPlayer().toLowerCase())
          ..._buildBlackAnnotations(squareNames),
      ],
    );
  }
}

// The chess board widget doesn't have annotations (the numbers and letters on the edges of the board)
// so I made them myslef
List<Widget> _buildWhiteAnnotations(List<String> squareNames) {
  return [
    for (var i = 0; i < 8; i++)
      WhiteBottomSquareAnnotation(
        squareName: squareNames[i],
        squareNumber: i,
      ),
    for (var i = 0; i < 8; i++) WhiteSideSquareAnnotation(squareNumber: i),
  ];
}

List<Widget> _buildBlackAnnotations(List<String> squareNames) {
  return [
    for (var i = 0; i < 8; i++)
      BlackBottomSquareAnnotation(
        squareName: squareNames.reversed.toList()[i],
        squareNumber: i,
      ),
    for (var i = 0; i < 8; i++) BlackSideSquareAnnotation(squareNumber: i),
  ];
}

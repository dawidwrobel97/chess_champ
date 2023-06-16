import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/core/injection_container.dart';
import 'package:chess_app/src/features/chess_game/presentation/cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/chess_game/presentation/widgets/chess_game_widgets/bottom_container/bottom_container.dart';
import 'package:chess_app/src/features/chess_game/presentation/widgets/chess_game_widgets/chess_game_board.dart';
import 'package:chess_app/src/features/chess_game/presentation/widgets/upper_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    final game = widget.chessGameModel;

    return BlocProvider(
      create: (context) => getIt<ChessGameCubit>()..start(game),
      child: BlocBuilder<ChessGameCubit, ChessGameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const MyAppBar(),
            backgroundColor: AppTheme.backgroundColor,
            body: Builder(builder: (context) {
              switch (state.status) {
                case (Status.initial):
                  return const SizedBox.shrink();
                case (Status.loading):
                  return const CircularProgressIndicator();
                case (Status.error):
                  return Center(
                    child: SizedBox(
                      child: Text(
                        "An error has occured: ${state.errorMessage}",
                      ),
                    ),
                  );
                case (Status.success):
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UpperBox(state: state),
                      ChessGameBoard(state: state),
                      BottomContainer(state: state),
                    ],
                  );
              }
            }),
          );
        },
      ),
    );
  }
}

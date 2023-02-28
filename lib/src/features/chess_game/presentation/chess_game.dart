import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ChessGame extends StatelessWidget {
  const ChessGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
    );
  }
}

import 'package:chess_app/src/features/home_page/presentation/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: const Color(0xFFDDDBDB),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              submit(context);
            },
            child: const Text(
              'Search',
            ),
          ),
        ],
      ),
    );
  }

  void submit(BuildContext context) {
    context
        .read<HomePageCubit>()
        .getUserChessGamesFromId(textEditingController.text.trim());
    FocusScope.of(context).unfocus();
    textEditingController.clear();
  }
}

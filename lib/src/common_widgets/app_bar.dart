import 'package:chess_app/src/features/home_page/presentation/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomePageAppbar extends StatelessWidget with PreferredSizeWidget {
  const HomePageAppbar({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name ?? ''),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              context.read<HomePageCubit>().deleteAllCurrentGames();
            },
            child: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

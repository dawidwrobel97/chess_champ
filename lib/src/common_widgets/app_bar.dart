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

class HomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomePageAppBar({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return AppBar(
          title: Center(
            child: InkWell(
              onTap: () {
                context.read<HomePageCubit>().dropDownMenu();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name != null ? name! : 'Input a user'),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    state.dropDownMenuIsActive == false
                        ? Icons.arrow_drop_down_sharp
                        : Icons.arrow_drop_up_sharp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

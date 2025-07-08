import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/theme/theme_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/widgets/custom_hover_icon_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onxy IX POS'),
        actions: [
          CustomHoverIconContainer(icon: Icons.language, onTap: () {}),
          CustomHoverIconContainer(
            icon: isDarkMode ? Icons.light_mode_outlined:Icons.dark_mode_outlined ,
            onTap: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
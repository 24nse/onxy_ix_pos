import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_theme.dart';
import 'package:onyx_ix_pos/core/utils/theme/theme_cubit.dart';
import 'package:onyx_ix_pos/presentation/modules/home/view/home_screen.dart';

void main() {
  runApp(const OnyxIxPosApp());
}

class OnyxIxPosApp extends StatelessWidget {
  const OnyxIxPosApp({super.key});

  @override
  Widget build(BuildContext context) {
   return  BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
    return 
     MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(),
    );
      
        }));
  }
}
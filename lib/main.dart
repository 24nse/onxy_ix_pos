import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_theme.dart';
import 'package:onyx_ix_pos/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:onyx_ix_pos/features/settings/presentation/cubits/locale_cubit.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/home_screen.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/payment_cubit.dart';

void main() {
  runApp(const OnyxIxPosApp());
}

class OnyxIxPosApp extends StatelessWidget {
  const OnyxIxPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(
          create: (_) => FullScreenCubit(),
        ),
           BlocProvider(
          create: (_) => CartCubit(),
        ),
             BlocProvider(
          create: (_) => PaymentCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return Builder(
                builder: (context) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightTheme(context),
                    darkTheme: AppTheme.darkTheme(context),
                    themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    locale: locale,
                    supportedLocales: const [Locale('en', ''), Locale('ar', '')],
                    home: HomeScreen(),
                  );
                }
              );
            },
          );
        },
      ),
    );
  }
}

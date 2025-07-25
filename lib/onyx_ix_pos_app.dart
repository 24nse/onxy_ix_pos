

import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_theme.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/full_screen_cubit.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/home_screen.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/payment_cubit.dart';
import 'package:onyx_ix_pos/features/settings/presentation/cubits/locale_cubit.dart';
import 'package:onyx_ix_pos/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/invoice_screen.dart';

class OnyxIxPosApp extends StatelessWidget {
  const OnyxIxPosApp({super.key});

  @override
  Widget build(BuildContext context) {

    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/invoice',
          builder: (context, state) => const InvoiceScreen(),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
        BlocProvider(create: (_) => sl<FullScreenCubit>()),
        BlocProvider(create: (_) => sl<CartCubit>()),
        BlocProvider(create: (_) => sl<PaymentCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return Builder(
                builder: (context) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightTheme(context, locale),
                    darkTheme: AppTheme.darkTheme(context, locale),
                    themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    locale: locale,
                    supportedLocales: const [
                      Locale('en', ''),
                      Locale('ar', ''),
                    ],
                    routerConfig: router,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

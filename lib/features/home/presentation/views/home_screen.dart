import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:onyx_ix_pos/core/widgets/custom_hover_icon_container.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/adaptive_layout.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/desktop_layout.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/mobile_layout.dart';
import 'package:onyx_ix_pos/core/widgets/language_menu_button.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/widgets/screen_tabs.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/tablet_layout.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});
  


  @override
  Widget build(BuildContext context) {

    final themeCubit = useMemoized(() => context.read<ThemeCubit>(), []);
    final isDarkMode =
        useStream<bool>(
          themeCubit.stream,
          initialData: themeCubit.state,
        ).data ??
        false;

    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.translate('app_title') ?? 'Onyx IX POS',
          ),
          actions: [
            LanguageMenuButton(),
            CustomHoverIconContainer(
              icon: isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
                            onTap: () {
                themeCubit.toggleTheme();
                showCustomToast(
                  context,
                  title: AppLocalizations.of(context)?.translate('theme_changed') ?? 'Theme Changed',
                  message: AppLocalizations.of(context)?.translate('theme_updated_successfully') ?? 'Theme updated successfully.',
                );
              },
            ),
          ],
                         bottom: screenWidth < SizeConfig.desktop ? const MainScreenTabs() : null,
        ),
        body: AdaptiveLayout(
           mobileLayout: (context) =>const MobileLayout(),
        tabletLayout: (context) =>TabletLayout(),
        desktopLayout: (context) => DesktopLayout(),
        ),
      ),
    );
  }
}

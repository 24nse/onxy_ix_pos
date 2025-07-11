import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/core/utils/theme/theme_cubit.dart';
import 'package:onyx_ix_pos/core/widgets/custom_hover_icon_container.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/features/home/data/local/mock_products.dart';
import 'package:onyx_ix_pos/core/utils/adaptive_layout.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/category_tabs.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/desktop_layout.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/mobile_layout.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/language_menu_button.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/screen_tabs.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/tablet_layout.dart';
import 'package:onyx_ix_pos/features/order/presentation/views/order_summary_section.dart';
import 'package:onyx_ix_pos/features/home/presentation/view/widgets/product_catalog_section.dart';
import 'package:overlay_support/overlay_support.dart';

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
              onTap: () => themeCubit.toggleTheme(),
            ),
          ],
          bottom: AdaptiveLayout.isMobile(context)||AdaptiveLayout.isTablet(context)
              ? const MainScreenTabs()
              : null,
        ),
        body: const AdaptiveLayout(
          tablet: TabletLayout(),
          mobile: MobileLayout(),
          desktop: DesktopLayout()
        ),
      ),
    );
  }
}

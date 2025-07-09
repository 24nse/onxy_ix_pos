import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/core/utils/theme/theme_cubit.dart';
import 'package:onyx_ix_pos/core/widgets/custom_hover_icon_container.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/home/data/local/mock_products.dart';
import 'package:onyx_ix_pos/home/presentation/view/widgets/category_tabs.dart';
import 'package:onyx_ix_pos/home/presentation/view/widgets/language_menu_button.dart';
import 'package:onyx_ix_pos/home/presentation/view/widgets/order_summary_section.dart';
import 'package:onyx_ix_pos/home/presentation/view/widgets/product_catalog_section.dart';
import 'package:onyx_ix_pos/home/presentation/view_models/full_screen_cubit.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isFullScreen = useState(false);

    final themeCubit = useMemoized(() => context.read<ThemeCubit>(), []);
    final isDarkMode =
        useStream<bool>(
          themeCubit.stream,
          initialData: themeCubit.state,
        ).data ??
        false;

    return Scaffold(
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
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return BlocBuilder<FullScreenCubit,bool>(builder: (context, state) {
      
        return state?    OrderSummarySection()
              : Row(
                  children: [
                    Expanded(flex: 2, child: ProductCatalogSection()),
                    Expanded(flex: 1, child: OrderSummarySection()),
                  ],
                );
          
          });
            
        },
      ),
    );
  }
}

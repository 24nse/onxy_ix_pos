import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';

class MainScreenTabs extends HookWidget implements PreferredSizeWidget {
  const MainScreenTabs({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);
    useListenable(tabController); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.searchAndTabBarDark
              : const Color(0xFFd1d6e1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            _buildTab(
              context,
              tabController,
              0,
              AppLocalizations.of(context)?.translate('products') ?? 'Products',
              Icons.grid_view,
            ),
            _buildTab(
              context,
              tabController,
              1,
              AppLocalizations.of(context)?.translate('cart') ?? 'Cart',
              Icons.shopping_cart,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    TabController tabController,
    int index,
    String text,
    IconData icon,
  ) {
    final isSelected = tabController.index == index;

    final theme = Theme.of(context);
    final tabColor = isSelected
        ? (theme.brightness == Brightness.dark
            ? AppColors.selectedTabDark
            : const Color(0xFFe5e9ec))
        : Colors.transparent;

    final onTabColor = isSelected
        ? (theme.brightness == Brightness.dark
            ? Colors.white
            : const Color(0xFF676f7a))
        : const Color(0xFFa3a4b6);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: GestureDetector(
          onTap: () => tabController.animateTo(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: tabColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: onTabColor, size: 14),
                const SizedBox(width: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: getResponsiveFontSize(context, fontSize: 14),
                          color: onTabColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

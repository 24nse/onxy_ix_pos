import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/core/widgets/adaptive_layout.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

class CategoryTabs extends HookWidget {
  final List<Map<String, dynamic>> categories;
  final Function(String) onCategorySelected;
  final String selectedCategory;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        alignment: Alignment.center,
        
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.searchAndTabBarDark
              : AppColors.tabBarLight,
          borderRadius: BorderRadius.circular(4),
        ),
        child: AdaptiveLayout(
          mobileLayout: (context) => _buildScrollableLayout(context),
          desktopLayout: (context) => _buildExpandedLayout(context),
          tabletLayout: (context) => _buildExpandedLayout(context),
        ),
      ),
    );
  }

  Widget _buildScrollableLayout(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return _buildTab(context, category, isExpanded: false);
        }).toList(),
      ),
    );
  }

  Widget _buildExpandedLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((category) {
        return Expanded(child: _buildTab(context, category, isExpanded: true));
      }).toList(),
    );
  }

  Widget _buildTab(BuildContext context, Map<String, dynamic> category,
      {required bool isExpanded}) {
    final theme = Theme.of(context);
    final label = category['label'] as String;
    final icon = category['icon'] as IconData;
    final isSelected = selectedCategory == label;

    final textTheme = theme.textTheme;

    final tabColor = isSelected
        ? (theme.brightness == Brightness.dark
            ? AppColors.selectedTabDark
            : AppColors.searchBarLight)
        : Colors.transparent;

    final onTabColor = isSelected
        ? (theme.brightness == Brightness.dark
            ? Colors.white
            : const Color(0xFF676f7a))
        : const Color(0xFFa3a4b6);

    final translatedLabel =
        AppLocalizations.of(context)?.translate(label.toLowerCase()) ?? label;

    Widget tabContent = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: tabColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: onTabColor.withAlpha(200), size: 14),
          const SizedBox(width: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              translatedLabel,
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: onTabColor,
                fontSize: getResponsiveFontSize(context, fontSize: 100),
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => onCategorySelected(label),
      child: isExpanded
          ? tabContent
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: tabContent,
            ),
    );
  }
}

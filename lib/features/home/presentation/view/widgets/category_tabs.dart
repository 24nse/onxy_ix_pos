import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/adaptive_layout.dart';

class CategoryTabs extends StatefulWidget {
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
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        alignment: Alignment.center,
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFd1d6e1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: AdaptiveLayout(
          // mobile: _buildScrollableLayout(),
          // tablet: _buildExpandedLayout(),
          // desktop: _buildExpandedLayout(),
          mobileLayout: (context)=>_buildExpandedLayout(),
          desktopLayout: (context)=>_buildExpandedLayout(),
          tabletLayout: (context) => _buildExpandedLayout(),
        ),
      ),
    );
  }

  Widget _buildScrollableLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories.map((category) {
          return _buildTab(category, isExpanded: false);
        }).toList(),
      ),
    );
  }

  Widget _buildExpandedLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.categories.map((category) {
        return Expanded(child: _buildTab(category, isExpanded: true));
      }).toList(),
    );
  }

  Widget _buildTab(Map<String, dynamic> category, {required bool isExpanded}) {
    final theme = Theme.of(context);
    final label = category['label'] as String;
    final icon = category['icon'] as IconData;
    final isSelected = widget.selectedCategory == label;

    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final tabColor = isSelected ? Color(0xFFe5e9ec) : Color(0xFFd1d6e1);
    final onTabColor = isSelected ? Color(0xFF676f7a) : Color(0xFFa3a4b6);

    final translatedLabel =
        AppLocalizations.of(context)?.translate(label.toLowerCase()) ?? label;

    Widget tabContent = Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: tabColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: onTabColor.withOpacity(0.8), size: 14),
          const SizedBox(width: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              translatedLabel,
              style: textTheme.labelLarge?.copyWith(
                color: onTabColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => widget.onCategorySelected(label),
      child: isExpanded
          ? tabContent
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: tabContent,
            ),
    );
  }
}

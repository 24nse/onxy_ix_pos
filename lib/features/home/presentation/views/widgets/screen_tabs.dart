import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

class MainScreenTabs extends StatefulWidget implements PreferredSizeWidget {
  const MainScreenTabs({super.key});

  @override
  State<MainScreenTabs> createState() => _MainScreenTabsState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _MainScreenTabsState extends State<MainScreenTabs> {
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = DefaultTabController.of(context);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            _buildTab(context, 0, 'Products', Icons.grid_view),
            _buildTab(context, 1, 'Cart', Icons.shopping_cart),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    int index,
    String text,
    IconData icon,
  ) {
    final isSelected = _tabController.index == index;
    final tabColor = isSelected
        ? (Theme.of(context).brightness == Brightness.dark
            ? AppColors.selectedTabDark
            : const Color(0xFFe5e9ec))
        : Colors.transparent;
    final onTabColor = isSelected
        ? (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xFF676f7a))
        : const Color(0xFFa3a4b6);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: GestureDetector(
          onTap: () => _tabController.animateTo(index),
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
                    style: TextStyle(
                      fontSize: 18,
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

import 'package:flutter/material.dart';

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
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
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

  Widget _buildTab(BuildContext context, int index, String text, IconData icon) {
    final isSelected = _tabController.index == index;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: GestureDetector(
          onTap: () => _tabController.animateTo(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    color: isSelected ? Colors.white : Colors.black54, size: 20),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
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

import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';

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
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.categories.map((category) {
            final label = category['label'] as String;
            final icon = category['icon'] as IconData;
            final isSelected = widget.selectedCategory == label;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => widget.onCategorySelected(label),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade200,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Icon(icon,
                          color: isSelected ? Colors.white : Colors.black54, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        AppLocalizations.of(context)
                                ?.translate(label.toLowerCase()) ??
                            label,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

class HoverableMenuItem extends HookWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final String label;

  const HoverableMenuItem({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.borderWidth,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;

    final Color activeColor = AppColors.success;
    final Color textColor = dark ? AppColors.white : AppColors.black;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isHovered.value ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isHovered.value ? Colors.white : textColor,
            fontWeight: isHovered.value ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

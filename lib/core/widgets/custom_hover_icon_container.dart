import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

class CustomHoverIconContainer extends HookWidget {
  final IconData? icon;
  final String? imageAsset;
  final VoidCallback onTap;
  final bool isActive;
  final double borderRadius;
  final double borderWidth;
  const CustomHoverIconContainer({
    super.key,
    this.icon,
    this.imageAsset,
    required this.onTap,
    this.isActive = false,
    this.borderRadius = 6,
    this.borderWidth = 1,
  }) : assert(
         icon != null || imageAsset != null,
         'Either icon or imageAsset must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;

    // Colors
    final Color activeColor = AppColors.success;
    final Color inactiveColor = dark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderColor = isActive || isHovered.value
        ? activeColor
        : (dark ? AppColors.borderDark : AppColors.borderLight);
    final Color iconColor = (isActive || isHovered.value)
        ? AppColors.white
        : (dark ? AppColors.white : AppColors.black);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive || isHovered.value ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: isActive || isHovered.value
                ? [
                    BoxShadow(
                      color: activeColor.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: icon != null
              ? Icon(icon, color: iconColor)
              : imageAsset != null
              ? Image.asset(
                  imageAsset!,
                  color: iconColor,
                  width: 24,
                  height: 24,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

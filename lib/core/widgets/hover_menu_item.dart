

import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

class HoverableMenuItem extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final String label;
  const HoverableMenuItem({super.key, 
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.borderWidth,
    required this.label,
  });

  @override
  State<HoverableMenuItem> createState() => HoverableMenuItemState();
}

class HoverableMenuItemState extends State<HoverableMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isHovered = _isHovered;
    final theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;

    final Color activeColor = AppColors.success;
    final Color textColor = dark ? AppColors.white : AppColors.black;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 150),
padding:  EdgeInsets.zero,
        // width: widget.width,
        // height: widget.height,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isHovered ? activeColor : Colors.transparent,
          // border: Border.all(
          //   color: isHovered ? Colors.green : Colors.grey.shade300,
          //   width: widget.borderWidth,
          // ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),

        child: Text(
          widget.label,
          style: TextStyle(
            color: isHovered ? Colors.white : textColor,
            fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

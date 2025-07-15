
import 'package:flutter/material.dart';

class CustomContainerImage extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  final Color? color;

  const CustomContainerImage({
    this.width = 60,
    this.height = 60,
    this.child,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(8),
      width: width,
      height: height,
      color: color ?? Colors.white,
      child: Center(child: child),
    );
  }
}

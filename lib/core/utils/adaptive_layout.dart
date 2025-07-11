import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    Key? key,
    required this.mobileLayout,
    this.tabletLayout,
    required this.desktopLayout,
  }) : super(key: key);

  final WidgetBuilder mobileLayout;
  final WidgetBuilder? tabletLayout;
  final WidgetBuilder desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= SizeConfig.desktop) {
          return desktopLayout(context);
        } else if (width >= SizeConfig.tablet && tabletLayout != null) {
          return tabletLayout!(context);
        } else {
          return mobileLayout(context);
        }
      },
    );
  }
}

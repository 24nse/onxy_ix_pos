
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/settings/presentation/cubits/locale_cubit.dart';
import 'package:onyx_ix_pos/core/widgets/custom_hover_icon_container.dart';
import 'package:onyx_ix_pos/core/widgets/hover_menu_item.dart';

class LanguageMenuButton extends StatelessWidget {
  static const double _menuItemWidth = 5;
  static const double _menuItemHeight = 20;
  static const double _borderRadius = 2;
  static const double _borderWidth = 0;

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;
    return PopupMenuButton<Locale>(
      tooltip: '',
      padding: EdgeInsets.zero,
  menuPadding: EdgeInsets.zero,
  // constraints: BoxConstraints(), 

      offset: const Offset(-10, 42),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      itemBuilder: (context) => [
        _buildMenuItem(context, locale, const Locale('en'), 'English'),
        _buildMenuItem(context, locale, const Locale('ar'), 'العربية'),
      ],
      onSelected: (locale) {
        context.read<LocaleCubit>().setLocale(locale);
      },
      child: Builder(
        builder: (context) => CustomHoverIconContainer(
          icon: Icons.language,
          isActive: false,
          onTap: () {
            // Open the popup menu when the container or icon is pressed
            final popupMenuButton = context
                .findAncestorStateOfType<PopupMenuButtonState<Locale>>();
            popupMenuButton?.showButtonMenu();
          },

          borderRadius: _borderRadius,
          borderWidth: _borderWidth,
        ),
      ),
    );
  }

  PopupMenuItem<Locale> _buildMenuItem(
    BuildContext context,
    Locale current,
    Locale value,
    String label,
  ) {
    return PopupMenuItem<Locale>(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 4),
      value: value,
      child: HoverableMenuItem(
        width: _menuItemWidth,
        height: _menuItemHeight,
        
        borderRadius: _borderRadius,
        borderWidth: _borderWidth,
        label: label,
      ),
    );
  }
}


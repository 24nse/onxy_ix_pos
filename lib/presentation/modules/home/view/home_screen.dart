import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/theme/theme_cubit.dart';
import 'package:onyx_ix_pos/core/widgets/custom_hover_icon_container.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/localization/locale_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('app_title') ?? 'Onxy IX POS',
        ),
        actions: [
          CustomLanguageMenuButton(),
          CustomHoverIconContainer(
            icon: isDarkMode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            onTap: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}

class CustomLanguageMenuButton extends StatelessWidget {
  static const double _menuItemWidth = 5;
  static const double _menuItemHeight = 20;
  static const double _borderRadius = 4;
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
      value: value,
      child: _HoverableMenuItem(
        // width: _menuItemWidth,
        // height: _menuItemHeight,
        
        borderRadius: _borderRadius,
        borderWidth: _borderWidth,
        label: label,
      ),
    );
  }
}



class _HoverableMenuItem extends StatefulWidget {
  // final double width;
  // final double height;
  final double borderRadius;
  final double borderWidth;
  final String label;
  const _HoverableMenuItem({
    // required this.width,
    // required this.height,
    required this.borderRadius,
    required this.borderWidth,
    required this.label,
  });

  @override
  State<_HoverableMenuItem> createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<_HoverableMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isHovered = _isHovered;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        alignment: Alignment.
        center,
        duration: const Duration(milliseconds: 150),
padding:  EdgeInsets.zero,
        // width: widget.width,
        // height: widget.height,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isHovered ? Colors.green : Colors.transparent,
          // border: Border.all(
          //   color: isHovered ? Colors.green : Colors.grey.shade300,
          //   width: widget.borderWidth,
          // ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),

        child: Text(
          widget.label,
          style: TextStyle(
            color: isHovered ? Colors.white : Colors.black87,
            fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

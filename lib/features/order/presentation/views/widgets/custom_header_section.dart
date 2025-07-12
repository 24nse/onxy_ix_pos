
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/full_screen_cubit.dart';

class CustomHeaderSection extends StatelessWidget {
  const CustomHeaderSection({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                
                AppLocalizations.of(
                      context,
                    )?.translate('order_summary') ??
                    'Order Summary',
                style: theme.textTheme.displayMedium!.copyWith(
                  fontSize: getResponsiveFontSize(context, fontSize: 16)
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.fullscreen),
            onPressed: () {
              context.read<FullScreenCubit>().toggleFullScreen();
            },
          ),
        ],
      ),
    );
  }
}

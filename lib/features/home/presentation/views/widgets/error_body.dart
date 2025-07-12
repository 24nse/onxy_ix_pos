
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/search_cubit.dart';

class ErrorBody extends StatelessWidget {
  ErrorBody({super.key, this.error});
  String? error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: ${error}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: getResponsiveFontSize(context, fontSize: 12),
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.read<SearchCubit>().clearError(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

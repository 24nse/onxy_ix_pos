
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/search_bar_from_field.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/search_cubit.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/search_state.dart';
import 'package:easy_debounce/easy_debounce.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.formKey,
    required this.localizations,
  });

  final GlobalKey<FormBuilderState> formKey;
  final AppLocalizations? localizations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return SearchBarFromField(
            name: 'search',
            hintText: localizations?.translate('search_products') ?? 'Search products',
            onChanged: (value) {
              EasyDebounce.debounce(
                'search-bar-debounce',
                const Duration(milliseconds: 300),
                () => context.read<SearchCubit>().updateSearchTerm(value ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}

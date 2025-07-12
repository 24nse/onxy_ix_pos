
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/search_bar_from_field.dart';
import 'package:onyx_ix_pos/features/home/presentation/view_models/cubits/search_cubit.dart';

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
      child: FormBuilder(
        key: formKey,
        child: SearchBarFromField(
          name: "Search",
          hintText:
              localizations?.translate('search_products') ?? 'Search products',
          onChanged: (value) {
            context.read<SearchCubit>().updateSearchTerm(value ?? '');
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/features/home/data/local/mock_products.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/widgets/category_tabs.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/widgets/product_card.dart';
import 'package:onyx_ix_pos/core/widgets/search_bar_from_field.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';

class ProductCatalogSection extends HookWidget {
  const ProductCatalogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final searchTerm = useState('');
    final selectedCategory = useState('all');

    final localizations = AppLocalizations.of(context);

    final List<Map<String, dynamic>> categories = [
      {'label': 'all', 'icon': FontAwesomeIcons.listUl},
      {'label': 'beverages', 'icon': FontAwesomeIcons.mugHot},
      {'label': 'snacks', 'icon': FontAwesomeIcons.cube},
      {'label': 'meals', 'icon': FontAwesomeIcons.utensils},
    ];

    final filteredProducts = mockProducts.where((product) {
      final matchesSearchTerm = searchTerm.value.isEmpty ||
          product.name.toLowerCase().contains(searchTerm.value);
      final matchesCategory = selectedCategory.value == 'all' ||
          product.category.toLowerCase() == selectedCategory.value;
      return matchesSearchTerm && matchesCategory;
    }).toList();

    return Card(
      margin: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: FormBuilder(
                key: formKey,
                child: SearchBarFromField(
                  name: "Search",
                  hintText: localizations?.translate('search_products') ?? 'Search products',
                  onChanged: (value) {
                    searchTerm.value = value?.toLowerCase() ?? '';
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                localizations?.translate('product_catalog') ?? 'Product Catalog',
                style: AppStyles.textStyle16(context).copyWith(fontSize: 12),
              ),
            ),
            CategoryTabs(
              categories: [...categories],
              selectedCategory: selectedCategory.value,
              onCategorySelected: (category) {
                selectedCategory.value = category;
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 2.2 / 3,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onAddToCart: () {
                              context.read<CartCubit>().addToCart(product);

                              showCustomToast(
                                context,
                                title: localizations?.translate('add_to_cart') ?? 'Product Added',
                                message: localizations?.translate('product_added_to_cart_successfully') ??
                                    'Product has been added to the cart successfully.',
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

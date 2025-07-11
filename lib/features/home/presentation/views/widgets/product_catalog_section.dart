import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/widgets/show_custom_toast.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/features/home/data/local/mock_products.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/widgets/category_tabs.dart';
import 'package:onyx_ix_pos/features/home/presentation/views/widgets/product_card.dart';
import 'package:onyx_ix_pos/core/widgets/search_bar_from_field.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';

class ProductCatalogSection extends StatefulWidget {
  const ProductCatalogSection({super.key});

  @override
  State<ProductCatalogSection> createState() => _ProductCatalogSectionState();
}

class _ProductCatalogSectionState extends State<ProductCatalogSection> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _searchTerm = '';

  String _selectedCategory = 'all';
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final List<Map<String, dynamic>> categories = [
      {'label': 'all', 'icon': Icons.list_alt_outlined},
      {'label': 'beverages', 'icon': Icons.local_cafe_outlined},
      {'label': 'snacks', 'icon': Icons.cookie_outlined},
      {'label': 'meals', 'icon': Icons.restaurant_outlined},
    ];
    final filteredProducts = mockProducts.where((product) {
      final matchesSearchTerm =
          _searchTerm.isEmpty ||
          product.name.toLowerCase().contains(_searchTerm);
      final matchesCategory =
          _selectedCategory == 'all' ||
          product.category.toLowerCase() == _selectedCategory;
      return matchesSearchTerm && matchesCategory;
    }).toList();

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: FormBuilder(
                key: _formKey,
                child: SearchBarFromField(
                  name: "Search",
                  hintText: localizations?.translate('search_products') ?? 'Search products',
                  onChanged: (value) {
                    setState(() {
                      _searchTerm = value?.toLowerCase() ?? '';
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                AppLocalizations.of(context)?.translate('product_catalog') ??
                    'Product Catalog',
                style: AppStyles.textStyle16(context),
              ),
            ),
            CategoryTabs(
              categories: [...categories],
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
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
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 2.2/ 3,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 3,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: filteredProducts[index],
                            onAddToCart: () {
                              context.read<CartCubit>().addToCart(
                                filteredProducts[index],
                              );

                              showCustomToast(
                                context,
                                title: AppLocalizations.of(context)?.translate('add_to_cart') ?? 'Product Added',
                                message: AppLocalizations.of(context)?.translate('product_added_to_cart_successfully') ?? 'Product has been added to the cart successfully.',
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

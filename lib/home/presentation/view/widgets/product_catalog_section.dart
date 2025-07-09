import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/home/data/local/mock_products.dart';
import 'package:onyx_ix_pos/home/presentation/view/widgets/category_tabs.dart';
import 'package:onyx_ix_pos/home/presentation/view/widgets/product_card.dart';
import 'package:onyx_ix_pos/home/presentation/view/widgets/search_bar_from_field.dart';

class ProductCatalogSection extends StatefulWidget {
  const ProductCatalogSection({super.key});

  @override
  State<ProductCatalogSection> createState() => _ProductCatalogSectionState();
}

class _ProductCatalogSectionState extends State<ProductCatalogSection> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _searchTerm = '';
  final List<Map<String, dynamic>> categories = [
    {'label': 'All', 'icon': Icons.list_alt_outlined},
    {'label': 'Beverages', 'icon': Icons.local_cafe_outlined},
    {'label': 'Snacks', 'icon': Icons.cookie_outlined},
    {'label': 'Meals', 'icon': Icons.restaurant_outlined},
  ];

  String _selectedCategory = 'All';
  @override
  Widget build(BuildContext context) {
    final filteredProducts = mockProducts.where((product) {
      final matchesSearchTerm = _searchTerm.isEmpty ||
          product.name.toLowerCase().contains(_searchTerm);
      final matchesCategory = _selectedCategory == 'All' ||
          product.category.toLowerCase() ==
              _selectedCategory.toLowerCase();
      return matchesSearchTerm && matchesCategory;
    }).toList();


    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: FormBuilder(
                key: _formKey,
                child: SearchBarFromField(
                  name: "Search",
                  hintText: "Search products",
                  onChanged: (value) {
                    setState(() {
                      _searchTerm = value?.toLowerCase() ?? '';
                    });
                  },
                ),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: filteredProducts[index]);
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

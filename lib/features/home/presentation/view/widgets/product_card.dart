import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(product.category, style: AppStyles.textStyle12),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                    
                    color:Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle_outline, size: 16),
                          label: Text(
                            AppLocalizations.of(
                                  context,
                                )?.translate('add_to_cart') ??
                                'Add to Cart',
                          ),
                        
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            backgroundColor: AppColors.secondaryLight,
                            foregroundColor: Colors.white,
                            textStyle: AppStyles.textStyle16Bold.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

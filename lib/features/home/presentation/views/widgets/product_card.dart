import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/localization/app_localizations.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_styles.dart';
import 'package:onyx_ix_pos/features/home/domain/entities/product.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onAddToCart});
  final Product product;
   final VoidCallback onAddToCart;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: Theme.of(context).brightness == Brightness.dark
            ? BorderSide(color: Colors.grey.shade800, width: 1)
            : BorderSide.none,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildProductName(context),
                const SizedBox(height: 3),
                _buildCategoryName(context),
                const SizedBox(height: 3),
                _buildPrice(context),
                const SizedBox(height: 24),
                _buildButtonAddToCart(context),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Row _buildButtonAddToCart(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      width: 200,
                      child: ElevatedButton.icon(
                        onPressed: onAddToCart,
                        icon: const Icon(FontAwesomeIcons.cartPlus, size: 16),
                        label: Text(
                          
                          AppLocalizations.of(context)?.translate('add_to_cart') ?? 'Add to Cart',
                        ),
                      
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: AppColors.secondaryLight,
                          foregroundColor: Colors.white,
                          textStyle:TextTheme.of(context).displayLarge!.copyWith(
                            fontSize: getResponsiveFontSize(context, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }

  Text _buildPrice(BuildContext context) {
    return Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: AppStyles.textStyle16(context).copyWith(
                  fontSize: getResponsiveFontSize(context, fontSize: 10),
                  fontWeight: FontWeight.bold,
                  
                  color:Color(0xFF567cc5),
                ),
              );
  }

  Text _buildCategoryName(BuildContext context) => Text(product.category, style: AppStyles.textStyle12(context).copyWith(fontSize: getResponsiveFontSize(context, fontSize: 10),color: Color(0xFFa3a4b6),));

  Text _buildProductName(BuildContext context) {
    return Text(
                product.name,
                style: AppStyles.textStyle16(context).copyWith(
                  fontSize: getResponsiveFontSize(context, fontSize: 14),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              );
  }
Expanded _buildImageSection() {
    return Expanded(
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(4),
      ),
      child: Image.asset(
        product.image,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(FontAwesomeIcons.image, size: 40, color: Colors.grey),
          );
        },
      ),
    ),
  );
  }
}


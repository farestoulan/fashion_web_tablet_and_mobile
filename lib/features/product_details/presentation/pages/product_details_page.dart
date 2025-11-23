import 'package:flutter/material.dart';
import '../../../product/domain/entities/product.dart';
import 'mobile/product_details_mobile.dart';
import 'tablet/product_details_tablet.dart';
import 'web/product_details_web.dart';
import '../../../../core/utils/responsive_utils.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    if (isMobile) {
      return ProductDetailsMobile(product: product);
    } else if (isTablet) {
      return ProductDetailsTablet(product: product);
    } else {
      return ProductDetailsWeb(product: product);
    }
  }
}

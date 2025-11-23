import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'mobile/product_mobile.dart';
import 'tablet/product_tablet.dart';
import 'web/product_web.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          return const ProductMobile();
        } else if (ResponsiveUtils.isTablet(context)) {
          return const ProductTablet();
        } else {
          return const ProductWeb();
        }
      },
    );
  }
}

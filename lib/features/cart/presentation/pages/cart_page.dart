import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'mobile/cart_mobile.dart';
import 'tablet/cart_tablet.dart';
import 'web/cart_web.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          return const CartMobile();
        } else if (ResponsiveUtils.isTablet(context)) {
          return const CartTablet();
        } else {
          return const CartWeb();
        }
      },
    );
  }
}

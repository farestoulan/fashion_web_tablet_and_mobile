import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'mobile/category_mobile.dart';
import 'tablet/category_tablet.dart';
import 'web/category_web.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          return const CategoryMobile();
        } else if (ResponsiveUtils.isTablet(context)) {
          return const CategoryTablet();
        } else {
          return const CategoryWeb();
        }
      },
    );
  }
}

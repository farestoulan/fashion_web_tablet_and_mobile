import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'mobile/brand_mobile.dart';
import 'tablet/brand_tablet.dart';
import 'web/brand_web.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          return const BrandMobile();
        } else if (ResponsiveUtils.isTablet(context)) {
          return const BrandTablet();
        } else {
          return const BrandWeb();
        }
      },
    );
  }
}

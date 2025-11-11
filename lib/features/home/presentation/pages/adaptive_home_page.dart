import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'mobile_home_page.dart';
import 'tablet_home_page.dart';
import 'home_page.dart';
import '../../../../core/di/injection_container.dart';

class AdaptiveHomePage extends StatelessWidget {
  const AdaptiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to determine screen size and switch layouts
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          // Mobile layout (< 600px)
          return const MobileHomePage();
        } else if (ResponsiveUtils.isTablet(context)) {
          // Tablet layout (600px - 1024px)
          return const TabletHomePage();
        } else {
          // Desktop layout (>= 1024px)
          final di = InjectionContainer();
          return HomePage(
            getNewArrivalsUseCase: di.getNewArrivals,
            getAllBrandsUseCase: di.getAllBrands,
          );
        }
      },
    );
  }
}

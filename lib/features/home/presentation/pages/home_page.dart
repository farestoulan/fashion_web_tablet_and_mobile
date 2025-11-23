import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/di/injection_container.dart';
import 'mobile/home_mobile.dart';
import 'tablet/home_tablet.dart';
import 'web/home_web.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          return const HomeMobile();
        } else if (ResponsiveUtils.isTablet(context)) {
          return const HomeTablet();
        } else {
          final di = InjectionContainer();
          return HomeWeb(
            getNewArrivalsUseCase: di.getNewArrivals,
            getAllBrandsUseCase: di.getAllBrands,
          );
        }
      },
    );
  }
}

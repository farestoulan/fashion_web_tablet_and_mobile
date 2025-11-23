import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'mobile/main_mobile.dart';
import 'tablet/main_tablet.dart';
import 'web/main_web.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          return const MainMobile();
        } else if (ResponsiveUtils.isTablet(context)) {
          return const MainTablet();
        } else {
          return const MainWeb();
        }
      },
    );
  }
}

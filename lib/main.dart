import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  // Initialize Dependency Injection
  final di = InjectionContainer();
  di.init();

  runApp(FashionApp(di: di));
}

class FashionApp extends StatelessWidget {
  final InjectionContainer di;

  const FashionApp({super.key, required this.di});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fashion International Group',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}

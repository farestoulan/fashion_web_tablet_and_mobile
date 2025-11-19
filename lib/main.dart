import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'features/main/presentation/pages/main_scaffold.dart';

void main() {
  // Initialize Dependency Injection n
  final di = InjectionContainer();
  di.init();

  runApp(FashionApp(di: di));
}

class FashionApp extends StatelessWidget {
  final InjectionContainer di;

  const FashionApp({super.key, required this.di});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion International Group',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScaffold(),
    );
  }
}

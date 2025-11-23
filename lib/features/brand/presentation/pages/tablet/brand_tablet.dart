import 'package:flutter/material.dart';

class BrandTablet extends StatelessWidget {
  const BrandTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brands')),
      body: const Center(child: Text('Brand Tablet')),
    );
  }
}

import 'package:flutter/material.dart';

class ProductTablet extends StatelessWidget {
  const ProductTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: const Center(child: Text('Product Tablet')),
    );
  }
}

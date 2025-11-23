import 'package:flutter/material.dart';

class ProductMobile extends StatelessWidget {
  const ProductMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: const Center(child: Text('Product Mobile')),
    );
  }
}

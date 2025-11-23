import 'package:flutter/material.dart';

class BrandMobile extends StatelessWidget {
  const BrandMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brands')),
      body: const Center(child: Text('Brand Mobile')),
    );
  }
}

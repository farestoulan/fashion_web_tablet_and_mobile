import 'package:flutter/material.dart';

class CategoryTablet extends StatelessWidget {
  const CategoryTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: const Center(child: Text('Category Tablet')),
    );
  }
}

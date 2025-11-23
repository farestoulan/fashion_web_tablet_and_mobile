import 'package:flutter/material.dart';

class CategoryMobile extends StatelessWidget {
  const CategoryMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: const Center(child: Text('Category Mobile')),
    );
  }
}

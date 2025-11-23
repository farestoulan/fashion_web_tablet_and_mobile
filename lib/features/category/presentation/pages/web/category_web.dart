import 'package:flutter/material.dart';

class CategoryWeb extends StatelessWidget {
  const CategoryWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: const Center(child: Text('Category Web')),
    );
  }
}

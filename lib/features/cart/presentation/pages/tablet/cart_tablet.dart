import 'package:flutter/material.dart';

class CartTablet extends StatelessWidget {
  const CartTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(child: Text('Cart Tablet')),
    );
  }
}

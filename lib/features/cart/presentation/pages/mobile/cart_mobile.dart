import 'package:flutter/material.dart';

class CartMobile extends StatelessWidget {
  const CartMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(child: Text('Cart Mobile')),
    );
  }
}

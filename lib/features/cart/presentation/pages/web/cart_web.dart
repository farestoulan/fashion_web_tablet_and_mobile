import 'package:flutter/material.dart';

class CartWeb extends StatelessWidget {
  const CartWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(child: Text('Cart Web')),
    );
  }
}

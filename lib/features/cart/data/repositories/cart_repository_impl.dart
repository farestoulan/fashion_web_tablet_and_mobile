import 'dart:async';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _cartItems = [];
  final StreamController<int> _cartCountController = StreamController<int>.broadcast();

  @override
  Future<List<CartItem>> getCartItems() async {
    return List.from(_cartItems);
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final existingIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.product.id == item.product.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }
    
    _cartCountController.add(_cartItems.length);
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    _cartCountController.add(_cartItems.length);
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    
    if (index != -1) {
      if (quantity <= 0) {
        await removeFromCart(productId);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
        _cartCountController.add(_cartItems.length);
      }
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
    _cartCountController.add(0);
  }

  @override
  Stream<int> getCartItemCount() {
    return _cartCountController.stream;
  }

  void dispose() {
    _cartCountController.close();
  }
}


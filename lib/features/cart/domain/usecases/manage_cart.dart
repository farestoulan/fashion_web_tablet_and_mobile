import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class ManageCart {
  final CartRepository repository;

  ManageCart(this.repository);

  Future<List<CartItem>> getCartItems() async {
    return await repository.getCartItems();
  }

  Future<void> addToCart(CartItem item) async {
    await repository.addToCart(item);
  }

  Future<void> removeFromCart(String productId) async {
    await repository.removeFromCart(productId);
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    await repository.updateQuantity(productId, quantity);
  }

  Future<void> clearCart() async {
    await repository.clearCart();
  }

  Stream<int> getCartItemCount() {
    return repository.getCartItemCount();
  }
}


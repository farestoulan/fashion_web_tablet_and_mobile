import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getNewArrivals();
  Future<List<Product>> searchProducts(String query);
  Future<Product?> getProductById(String id);
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> getProductsByBrand(String brandId);
}


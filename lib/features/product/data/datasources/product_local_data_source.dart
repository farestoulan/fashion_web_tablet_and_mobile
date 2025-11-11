import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  // In a real app, this would use shared_preferences, sqflite, or hive
  final List<ProductModel> _cache = [];

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    return _cache;
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    _cache.clear();
    _cache.addAll(products);
  }
}


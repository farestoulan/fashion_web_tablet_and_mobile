import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Product>> getNewArrivals() async {
    try {
      final products = await remoteDataSource.getNewArrivals();
      await localDataSource.cacheProducts(products);
      return products;
    } catch (e) {
      // If remote fails, try to get cached data
      return await localDataSource.getCachedProducts();
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    return await remoteDataSource.searchProducts(query);
  }

  @override
  Future<Product?> getProductById(String id) async {
    return await remoteDataSource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    return await remoteDataSource.getProductsByCategory(categoryId);
  }

  @override
  Future<List<Product>> getProductsByBrand(String brandId) async {
    return await remoteDataSource.getProductsByBrand(brandId);
  }
}


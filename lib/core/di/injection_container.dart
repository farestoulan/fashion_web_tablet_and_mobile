import '../../features/brand/data/datasources/brand_data_source.dart';
import '../../features/product/data/datasources/product_local_data_source.dart';
import '../../features/product/data/datasources/product_remote_data_source.dart';
import '../../features/brand/data/repositories/brand_repository_impl.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/brand/domain/repositories/brand_repository.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/brand/domain/usecases/get_all_brands.dart';
import '../../features/product/domain/usecases/get_new_arrivals.dart';
import '../../features/cart/domain/usecases/manage_cart.dart';
import '../../features/product/domain/usecases/search_products.dart';

/// Dependency Injection Container
/// In a production app, consider using get_it or injectable package
class InjectionContainer {
  // Singleton instance
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  // Data Sources
  ProductRemoteDataSource? _productRemoteDataSource;
  ProductLocalDataSource? _productLocalDataSource;
  BrandDataSource? _brandDataSource;

  // Repositories
  ProductRepository? _productRepository;
  BrandRepository? _brandRepository;
  CartRepository? _cartRepository;

  // Use Cases
  GetNewArrivals? _getNewArrivals;
  SearchProducts? _searchProducts;
  GetAllBrands? _getAllBrands;
  ManageCart? _manageCart;

  bool _isInitialized = false;

  // Initialize all dependencies
  void init() {
    if (_isInitialized) return; // Skip if already initialized

    // Data Sources
    _productRemoteDataSource = ProductRemoteDataSourceImpl();
    _productLocalDataSource = ProductLocalDataSourceImpl();
    _brandDataSource = BrandDataSourceImpl();

    // Repositories
    _productRepository = ProductRepositoryImpl(
      remoteDataSource: _productRemoteDataSource!,
      localDataSource: _productLocalDataSource!,
    );
    _brandRepository = BrandRepositoryImpl(dataSource: _brandDataSource!);
    _cartRepository = CartRepositoryImpl();

    // Use Cases
    _getNewArrivals = GetNewArrivals(_productRepository!);
    _searchProducts = SearchProducts(_productRepository!);
    _getAllBrands = GetAllBrands(_brandRepository!);
    _manageCart = ManageCart(_cartRepository!);

    _isInitialized = true;
  }

  // Reset for testing purposes
  void reset() {
    _productRemoteDataSource = null;
    _productLocalDataSource = null;
    _brandDataSource = null;
    _productRepository = null;
    _brandRepository = null;
    _cartRepository = null;
    _getNewArrivals = null;
    _searchProducts = null;
    _getAllBrands = null;
    _manageCart = null;
    _isInitialized = false;
  }

  // Getters for Use Cases
  GetNewArrivals get getNewArrivals {
    if (!_isInitialized) throw Exception('InjectionContainer not initialized. Call init() first.');
    return _getNewArrivals!;
  }

  SearchProducts get searchProducts {
    if (!_isInitialized) throw Exception('InjectionContainer not initialized. Call init() first.');
    return _searchProducts!;
  }

  GetAllBrands get getAllBrands {
    if (!_isInitialized) throw Exception('InjectionContainer not initialized. Call init() first.');
    return _getAllBrands!;
  }

  ManageCart get manageCart {
    if (!_isInitialized) throw Exception('InjectionContainer not initialized. Call init() first.');
    return _manageCart!;
  }

  // Getters for Repositories (if needed directly)
  ProductRepository get productRepository {
    if (!_isInitialized) throw Exception('InjectionContainer not initialized. Call init() first.');
    return _productRepository!;
  }

  BrandRepository get brandRepository {
    if (!_isInitialized) throw Exception('InjectionContainer not initialized. Call init() first.');
    return _brandRepository!;
  }

  CartRepository get cartRepository {
    if (!_isInitialized) throw Exception('InjectionContainer not initialized. Call init() first.');
    return _cartRepository!;
  }
}


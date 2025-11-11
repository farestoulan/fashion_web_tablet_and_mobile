import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getNewArrivals();
  Future<List<ProductModel>> searchProducts(String query);
  Future<ProductModel?> getProductById(String id);
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<List<ProductModel>> getProductsByBrand(String brandId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  // In a real app, this would use http/dio to fetch from an API
  
  // Mock data for demonstration
  final List<ProductModel> _mockProducts = [
    ProductModel(
      id: '1',
      title: 'BSB Striped oversized blazer',
      description: 'A stylish oversized blazer with stripes',
      imageUrl: 'https://images.unsplash.com/photo-1591369822096-ffd140ec948f?w=400',
      price: 6535.00,
      originalPrice: 13065.00,
      categories: 'BLAZER, CLOTHING, COATS & JACKETS',
      inStock: true,
      rating: 0.0,
      reviewCount: 0,
    ),
    ProductModel(
      id: '2',
      title: 'BSB Oversized blazer',
      description: 'Classic oversized blazer',
      imageUrl: 'https://images.unsplash.com/photo-1594633313593-bab3825d0caf?w=400',
      price: 6550.00,
      originalPrice: 13100.00,
      categories: 'BLAZER, CLOTHING, COATS & JACKETS',
      inStock: true,
      rating: 0.0,
      reviewCount: 0,
    ),
    ProductModel(
      id: '3',
      title: 'BSB V blazer with bejeweled...',
      description: 'Elegant V-neck blazer with bejeweled details',
      imageUrl: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=400',
      price: 5675.00,
      originalPrice: 11350.00,
      categories: 'BLAZER, CLOTHING, COATS & JACKETS',
      inStock: true,
      rating: 0.0,
      reviewCount: 0,
    ),
    ProductModel(
      id: '4',
      title: 'BSB Sleeveless Printed Blazer',
      description: 'Modern sleeveless blazer with print',
      imageUrl: 'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=400',
      price: 4795.00,
      originalPrice: 9585.00,
      categories: 'BLAZER, CLOTHING, COATS & JACKETS',
      inStock: true,
      rating: 0.0,
      reviewCount: 0,
    ),
  ];

  @override
  Future<List<ProductModel>> getNewArrivals() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockProducts;
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts.where((product) =>
      product.title.toLowerCase().contains(query.toLowerCase()) ||
      product.categories.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts;
  }

  @override
  Future<List<ProductModel>> getProductsByBrand(String brandId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts;
  }
}


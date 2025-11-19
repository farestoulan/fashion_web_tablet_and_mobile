import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    super.imageUrls,
    required super.price,
    required super.originalPrice,
    required super.categories,
    super.inStock,
    super.rating,
    super.reviewCount,
    super.sku,
    super.brand,
    super.availableColors,
    super.availableSizes,
    super.stockQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String,
      imageUrls: json['imageUrls'] != null
          ? List<String>.from(json['imageUrls'] as List)
          : null,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num).toDouble(),
      categories: json['categories'] as String,
      inStock: json['inStock'] as bool? ?? true,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      sku: json['sku'] as String?,
      brand: json['brand'] as String?,
      availableColors: json['availableColors'] != null
          ? List<String>.from(json['availableColors'] as List)
          : null,
      availableSizes: json['availableSizes'] != null
          ? List<String>.from(json['availableSizes'] as List)
          : null,
      stockQuantity: json['stockQuantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'price': price,
      'originalPrice': originalPrice,
      'categories': categories,
      'inStock': inStock,
      'rating': rating,
      'reviewCount': reviewCount,
      'sku': sku,
      'brand': brand,
      'availableColors': availableColors,
      'availableSizes': availableSizes,
      'stockQuantity': stockQuantity,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      imageUrls: product.imageUrls,
      price: product.price,
      originalPrice: product.originalPrice,
      categories: product.categories,
      inStock: product.inStock,
      rating: product.rating,
      reviewCount: product.reviewCount,
      sku: product.sku,
      brand: product.brand,
      availableColors: product.availableColors,
      availableSizes: product.availableSizes,
      stockQuantity: product.stockQuantity,
    );
  }
}

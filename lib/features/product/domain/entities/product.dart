class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> imageUrls; // Multiple images for gallery
  final double price;
  final double originalPrice;
  final String categories;
  final bool inStock;
  final double rating;
  final int reviewCount;
  final String? sku;
  final String? brand;
  final List<String>? availableColors;
  final List<String>? availableSizes;
  final int stockQuantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    List<String>? imageUrls,
    required this.price,
    required this.originalPrice,
    required this.categories,
    this.inStock = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.sku,
    this.brand,
    this.availableColors,
    this.availableSizes,
    this.stockQuantity = 0,
  }) : imageUrls = imageUrls ?? [imageUrl];

  double get discountPercentage {
    if (originalPrice == 0) return 0;
    return ((originalPrice - price) / originalPrice) * 100;
  }
}


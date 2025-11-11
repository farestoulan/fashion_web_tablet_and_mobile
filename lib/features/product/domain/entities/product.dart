class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String categories;
  final bool inStock;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.categories,
    this.inStock = true,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  double get discountPercentage {
    if (originalPrice == 0) return 0;
    return ((originalPrice - price) / originalPrice) * 100;
  }
}


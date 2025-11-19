import 'package:flutter/material.dart';
import '../../../product/domain/entities/product.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedImageIndex = 0;
  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _selectedColor =
        widget.product.availableColors?.isNotEmpty == true
            ? widget.product.availableColors!.first
            : null;
    _selectedSize =
        widget.product.availableSizes?.isNotEmpty == true
            ? widget.product.availableSizes!.first
            : null;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getHorizontalPadding(context),
            vertical: 16.0,
          ),
          child:
              isMobile
                  ? _buildMobileLayout()
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left side - Image Gallery
                          Expanded(flex: 1, child: _buildImageGallery()),
                          SizedBox(width: isTablet ? 24 : 32),
                          // Right side - Product Information
                          Expanded(flex: 1, child: _buildProductInfo()),
                        ],
                      ),
                      const SizedBox(height: 48),
                      // Additional Information Section
                      _buildAdditionalInformation(),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBreadcrumbs(),
        const SizedBox(height: 16),
        _buildImageGallery(showBreadcrumbs: false),
        const SizedBox(height: 24),
        _buildProductInfo(),
        const SizedBox(height: 48),
        // Additional Information Section
        _buildAdditionalInformation(),
      ],
    );
  }

  Widget _buildImageGallery({bool showBreadcrumbs = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumbs
        if (showBreadcrumbs) ...[
          _buildBreadcrumbs(),
          const SizedBox(height: 24),
        ],
        // Main Image
        AspectRatio(
          aspectRatio: 0.75,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.product.imageUrls[_selectedImageIndex],
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Image Thumbnails
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.imageUrls.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedImageIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isSelected ? AppColors.secondary : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.product.imageUrls[index],
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBreadcrumbs() {
    final categories =
        widget.product.categories.split(',').map((e) => e.trim()).toList();
    return Wrap(
      spacing: 8,
      children: [
        _buildBreadcrumbItem('Home', () {}),
        ...categories.map((category) => _buildBreadcrumbItem(category, () {})),
        _buildBreadcrumbItem(widget.product.title, null),
      ],
    );
  }

  Widget _buildBreadcrumbItem(String text, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: onTap != null ? Colors.grey[600] : Colors.black,
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 16, color: Colors.grey[600]),
          ],
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Title
        Text(
          widget.product.title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Brand
        if (widget.product.brand != null) ...[
          Text(
            widget.product.brand!,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
        ],
        // Categories
        Text(
          widget.product.categories,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        // SKU
        if (widget.product.sku != null) ...[
          Text(
            'SKU: ${widget.product.sku}',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
        ],
        // Price
        Row(
          children: [
            Text(
              _formatPrice(widget.product.price),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _formatPrice(widget.product.originalPrice),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Rating
        Row(
          children: [
            ...List.generate(5, (index) {
              return Icon(
                Icons.star,
                color:
                    index < widget.product.rating.round()
                        ? Colors.amber
                        : Colors.grey[300],
                size: 20,
              );
            }),
            const SizedBox(width: 8),
            Text(
              '${widget.product.rating} (${widget.product.reviewCount} reviews)',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Description
        Text(
          widget.product.description,
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 32),
        // Color Options
        if (widget.product.availableColors != null &&
            widget.product.availableColors!.isNotEmpty) ...[
          const Text(
            'Color:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children:
                widget.product.availableColors!.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getColorFromString(color),
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.secondary
                                  : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          isSelected
                              ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                              : null,
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 24),
        ],
        // Size Options
        if (widget.product.availableSizes != null &&
            widget.product.availableSizes!.isNotEmpty) ...[
          const Text(
            'Size:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children:
                widget.product.availableSizes!.map((size) {
                  final isSelected = _selectedSize == size;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSize = size;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondary : Colors.white,
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.secondary
                                  : Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedSize = null;
              });
            },
            child: const Text(
              'Clean All',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
        ],
        // Stock Status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.orange[200]!),
          ),
          child: Text(
            '${widget.product.stockQuantity} in stock',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Quantity Selector
        Row(
          children: [
            const Text(
              'Quantity:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed:
                        _quantity > 1
                            ? () {
                              setState(() {
                                _quantity--;
                              });
                            }
                            : null,
                    icon: const Icon(Icons.remove),
                    iconSize: 20,
                  ),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed:
                        _quantity < widget.product.stockQuantity
                            ? () {
                              setState(() {
                                _quantity++;
                              });
                            }
                            : null,
                    icon: const Icon(Icons.add),
                    iconSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add to cart
                },
                icon: const Icon(Icons.shopping_bag, size: 20),
                label: const Text(
                  'ADD TO CART',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Buy now
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.secondary,
                  side: const BorderSide(color: AppColors.secondary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'BUY NOW',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Social Sharing
        Row(
          children: [
            const Text(
              'Share:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.facebook, () {}),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.close, () {}), // X/Twitter
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.share, () {}), // Pinterest placeholder
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.chat, () {}), // WhatsApp
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.business, () {}), // LinkedIn
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.favorite_border, () {}), // Wishlist
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with underline
        Row(
          children: [
            Text(
              'Additional information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Information rows
        _buildInfoRow('Color', _formatColors()),
        const SizedBox(height: 12),
        _buildInfoRow('Size', _formatSizes()),
        const SizedBox(height: 12),
        if (widget.product.brand != null) ...[
          _buildInfoRow('Brand', widget.product.brand!),
          const SizedBox(height: 12),
        ],
        // Season - will be displayed when added to Product entity
        _buildInfoRow('Season', 'spring/summer', isHighlighted: true),
        const SizedBox(height: 12),
        // Gender - will be displayed when added to Product entity
        _buildInfoRow('Gender', 'Women', isHighlighted: true),
      ],
    );
  }

  String _formatColors() {
    if (widget.product.availableColors == null ||
        widget.product.availableColors!.isEmpty) {
      return 'N/A';
    }
    return widget.product.availableColors!.join(', ');
  }

  String _formatSizes() {
    if (widget.product.availableSizes == null ||
        widget.product.availableSizes!.isEmpty) {
      return 'N/A';
    }
    return widget.product.availableSizes!.join(', ');
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
        const SizedBox(width: 50),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            color: isHighlighted ? AppColors.secondary : Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 20, color: Colors.grey[700]),
      ),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'white':
        return Colors.white;
      case 'black':
        return Colors.black;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'grey':
      case 'gray':
        return Colors.grey;
      default:
        return Colors.grey[300]!;
    }
  }

  String _formatPrice(double price) {
    // Format price with dots as thousand separators (EGP format)
    final parts = price.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    String formatted = '';
    int count = 0;
    for (int i = integerPart.length - 1; i >= 0; i--) {
      if (count == 3) {
        formatted = '.$formatted';
        count = 0;
      }
      formatted = integerPart[i] + formatted;
      count++;
    }

    return '$formatted,$decimalPart EGP';
  }
}

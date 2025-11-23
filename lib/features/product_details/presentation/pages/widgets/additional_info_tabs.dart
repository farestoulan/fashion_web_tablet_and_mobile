import 'package:flutter/material.dart';
import '../../../../product/domain/entities/product.dart';
import '../../../../../core/constants/app_colors.dart';

class AdditionalInfoTabs extends StatelessWidget {
  final Product product;
  final double? tabHeight;

  const AdditionalInfoTabs({
    super.key,
    required this.product,
    this.tabHeight = 500,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: TabBar(
              labelColor: AppColors.secondary,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: AppColors.secondary,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(text: 'DESCRIPTION'),
                Tab(text: 'ADDITIONAL INFORMATION'),
                Tab(text: 'REVIEWS'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Tab Content
          SizedBox(
            height: tabHeight,
            child: TabBarView(
              children: [
                _buildDescriptionTab(),
                _buildAdditionalInfoTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.description,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.8,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Product Features',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          _buildFeatureItem('Premium quality fabric for lasting comfort'),
          _buildFeatureItem('Comfortable fit suitable for all-day wear'),
          _buildFeatureItem('Easy to care for and maintain'),
          _buildFeatureItem('Available in multiple colors and sizes'),
          _buildFeatureItem('Perfect for various occasions'),
          const SizedBox(height: 32),
          Text(
            'Care Instructions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          _buildCareInstruction(
            Icons.local_laundry_service,
            'Machine wash cold with similar colors',
          ),
          _buildCareInstruction(Icons.do_not_disturb_on, 'Do not bleach'),
          _buildCareInstruction(Icons.dry_cleaning, 'Tumble dry low heat'),
          _buildCareInstruction(Icons.iron, 'Iron on low heat if needed'),
          _buildCareInstruction(Icons.warning_amber, 'Do not dry clean'),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoTab() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            _buildInfoTableRow('Color', _formatColors(), isFirst: true),
            _buildInfoTableRow('Size', _formatSizes()),
            if (product.brand != null)
              _buildInfoTableRow('Brand', product.brand!),
            _buildInfoTableRow('SKU', product.sku ?? 'N/A'),
            _buildInfoTableRow('Season', 'Spring/Summer'),
            _buildInfoTableRow('Gender', 'Women'),
            _buildInfoTableRow('Material', '100% Premium Cotton'),
            _buildInfoTableRow('Pattern', 'Solid'),
            _buildInfoTableRow('Style', 'Casual, Elegant'),
            _buildInfoTableRow('Occasion', 'Casual, Party, Office'),
            _buildInfoTableRow(
              'Stock Status',
              '${product.stockQuantity} items available',
              valueColor:
                  product.stockQuantity > 0
                      ? Colors.green[700]
                      : Colors.red[700],
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                            height: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '/ 5.0',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color:
                              index < product.rating.round()
                                  ? Colors.amber
                                  : Colors.grey[300],
                          size: 24,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Based on ${product.reviewCount} reviews',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Customer Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          _buildReviewItem(
            'Sarah Johnson',
            5,
            'Amazing quality!',
            'This product exceeded my expectations. The quality is outstanding and it fits perfectly. The fabric is soft and comfortable. Highly recommend to anyone looking for quality fashion!',
            '2 days ago',
          ),
          const SizedBox(height: 16),
          _buildReviewItem(
            'Emma Wilson',
            4,
            'Great purchase',
            'Very happy with this purchase. The material is nice and the color is exactly as shown in the pictures. Delivery was fast too!',
            '1 week ago',
          ),
          const SizedBox(height: 16),
          _buildReviewItem(
            'Michael Brown',
            5,
            'Excellent product!',
            'Fast delivery and great product quality. The fit is perfect and the design is beautiful. Will definitely buy again!',
            '2 weeks ago',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            child: Icon(
              Icons.check_circle,
              size: 20,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareInstruction(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 20, color: Colors.grey[600]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTableRow(
    String label,
    String value, {
    bool isFirst = false,
    bool isLast = false,
    Color? valueColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            isFirst || !isFirst && label.hashCode % 2 == 0
                ? Colors.white
                : Colors.grey[50],
        border: Border(
          bottom:
              isLast ? BorderSide.none : BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: valueColor ?? Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(
    String name,
    int rating,
    String title,
    String comment,
    String date,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.secondary,
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color:
                                index < rating
                                    ? Colors.amber
                                    : Colors.grey[300],
                            size: 18,
                          );
                        }),
                        const SizedBox(width: 12),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  String _formatColors() {
    if (product.availableColors == null || product.availableColors!.isEmpty) {
      return 'N/A';
    }
    return product.availableColors!.join(', ');
  }

  String _formatSizes() {
    if (product.availableSizes == null || product.availableSizes!.isEmpty) {
      return 'N/A';
    }
    return product.availableSizes!.join(', ');
  }
}

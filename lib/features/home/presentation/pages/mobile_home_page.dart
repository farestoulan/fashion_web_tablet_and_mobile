import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  final TextEditingController _searchController = TextEditingController();
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();

  // Sample categories - replace with actual data
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Accessories', 'icon': Icons.watch},
    {'name': 'Activewear', 'icon': Icons.sports},
    {'name': 'Baby Doll', 'icon': Icons.child_care},
    {'name': 'Backpacks', 'icon': Icons.backpack},
    {'name': 'Bags', 'icon': Icons.shopping_bag},
    {'name': 'Belts', 'icon': Icons.safety_divider},
    {'name': 'Bikini', 'icon': Icons.pool},
    {'name': 'Blazers', 'icon': Icons.style},
    {'name': 'Boots', 'icon': Icons.hiking},
  ];

  final List<String> _bannerImages = [
    'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=1200',
    'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=1200',
    'https://images.unsplash.com/photo-1445205170230-053b83016050?w=1200',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            _buildBanner(),
            _buildCategoryGrid(),
            _buildPromoBanners(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor: Colors.white,
      expandedHeight: 140,
      collapsedHeight: 70,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top row with grid icon and greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  const Text(
                    'Hey,👋',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Search Bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Product',
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  onChanged: (value) {
                    // Handle search
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return SliverToBoxAdapter(
      child: Container(
        height: ResponsiveUtils.getResponsiveValue(
          context,
          mobile: 280,
          tablet: 400,
          desktop: 500,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            PageView.builder(
              controller: _bannerController,
              itemCount: _bannerImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(_bannerImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            // Banner indicators
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _bannerImages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentBannerIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          _currentBannerIndex == index
                              ? AppColors.primary
                              : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 16),
          // First row of categories
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildCategoryItem(category['name'], category['icon']),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Second row of categories
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length - 6,
              itemBuilder: (context, index) {
                final category = _categories[index + 6];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildCategoryItem(category['name'], category['icon']),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, IconData icon) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $name'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[700]!, Colors.grey[600]!],
              ),
            ),
            child: Stack(
              children: [
                // "fig" logo representation
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'fig',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 70,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanners() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // Two banners side by side
          Row(
            children: [
              Expanded(
                child: _buildPromoBanner(
                  title: 'الموسم الجديد',
                  subtitle: 'ديم',
                  textColor: Colors.black,
                  backgroundColor: Colors.grey[200]!,
                  imageUrl:
                      'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=800',
                  alignment: Alignment.bottomLeft,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPromoBanner(
                  title: 'الموسم الجديد',
                  subtitle: 'ديم',
                  badge: 'نساء رجال',
                  textColor: Colors.black,
                  backgroundColor: Colors.grey[200]!,
                  imageUrl:
                      'https://images.unsplash.com/photo-1490114538077-0a7f8cb49891?w=800',
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  Widget _buildPromoBanner({
    required String title,
    required String subtitle,
    String? badge,
    required Color textColor,
    required Color backgroundColor,
    required String imageUrl,
    required Alignment alignment,
  }) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay from bottom
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.7),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.25, 0.5],
              ),
            ),
          ),
          // Content at bottom
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (badge != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../product/domain/entities/product.dart';
import '../../../product/domain/usecases/get_new_arrivals.dart';
import '../../../brand/domain/usecases/get_all_brands.dart';
import '../../../../core/widgets/header/app_logo.dart';
import '../../../../core/widgets/header/search_bar.dart';
import '../../../../core/widgets/header/header_icon_button.dart';
import '../widgets/hero_banner.dart';
import '../../../product/presentation/widgets/product_card.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../widgets/promo_banner.dart';

class HomePage extends StatefulWidget {
  final GetNewArrivals getNewArrivalsUseCase;
  final GetAllBrands getAllBrandsUseCase;

  const HomePage({
    super.key,
    required this.getNewArrivalsUseCase,
    required this.getAllBrandsUseCase,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    try {
      final products = await widget.getNewArrivalsUseCase();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildMainNavigation(),
            _buildSecondaryNavigation(),
            _buildContentArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              const AppLogo(),
              const SizedBox(width: 40),
              Expanded(
                child: AppSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    // Handle search
                  },
                ),
              ),
              const SizedBox(width: 40),
              _buildHeaderIcons(),
            ],
          ),
          const SizedBox(height: 20),
          _buildCategoryNavigation(),
        ],
      ),
    );
  }

  Widget _buildHeaderIcons() {
    return Row(
      children: [
        HeaderIconButton(
          icon: Icons.person_outline,
          label: 'Login',
          onPressed: () {},
        ),
        const SizedBox(width: 24),
        HeaderIconButton(
          icon: Icons.chat_bubble_outline,
          label: 'Live chat',
          onPressed: () {},
        ),
        const SizedBox(width: 24),
        HeaderIconButton(
          icon: Icons.favorite_border,
          label: 'Wishlist',
          onPressed: () {},
        ),
        const SizedBox(width: 24),
        HeaderIconButton(
          icon: Icons.location_on_outlined,
          label: 'Track Orders',
          onPressed: () {},
        ),
        const SizedBox(width: 24),
        HeaderIconButton(
          icon: Icons.shopping_cart_outlined,
          label: 'Cart',
          badgeCount: 0,
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        Text(
          'Hello, Guest!',
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildCategoryNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCategoryButton('Women'),
        const SizedBox(width: 40),
        _buildCategoryButton('Men'),
        const SizedBox(width: 40),
        _buildCategoryButton('Kids'),
      ],
    );
  }

  Widget _buildCategoryButton(String title) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildMainNavigation() {
    return Container(
      color: const Color(0xFFE53935),
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Row(
          children: [
            _buildNavItem('Lipsy New Collection'),
            _buildNavItem('Lipsy New Collection'),
            _buildNavItem('Pronovias New Collection'),
            _buildNavItem('Pronovias New Collection'),
            _buildNavItem('Women Secret New Collection'),
            _buildNavItem('Pronovias New Collection'),
            _buildNavItem('Deal Of The Day'),
            _buildNavItem('Our Brands'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildSecondaryNavigation() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.black),
            label: const Text(
              'Shop',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(width: 24),
          _buildSecNavItem('New Arrival'),
          const SizedBox(width: 24),
          _buildSecNavItem('Special Offers'),
          const SizedBox(width: 24),
          _buildSecNavItem('Store Location'),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.brush, color: Colors.white),
            label: const Text('Need a personal stylist? contact us'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB71C1C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecNavItem(String title) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget _buildContentArea() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: HeroBanner(
                title: 'EVERYTHING STARTS\nWITH AN IDEA.',
                subtitle:
                    'Shop all of our brand and collections with exclusive discounts',
                buttonText: 'SHOP NOW',
                backgroundImage:
                    'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=1200',
                onButtonPressed: () {},
              ),
            ),
          ],
        ),
        _buildNewArrivalSection(),
        _buildTopSellingSection(),
      ],
    );
  }

  Widget _buildNewArrivalSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New Arrival',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          _products.map((product) {
                            return SizedBox(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ProductCard(
                                  product: product,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductDetailsPage(
                                              product: product,
                                            ),
                                      ),
                                    );
                                  },
                                  onAddToCart: () {
                                    // Navigate to product details to select options
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductDetailsPage(
                                              product: product,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 350,
            child: PromoBanner(
              title: 'Weekend Sale',
              subtitle: 'NEW ARRIVALS',
              description: 'Collection',
              buttonText: 'SHOP NOW',
              imageUrl:
                  'https://images.unsplash.com/photo-1507537417841-81691e121aa6?w=400',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSellingSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Selling Items',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    _products.map((product) {
                      return SizedBox(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ProductCard(
                            product: product,
                            onTap: () {
                              // Navigate to product detail
                            },
                            onAddToCart: () {
                              // Add to cart
                            },
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          const SizedBox(height: 48),
          _buildNewsletterSection(),
          _buildFooterSection(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection() {
    final TextEditingController emailController = TextEditingController();

    return Container(
      color: const Color(0xFFE53935),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Icon(Icons.email_outlined, color: Colors.white, size: 48),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SUBSCRIBE TO OUR NEWSLETTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Get all the latest information on Events, Sales and Offers.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 40),
            SizedBox(
              width: 400,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Your E-mail Address',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF212121),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 22,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    'SUBSCRIBE',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterSection() {
    return Container(
      color: const Color(0xFFE0E0E0),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/fig_logo.png',
                      height: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 80,
                          width: 300,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text(
                              'FIG FASHION\nINTERNATIONAL GROUP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'FIG is a leading fashion multinational retail Company present in Egypt, which operates across a uniquely wide range of sectors, and Fashion Categories.',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        _buildSocialButton(Icons.facebook, Colors.blue[900]!),
                        const SizedBox(width: 16),
                        _buildSocialButton(Icons.camera_alt, Colors.grey[800]!),
                        const SizedBox(width: 16),
                        _buildSocialButton(Icons.tiktok, Colors.grey[800]!),
                        const SizedBox(width: 16),
                        _buildSocialButton(Icons.work, Colors.blue[700]!),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 80),
              Expanded(
                child: _buildFooterColumn('COMPANY', [
                  'Store Location',
                  'Contact Us',
                  'About Us',
                ]),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: _buildFooterColumn('MY ACCOUNT', [
                  'Track My Order',
                  'View Cart',
                  'Sign In',
                  'My Wishlist',
                  'Support',
                ]),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: _buildFooterColumn('CUSTOMER SERVICE', [
                  'Return And Exchange Policy',
                  'Data & Privacy Notice',
                ]),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[600]!, width: 2),
              ),
              child: IconButton(
                onPressed: () {
                  // Scroll to top
                },
                icon: const Icon(Icons.keyboard_arrow_up),
                color: Colors.white,
                iconSize: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 20,
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 20),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {},
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: const Color(0xFFC0C0C0),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Copyright © 2025 FIG. All Rights Reserved.',
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
          ),
          Row(
            children: [
              Text(
                'We\'re using safe payment for',
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
              const SizedBox(width: 16),
              _buildPaymentIcon('assets/images/maestro.png'),
              const SizedBox(width: 8),
              _buildPaymentIcon('assets/images/discover.png'),
              const SizedBox(width: 8),
              _buildPaymentIcon('assets/images/visa.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.asset(
        assetPath,
        height: 24,
        width: 40,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 24,
            width: 40,
            color: Colors.grey[300],
            child: const Icon(Icons.credit_card, size: 16),
          );
        },
      ),
    );
  }
}

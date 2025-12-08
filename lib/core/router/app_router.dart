import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/category/presentation/pages/category_page.dart';
import '../../features/brand/presentation/pages/brand_page.dart';
import '../../features/product/presentation/pages/product_page.dart';
import '../../features/product_details/presentation/pages/product_details_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/product/domain/entities/product.dart';
import '../../features/product/data/models/product_model.dart';

class AppRouter {
  static const String home = '/';
  static const String categories = '/categories';
  static const String brands = '/brands';
  static const String products = '/products';
  static const String productDetails = '/products/:id';
  static const String cart = '/cart';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder:
            (context, state) => _buildPageWithTransition(
              context: context,
              state: state,
              child: const MainPage(),
            ),
      ),
      GoRoute(
        path: categories,
        name: 'categories',
        pageBuilder:
            (context, state) => _buildPageWithTransition(
              context: context,
              state: state,
              child: const CategoryPage(),
            ),
      ),
      GoRoute(
        path: brands,
        name: 'brands',
        pageBuilder:
            (context, state) => _buildPageWithTransition(
              context: context,
              state: state,
              child: const BrandPage(),
            ),
      ),
      GoRoute(
        path: products,
        name: 'products',
        pageBuilder:
            (context, state) => _buildPageWithTransition(
              context: context,
              state: state,
              child: const ProductPage(),
            ),
      ),
      GoRoute(
        path: productDetails,
        name: 'product-details',
        pageBuilder: (context, state) {
          Product? product;

          // Handle case where extra might be a Product object
          if (state.extra is Product) {
            product = state.extra as Product;
          }
          // Handle case where extra might be a Map (JSON) due to serialization
          else if (state.extra is Map<String, dynamic>) {
            try {
              product = ProductModel.fromJson(
                state.extra as Map<String, dynamic>,
              );
            } catch (e) {
              // If deserialization fails, product remains null
              debugPrint('Error deserializing product: $e');
            }
          }

          if (product == null) {
            // If no product is passed, redirect to products page
            return _buildPageWithTransition(
              context: context,
              state: state,
              child: const ProductPage(),
            );
          }
          return _buildPageWithTransition(
            context: context,
            state: state,
            child: ProductDetailsPage(product: product),
          );
        },
      ),
      GoRoute(
        path: cart,
        name: 'cart',
        pageBuilder:
            (context, state) => _buildPageWithTransition(
              context: context,
              state: state,
              child: const CartPage(),
            ),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  '404 - Page Not Found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'The page "${state.uri}" does not exist.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go(home),
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        ),
  );

  // Helper method to build page with custom transition
  static Page _buildPageWithTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    // For web, use fade transition
    // For mobile, use platform default
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade transition for smooth navigation on all platforms
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  // Helper methods for navigation
  static void goToHome(BuildContext context) {
    context.go(home);
  }

  static void goToCategories(BuildContext context) {
    context.go(categories);
  }

  static void goToBrands(BuildContext context) {
    context.go(brands);
  }

  static void goToProducts(BuildContext context) {
    context.go(products);
  }

  static void goToProductDetails(BuildContext context, Product product) {
    context.go(productDetails, extra: product);
  }

  static void goToCart(BuildContext context) {
    context.go(cart);
  }
}

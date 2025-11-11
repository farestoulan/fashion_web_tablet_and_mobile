import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../widgets/bottom_nav_bar.dart';
import '../../../home/presentation/pages/adaptive_home_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  // Pages for each tab
  final List<Widget> _pages = [
    const AdaptiveHomePage(), // Changed to use AdaptiveHomePage
    const _PlaceholderPage(title: 'Categories'),
    const _PlaceholderPage(title: 'My Basket'),
    const _PlaceholderPage(title: 'Favourites'),
    const _PlaceholderPage(title: 'Profile'),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      // Only show bottom navigation on mobile devices
      bottomNavigationBar:
          isMobile
              ? AppBottomNavBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
              )
              : null,
    );
  }
}

// Placeholder page for other tabs
class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming soon...',
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      child: Column(
        children: [
          // Newsletter Section
          _buildNewsletterSection(context, isMobile),
          // Main Footer Content
          _buildMainContent(context, isMobile),
          // Bottom Footer
          _buildBottomFooter(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection(BuildContext context, bool isMobile) {
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      width: double.infinity,
      color: AppColors.secondary,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: isMobile ? 16 : 24,
      ),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'SUBSCRIBE TO OUR NEWSLETTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Get E-mail updates about our latest shop and special offers.',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  _buildEmailInput(isMobile),
                ],
              )
              : isTablet
              ? Row(
                children: [
                  const Icon(Icons.email, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SUBSCRIBE TO OUR NEWSLETTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Get E-mail updates about our latest shop and special offers.',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(width: 300, child: _buildEmailInput(isMobile)),
                ],
              )
              : Row(
                children: [
                  const Icon(Icons.email, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  const Text(
                    'SUBSCRIBE TO OUR NEWSLETTER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Get E-mail updates about our latest shop and special offers.',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const Spacer(),
                  SizedBox(width: 300, child: _buildEmailInput(isMobile)),
                ],
              ),
    );
  }

  Widget _buildEmailInput(bool isMobile) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText:
                    isMobile
                        ? 'Enter Your Email...'
                        : 'Enter Your Email Address...',
                hintStyle: TextStyle(
                  fontSize: isMobile ? 12 : 13,
                  color: Colors.grey[500],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Center(
              child: Text(
                'SUBSCRIBE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 48,
        horizontal: isMobile ? 16 : 24,
      ),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFooterLogo(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  const SizedBox(height: 20),
                  _buildSocialIcons(),
                  const SizedBox(height: 32),
                  _buildFooterSection('COMPANY', [
                    'About Us',
                    'Contact Us',
                    'About Us',
                  ]),
                  const SizedBox(height: 24),
                  _buildFooterSection('MY ACCOUNT', [
                    'My Account',
                    'View Cart',
                    'Wish List',
                    'My Wishlist',
                    'Search',
                  ]),
                  const SizedBox(height: 24),
                  _buildFooterSection('CUSTOMER SERVICE', [
                    'Shipping & Delivery',
                    'Track My Order',
                    'Size & Fit Policy',
                  ]),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFooterLogo(),
                        const SizedBox(height: 16),
                        _buildDescription(),
                        const SizedBox(height: 20),
                        _buildSocialIcons(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48),
                  Expanded(
                    child: _buildFooterSection('COMPANY', [
                      'About Us',
                      'Contact Us',
                      'About Us',
                    ]),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildFooterSection('MY ACCOUNT', [
                      'My Account',
                      'View Cart',
                      'Wish List',
                      'My Wishlist',
                      'Search',
                    ]),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: _buildFooterSection('CUSTOMER SERVICE', [
                      'Shipping & Delivery',
                      'Track My Order',
                      'Size & Fit Policy',
                    ]),
                  ),
                ],
              ),
    );
  }

  Widget _buildBottomFooter(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[400]!, width: 1)),
      ),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Copyright © 2025. All rights Reserved.',
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'We\'re using safe payment for',
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 8),
                      _buildPaymentIcon(),
                      const SizedBox(width: 6),
                      _buildPaymentIcon(),
                      const SizedBox(width: 6),
                      _buildPaymentIcon(),
                    ],
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Copyright © 2025. All rights Reserved.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  Row(
                    children: [
                      Text(
                        'We\'re using safe payment for',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 12),
                      _buildPaymentIcon(),
                      const SizedBox(width: 8),
                      _buildPaymentIcon(),
                      const SizedBox(width: 8),
                      _buildPaymentIcon(),
                    ],
                  ),
                ],
              ),
    );
  }

  Widget _buildFooterLogo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              'F',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FASHION',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'INTERNATIONAL GROUP',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.6),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 8),
        _buildSocialIcon(Icons.close),
        const SizedBox(width: 8),
        _buildSocialIcon(Icons.camera_alt),
        const SizedBox(width: 8),
        _buildSocialIcon(Icons.play_circle),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildFooterSection(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => _buildFooterLink(link)),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {},
        child: Text(
          text,
          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
        ),
      ),
    );
  }

  Widget _buildPaymentIcon() {
    return Container(
      width: 40,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Icon(Icons.credit_card, size: 16, color: Colors.grey[600]),
      ),
    );
  }
}

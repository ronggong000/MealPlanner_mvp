import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/basket/basket_screen.dart';
import '../screens/cook/cook_screen.dart';
import '../screens/shopping/shopping_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../theme/app_colors.dart';

/// Main navigation component with bottom navigation bar
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BasketScreen(),
    const CookScreen(),
    const ShoppingScreen(),
    const SettingsScreen(),
  ];
  
  /// Builds a navigation icon with the correct color based on selection state
  Widget _buildNavIcon(String assetPath, int index) {
    return SvgPicture.asset(
      assetPath,
      colorFilter: ColorFilter.mode(
        _selectedIndex == index 
            ? AppColors.navigationSelected 
            : AppColors.navigationUnselected,
        BlendMode.srcIn,
      ),
      height: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundWhite,
          selectedItemColor: AppColors.navigationSelected,
          unselectedItemColor: AppColors.navigationUnselected,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon('assets/icons/basket_tab_icon.svg', 0),
              label: 'Basket',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon('assets/icons/cook_tab_icon.svg', 1),
              label: 'Cook',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon('assets/icons/cart_tab_icon.svg', 2),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
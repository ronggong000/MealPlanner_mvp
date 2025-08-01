import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/basket/basket_detail_screen.dart';
import '../screens/basket/basket_screen.dart';
import '../screens/cook/cook_screen.dart';
import '../screens/meal_planning/meal_planning_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/shopping/shopping_screen.dart';
import '../screens/shopping/product_detail_screen.dart';
import '../screens/shopping/receipt_screen.dart';
import '../screens/shopping/cart_screen.dart';
import '../widgets/main_navigation.dart';
import '../screens/settings/preferences_screen.dart';

/// App router configuration
class AppRouter {
  /// Routes configuration
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const MainNavigation(),
    '/basket': (context) => const BasketScreen(),
    '/basket/detail': (context) => BasketDetailScreen(categoryName: 'Default Category'),
    '/cook': (context) => const CookScreen(),
    '/shopping': (context) => const ShoppingScreen(),
    '/shopping/receipt': (context) => ReceiptScreen(orderData: {}),
    '/settings': (context) => const SettingsScreen(),
    '/meal-planning': (context) => const MealPlanningScreen(),
    '/cart': (context) => const CartScreen(),
  };

  /// Navigate to product detail screen
  static void navigateToProductDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }
}
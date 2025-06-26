import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/meal_planning/meal_planning_screen.dart';
import '../screens/meal_planning/recipe_detail_screen.dart';
import '../screens/meal_planning/preference_collection_screen.dart';
import '../screens/meal_planning/new_meals_screen.dart';
import '../screens/shopping/shopping_screen.dart';
import '../screens/shopping/product_detail_screen.dart';
import '../screens/shopping/cart_screen.dart';
import '../screens/shopping/receipt_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../widgets/main_navigation.dart';

/// Application router configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/meal-planning',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigation(child: child);
        },
        routes: [
          // Meal planning routes
          GoRoute(
            path: '/meal-planning',
            name: 'meal-planning',
            builder: (context, state) => const MealPlanningScreen(),
          ),
          
          // Shopping routes
          GoRoute(
            path: '/shopping',
            name: 'shopping',
            builder: (context, state) => const ShoppingScreen(),
          ),
          
          // Settings routes
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      
      // Pages that don't need bottom navigation bar
      GoRoute(
        path: '/recipe-detail/:recipeId',
        name: 'recipe-detail',
        builder: (context, state) {
          final recipeId = state.pathParameters['recipeId']!;
          return RecipeDetailScreen(recipeId: recipeId);
        },
      ),
      
      GoRoute(
        path: '/preference-collection',
        name: 'preference-collection',
        builder: (context, state) => const PreferenceCollectionScreen(),
      ),
      
      GoRoute(
        path: '/new-meals',
        name: 'new-meals',
        builder: (context, state) => const NewMealsScreen(),
      ),
      
      GoRoute(
        path: '/product-detail/:productId',
        name: 'product-detail',
        builder: (context, state) {
          final productId = state.pathParameters['productId']!;
          return ProductDetailScreen(productId: productId);
        },
      ),
      
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      
      GoRoute(
        path: '/receipt',
        name: 'receipt',
        builder: (context, state) {
          final orderData = state.extra as Map<String, dynamic>? ?? {};
          return ReceiptScreen(orderData: orderData);
        },
      ),
    ],
  );
}
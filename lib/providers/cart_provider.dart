import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

/// Shopping cart state
class CartState {
  final List<CartItem> items;
  
  const CartState({this.items = const []});
  
  /// Get total number of items in cart
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  
  /// Get total price of all items in cart
  double get totalPrice => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  
  /// Check if cart is empty
  bool get isEmpty => items.isEmpty;
  
  /// Create a copy with updated items
  CartState copyWith({List<CartItem>? items}) {
    return CartState(
      items: items ?? this.items,
    );
  }
}

/// Shopping cart state notifier
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());
  
  /// Add product to cart
  void addToCart(Product product, {int quantity = 1}) {
    final items = List<CartItem>.from(state.items);
    final existingIndex = items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      // Update existing item quantity
      final existingItem = items[existingIndex];
      items[existingIndex] = CartItem(
        id: existingItem.id,
        product: existingItem.product,
        quantity: existingItem.quantity + quantity,
        addedAt: existingItem.addedAt,
      );
    } else {
      // Add new item
      items.add(CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        product: product,
        quantity: quantity,
        addedAt: DateTime.now(),
      ));
    }
    
    state = state.copyWith(items: items);
  }
  
  /// Update item quantity
  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(itemId);
      return;
    }
    
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final item = items[index];
      items[index] = CartItem(
        id: item.id,
        product: item.product,
        quantity: newQuantity,
        addedAt: item.addedAt,
      );
      state = state.copyWith(items: items);
    }
  }
  
  /// Remove item from cart
  void removeFromCart(String itemId) {
    final items = state.items.where((item) => item.id != itemId).toList();
    state = state.copyWith(items: items);
  }
  
  /// Clear all items from cart
  void clearCart() {
    state = const CartState();
  }
  
  /// Get cart item by product id
  CartItem? getCartItemByProductId(String productId) {
    try {
      return state.items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }
}

/// Cart provider
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
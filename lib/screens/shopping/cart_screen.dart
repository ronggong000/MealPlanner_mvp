import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_colors.dart';

/// Shopping cart page
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryButtonBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (cartState.items.isNotEmpty)
            TextButton(
              onPressed: () => _clearCart(context, cartNotifier),
              child: const Text(
                'Clear',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
      body: cartState.isEmpty
          ? _buildEmptyCart(context)
          : _buildCartContent(cartState, cartNotifier),
      bottomNavigationBar: cartState.items.isNotEmpty ? _buildBottomBar(context, cartState) : null,
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add some products to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.go('/shopping'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButtonBackground,
              foregroundColor: AppColors.primaryButtonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
            child: const Text(
              'Go Shopping',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(CartState cartState, CartNotifier cartNotifier) {
    return Column(
      children: [
        // Delivery info
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.cardShadow,
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.primaryButtonBackground,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery to',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.subtitleText,
                      ),
                    ),
                    Text(
                      '123 Main Street, Sydney NSW 2000',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.titleText,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement address change
                },
                child: const Text(
                  'Change',
                  style: TextStyle(
                    color: AppColors.primaryButtonBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Cart items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cartState.items.length,
            itemBuilder: (context, index) {
              return _buildCartItemCard(cartState.items[index], cartNotifier);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCartItemCard(CartItem item, CartNotifier cartNotifier) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 80,
                height: 80,
                color: AppColors.backgroundPink,
                child: item.product.imageUrl.isNotEmpty
                    ? Image.network(
                        item.product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_basket,
                            color: AppColors.subtitleText,
                            size: 40,
                          );
                        },
                      )
                    : const Icon(
                        Icons.shopping_basket,
                        color: AppColors.subtitleText,
                        size: 40,
                      ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '¥${item.product.price.toStringAsFixed(1)}/${item.product.unit}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.subtitleText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Quantity control and price
                  Row(
                    children: [
                      // Quantity control
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.subtitleText),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () => cartNotifier.updateQuantity(item.id, item.quantity - 1),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: AppColors.subtitleText,
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.titleText,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => cartNotifier.updateQuantity(item.id, item.quantity + 1),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: AppColors.primaryButtonBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Subtotal price
                      Text(
                        '¥${item.totalPrice.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryButtonBackground,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Delete button
            IconButton(
              onPressed: () => cartNotifier.removeFromCart(item.id),
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.primaryButtonBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionSection(BuildContext context) {
    return Container(
      color: AppColors.backgroundWhite,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Coupons
          Row(
            children: [
              const Icon(
                Icons.local_offer_outlined,
                color: AppColors.primaryButtonBackground,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Coupons',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleText,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coupon feature coming soon')),
                  );
                },
                child: const Text(
                    'Select Coupon >',
                    style: TextStyle(
                      color: AppColors.primaryButtonBackground,
                  ),
                ),
              ),
            ],
          ),
          
          const Divider(),
          
          // Delivery info
          Row(
            children: [
              const Icon(
                Icons.local_shipping_outlined,
                color: AppColors.primaryButtonBackground,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Delivery',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleText,
                ),
              ),
              const Spacer(),
              const Text(
                'Free delivery',
                style: TextStyle(
                  color: AppColors.primaryButtonBackground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, CartState cartState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.subtitleText.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleText,
                  ),
                ),
                Text(
                  '¥${cartState.totalPrice.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryButtonBackground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _checkout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButtonBackground,
                  foregroundColor: AppColors.primaryButtonText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _clearCart(BuildContext context, CartNotifier cartNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Clear Cart',
          style: TextStyle(color: AppColors.titleText),
        ),
        content: const Text(
          'Are you sure you want to clear the cart?',
          style: TextStyle(color: AppColors.subtitleText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.subtitleText),
            ),
          ),
          TextButton(
            onPressed: () {
              cartNotifier.clearCart();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: AppColors.primaryButtonBackground),
            ),
          ),
        ],
      ),
    );
  }

  void _checkout(BuildContext context) {
    // TODO: Implement checkout logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checkout feature coming soon'),
        backgroundColor: AppColors.primaryButtonBackground,
      ),
    );
  }
}
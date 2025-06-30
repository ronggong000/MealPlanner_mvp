import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';
import '../../theme/app_colors.dart';

/// Receipt page
class ReceiptScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const ReceiptScreen({super.key, required this.orderData});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  String _orderId = '';
  final DateTime _orderTime = DateTime.now();
  List<CartItem> _cartItems = [];
  double _totalPrice = 0.0;
  double _deliveryFee = 0.0;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    // Parse order data
    _parseOrderData();
    
    // Start animation
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  void _parseOrderData() {
    _cartItems = List<CartItem>.from(widget.orderData['cartItems'] ?? []);
    _totalPrice = widget.orderData['totalPrice'] ?? 0.0;
    _deliveryFee = widget.orderData['deliveryFee'] ?? 0.0;
    
    // Generate order number
    _orderId = 'MP${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
  }
  
  double get _finalTotal => _totalPrice + _deliveryFee;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: AppColors.primaryButtonText,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryButtonBackground,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.primaryButtonText),
          onPressed: () {
            // Return to shopping page
            context.go('/shopping');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.primaryButtonText),
            onPressed: _shareReceipt,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Success status card
                    _buildSuccessCard(),
                    const SizedBox(height: 16),
                    
                    // Order info card
                    _buildOrderInfoCard(),
                    const SizedBox(height: 16),
                    
                    // Product list card
                    _buildItemsCard(),
                    const SizedBox(height: 16),
                    
                    // Cost breakdown card
                    _buildPriceBreakdownCard(),
                    const SizedBox(height: 16),
                    
                    // Delivery info card
                    _buildDeliveryInfoCard(),
                    const SizedBox(height: 32),
                    
                    // Bottom buttons
                    _buildBottomButtons(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildSuccessCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppColors.primaryButtonBackground, AppColors.primaryButtonBackground.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryButtonText.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 50,
                color: AppColors.primaryButtonText,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryButtonText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We will deliver your order soon',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryButtonText.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Order Number', _orderId),
            const SizedBox(height: 12),
            _buildInfoRow('Order Time', _formatDateTime(_orderTime)),
            const SizedBox(height: 12),
            _buildInfoRow('Order Status', 'Confirmed', valueColor: AppColors.primaryButtonBackground),
            const SizedBox(height: 12),
            _buildInfoRow('Estimated Delivery', _getEstimatedDelivery()),
          ],
        ),
      ),
    );
  }
  
  Widget _buildItemsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product List (${_cartItems.length} items)',
              style: const TextStyle(
                color: AppColors.titleText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._cartItems.map((item) => _buildItemRow(item)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildItemRow(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.grey[200],
              child: item.product.imageUrl.isNotEmpty
                  ? Image.network(
                      item.product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.shopping_basket,
                          color: Colors.grey,
                          size: 25,
                        );
                      },
                    )
                  : const Icon(
                      Icons.shopping_basket,
                      color: Colors.grey,
                      size: 25,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '¥${item.product.price.toStringAsFixed(1)}/${item.product.unit}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.subtitleText,
                  ),
                ),
              ],
            ),
          ),
          
          // Quantity and subtotal
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'x${item.quantity}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.subtitleText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '¥${item.totalPrice.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryButtonBackground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildPriceBreakdownCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cost Breakdown',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
            const SizedBox(height: 16),
            _buildPriceRow('Subtotal', '¥${_totalPrice.toStringAsFixed(1)}'),
            const SizedBox(height: 8),
            _buildPriceRow('Delivery Fee', _deliveryFee > 0 ? '¥${_deliveryFee.toStringAsFixed(1)}' : 'Free'),
            const SizedBox(height: 8),
            _buildPriceRow('Coupon', '-¥0.0', valueColor: AppColors.primaryButtonBackground),
            const Divider(height: 24),
            _buildPriceRow(
              'Total Amount',
              '¥${_finalTotal.toStringAsFixed(1)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDeliveryInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primaryButtonBackground,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe 138****5678',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleText,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '123 Main Street, Anytown, USA',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.subtitleText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: AppColors.primaryButtonBackground,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Estimated delivery: ${_getEstimatedDelivery()}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomButtons() {
    return Column(
      children: [
        // Continue shopping button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.go('/shopping');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 2,
            ),
            child: const Text(
              'Continue Shopping',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // View orders button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order management feature coming soon')),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryButtonBackground),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'View My Orders',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryButtonBackground,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.subtitleText,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: valueColor ?? AppColors.titleText,
          ),
        ),
      ],
    );
  }
  
  Widget _buildPriceRow(String label, String value, {bool isTotal = false, Color? valueColor}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.titleText : AppColors.subtitleText,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: valueColor ?? (isTotal ? AppColors.primaryButtonBackground : AppColors.titleText),
          ),
        ),
      ],
    );
  }
  
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
  
  String _getEstimatedDelivery() {
    final estimatedTime = _orderTime.add(const Duration(hours: 2));
    return '${estimatedTime.hour.toString().padLeft(2, '0')}:${estimatedTime.minute.toString().padLeft(2, '0')}';
  }
  
  void _shareReceipt() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share feature coming soon'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
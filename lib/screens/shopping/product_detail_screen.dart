import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/product.dart';
import '../../data/sample_data.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_colors.dart';

/// Product detail page
class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _quantity = 1;
  Product? _product;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    setState(() {
      _product = SampleData.getProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product Details',
            style: TextStyle(color: AppColors.primaryButtonText),
          ),
          backgroundColor: AppColors.primaryButtonBackground,
        ),
        body: const Center(
          child: Text(
            'Product not found',
            style: TextStyle(color: AppColors.titleText),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Top image and navigation
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primaryButtonBackground,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryButtonText),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: AppColors.primaryButtonText),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share feature coming soon')),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.cardBackground,
                child: _product!.imageUrl.isNotEmpty
                    ? Image.network(
                        _product!.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.subtitleText.withOpacity(0.2),
                            child: const Icon(
                              Icons.shopping_basket,
                              size: 80,
                              color: AppColors.subtitleText,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: AppColors.subtitleText.withOpacity(0.2),
                        child: const Icon(
                          Icons.shopping_basket,
                          size: 80,
                          color: AppColors.subtitleText,
                        ),
                      ),
              ),
            ),
          ),
          
          // Product information
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic info card
                  _buildBasicInfoCard(),
                  const SizedBox(height: 16),
                  
                  // Product description
                  _buildDescriptionCard(),
                  const SizedBox(height: 16),
                  
                  // Nutrition info (if available)
                  if (_product!.nutritionInfo != null)
                    _buildNutritionCard(),
                  
                  const SizedBox(height: 100), // Space for bottom buttons
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/cart');
        },
        backgroundColor: AppColors.primaryButtonBackground,
        child: const Icon(
          Icons.shopping_cart,
          color: AppColors.primaryButtonText,
        ),
      ),
    );
  }

  Widget _buildBasicInfoCard() {
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
              _product!.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '¥${_product!.price.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryButtonBackground,
                  ),
                ),
                Text(
                  '/${_product!.unit}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.subtitleText,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _product!.isAvailable
                        ? AppColors.primaryButtonBackground.withOpacity(0.1)
                        : AppColors.errorText.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _product!.isAvailable ? 'In Stock' : 'Out of Stock',
                    style: TextStyle(
                      fontSize: 12,
                      color: _product!.isAvailable
                          ? AppColors.primaryButtonBackground
                          : AppColors.errorText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Quantity selection
            Row(
              children: [
                const Text(
                  'Quantity:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleText,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.subtitleText.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: _quantity > 1
                            ? () {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                        iconSize: 20,
                      ),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.titleText,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _quantity < 99
                            ? () {
                                setState(() {
                                  _quantity++;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.add),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Subtotal
            Row(
              children: [
                const Text(
                  'Subtotal:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  '¥${(_product!.price * _quantity).toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryButtonBackground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
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
              'Product Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _product!.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.subtitleText,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionCard() {
    final nutrition = _product!.nutritionInfo!;
    
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
              'Nutrition Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
            const SizedBox(height: 12),
            ...nutrition.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(
                    '${entry.key}：',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.subtitleText,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${entry.value}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleText,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.subtitleText.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Favorite button
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Favorite feature coming soon'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite_border,
              color: AppColors.primaryButtonBackground,
            ),
            label: const Text(
              'Favorite',
              style: TextStyle(
                color: AppColors.primaryButtonBackground,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryButtonBackground),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Add to cart button
          Expanded(
            child: ElevatedButton(
              onPressed: _product!.isAvailable ? _addToCart : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButtonBackground,
                foregroundColor: AppColors.primaryButtonText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 2,
              ),
              child: Text(
                _product!.isAvailable ? 'Add to Cart' : 'Out of Stock',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    final cartNotifier = ref.read(cartProvider.notifier);
    cartNotifier.addToCart(_product!, quantity: _quantity);
    
    // Show simple success message without action buttons
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_product!.name} x$_quantity added to cart'),
        backgroundColor: AppColors.primaryButtonBackground,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
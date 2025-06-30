import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/basket_item.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';

class BasketDetailScreen extends ConsumerStatefulWidget {
  final String categoryName;

  const BasketDetailScreen({
    super.key,
    required this.categoryName,
  });

  @override
  ConsumerState<BasketDetailScreen> createState() => _BasketDetailScreenState();
}

class _BasketDetailScreenState extends ConsumerState<BasketDetailScreen> {
  int _selectedDays = 3;
  int _selectedServings = 2;

  void _addToCart() {
    final basketDetail = freshFromFarmDetail;
    
    // Convert basket items to products and add to cart
    for (var item in basketDetail.items) {
      final product = Product(
        id: item.name.toLowerCase().replaceAll(' ', '_'),
        name: item.name,
        description: 'Fresh ${item.name} from the basket',
        price: item.price,
        imageUrl: 'assets/images/veggie_curry.jpg', // Default image
        category: widget.categoryName,
        unit: item.weight,
        isAvailable: true,
      );
      
      // Add to cart with quantity 1
      ref.read(cartProvider.notifier).addToCart(product, quantity: 1);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Basket items added to cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final basketDetail = freshFromFarmDetail;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Basket Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.categoryName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: basketDetail.items.length,
              itemBuilder: (context, index) {
                final item = basketDetail.items[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.food_bank, color: Colors.white),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.weight,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${basketDetail.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildSelectionSection(
              title: 'Day',
              value: _selectedDays,
              onDecrease: () {
                if (_selectedDays > 1) {
                  setState(() => _selectedDays--);
                }
              },
              onIncrease: () {
                setState(() => _selectedDays++);
              },
            ),
            _buildSelectionSection(
              title: 'Serve',
              value: _selectedServings,
              onDecrease: () {
                if (_selectedServings > 1) {
                  setState(() => _selectedServings--);
                }
              },
              onIncrease: () {
                setState(() => _selectedServings++);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recommend Recipes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: basketDetail.recommendedRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = basketDetail.recommendedRecipes[index];
                        return Card(
                          margin: const EdgeInsets.only(right: 16),
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    recipe.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    recipe.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _addToCart,
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionSection({
    required String title,
    required int value,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onDecrease,
                color: Colors.grey[700],
              ),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: onIncrease,
                color: Colors.grey[700],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import '../../models/basket_category.dart';
import '../../theme/app_colors.dart';
import 'basket_detail_screen.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Basket',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // TODO: Implement add functionality
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: sampleBasketCategories.length,
        itemBuilder: (context, index) {
          final category = sampleBasketCategories[index];
          return _buildCategoryCard(context, category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, BasketCategory category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BasketDetailScreen(
              categoryName: category.name,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            Image.asset(
              category.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Placeholder for when image fails to load
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    category.isSpecialOffer ? Icons.local_offer : Icons.restaurant,
                    size: 48,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
            // Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      category.isSpecialOffer
                          ? Colors.orange.withOpacity(0.8)
                          : Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            // Category name
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Special offer overlay
            if (category.isSpecialOffer)
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.9),
                ),
                child: const Center(
                  child: Text(
                    'SPECIAL\nOFFERS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
} 
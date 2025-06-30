import 'package:flutter/material.dart';

class BasketCategory {
  final String name;
  final String imageUrl;
  final bool isSpecialOffer;

  BasketCategory({
    required this.name,
    required this.imageUrl,
    this.isSpecialOffer = false,
  });
}

// Sample data with local images
final List<BasketCategory> sampleBasketCategories = [
  BasketCategory(
    name: 'Fresh From Farm',
    imageUrl: 'assets/images/fresh_from_farm.jpg',
  ),
  BasketCategory(
    name: 'Melbourne Combo',
    imageUrl: 'assets/images/melbourne_combo.jpg',
  ),
  BasketCategory(
    name: 'Vegan',
    imageUrl: 'assets/images/vegan.jpg',
  ),
  BasketCategory(
    name: 'Meat Lover',
    imageUrl: 'assets/images/meat_lover.jpg',
  ),
  BasketCategory(
    name: 'Fruit Major',
    imageUrl: 'assets/images/fruit_major.jpg',
  ),
  BasketCategory(
    name: 'Fish and Fresh',
    imageUrl: 'assets/images/fish_and_fresh.jpg',
  ),
  BasketCategory(
    name: 'Italian',
    imageUrl: 'assets/images/italian.jpg',
  ),
  BasketCategory(
    name: 'Special Offers',
    imageUrl: 'assets/images/special_offers.jpg',
    isSpecialOffer: true,
  ),
]; 
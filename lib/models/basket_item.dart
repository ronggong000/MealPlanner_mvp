class BasketItem {
  final String name;
  final String weight;
  final double price;

  BasketItem({
    required this.name,
    required this.weight,
    required this.price,
  });
}

class BasketDetail {
  final String categoryName;
  final List<BasketItem> items;
  final double totalPrice;
  final List<Recipe> recommendedRecipes;

  BasketDetail({
    required this.categoryName,
    required this.items,
    required this.totalPrice,
    required this.recommendedRecipes,
  });
}

class Recipe {
  final String name;
  final String imageUrl;

  Recipe({
    required this.name,
    required this.imageUrl,
  });
}

// Sample data
final freshFromFarmDetail = BasketDetail(
  categoryName: 'Fresh From Farm',
  items: [
    BasketItem(name: 'Organic Carrots', weight: '500g', price: 3.5),
    BasketItem(name: 'Organic Cucumber', weight: '500g', price: 2.5),
    BasketItem(name: 'Organic Chili', weight: '200g', price: 1.5),
    BasketItem(name: 'Organic Pumpkin', weight: '1500g', price: 5.0),
    BasketItem(name: 'Organic Eggs', weight: '12', price: 6.0),
    BasketItem(name: 'Organic Cauliflower', weight: '500g', price: 4.0),
    BasketItem(name: 'Organic Rice', weight: '500g', price: 3.0),
    BasketItem(name: 'Organic Strawberries', weight: '200g', price: 4.0),
  ],
  totalPrice: 29.5,
  recommendedRecipes: [
    Recipe(
      name: 'Pumpkin Stew',
      imageUrl: 'assets/images/pumkin_strew.jpg',
    ),
    Recipe(
      name: 'Veggie Curry',
      imageUrl: 'assets/images/veggie_curry.jpg',
    ),
  ],
); 
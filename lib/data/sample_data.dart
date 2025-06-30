import '../models/recipe.dart';
import '../models/meal.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../models/inventory_item.dart';

/// Sample data class providing test data
class SampleData {
  // Sample recipe data
  static final List<Recipe> _sampleRecipes = [
    Recipe(
      id: '1',
      name: 'Tomato Egg Noodles',
      description: 'Classic Chinese noodles, nutritious and easy to make',
      imageUrl: 'assets/images/tomato_egg_noodles.jpg',
      ingredients: ['Noodles 200g', 'Eggs 2', 'Tomatoes 2', 'Green onion 1', 'Salt to taste', 'Sugar 1 tsp', 'Soy sauce 1 tbsp'],
      instructions: 'Cut tomatoes into chunks, slice green onions. Heat oil in pan, scramble eggs and set aside. Stir-fry tomatoes until juicy. Add seasonings and stir well. Cook noodles until tender. Mix noodles with stir-fried tomato and eggs.',
      cookingTime: '15 minutes',
      servings: 2,
      portions: 2,
      difficulty: 'easy',
      tags: ['Chinese', 'Noodles', 'Quick meal'],
    ),
    Recipe(
      id: '2',
      name: 'Steamed Egg Custard',
      description: 'Silky steamed egg, perfect for breakfast',
      imageUrl: 'assets/images/steamed_egg_custard.jpg',
      ingredients: ['Eggs 3', 'Warm water 150ml', 'Salt pinch', 'Sesame oil few drops', 'Chopped green onions to taste'],
      instructions: 'Beat eggs, add warm water and salt. Strain to remove foam. Steam after water boils. Steam on medium heat for 10-12 minutes. Garnish with green onions and sesame oil.',
      cookingTime: '20 minutes',
      servings: 2,
      portions: 2,
      difficulty: 'easy',
      tags: ['Steamed', 'Breakfast', 'Nutritious'],
    ),
    Recipe(
      id: '3',
      name: 'Kung Pao Chicken',
      description: 'Classic Sichuan dish, spicy and flavorful',
      imageUrl: 'assets/images/kung_pao_chicken.jpg',
      ingredients: [
        'Chicken breast 300g', 'Peanuts 50g', 'Dried chilies 10', 'Sichuan peppercorns 1 tsp',
        'Green onions 2', 'Ginger 1 piece', 'Garlic 3 cloves', 'Light soy sauce 2 tbsp', 'Dark soy sauce 1 tsp',
        'Cooking wine 1 tbsp', 'Sugar 1 tsp', 'Vinegar 1 tsp', 'Cornstarch 1 tbsp'
      ],
      instructions: 'Dice chicken, marinate with wine, soy sauce, and cornstarch. Deep fry peanuts until crispy. Stir-fry dried chilies and peppercorns. Add chicken and stir-fry until color changes. Add seasonings and stir well. Finally add peanuts and stir-fry.',
      cookingTime: '25 minutes',
      servings: 3,
      portions: 3,
      difficulty: 'medium',
      tags: ['Sichuan', 'Main dish', 'Spicy'],
    ),
    Recipe(
      id: '4',
      name: 'Millet Porridge',
      description: 'Nourishing and gentle millet porridge',
      imageUrl: 'assets/images/millet_porridge.jpg',
      ingredients: ['Millet 100g', 'Water 1000ml', 'Red dates 5', 'Goji berries to taste'],
      instructions: 'Rinse millet clean. Boil water in pot. Add millet, bring to boil then reduce heat. Cook for 30 minutes until thick. Add dates and goji berries, cook 5 more minutes.',
      cookingTime: '40 minutes',
      servings: 2,
      portions: 2,
      difficulty: 'easy',
      tags: ['Porridge', 'Stomach-friendly', 'Breakfast'],
    ),
    Recipe(
      id: '5',
      name: 'Braised Pork Belly',
      description: 'Classic braised pork belly, rich but not greasy',
      imageUrl: 'assets/images/braised_pork_belly.jpg',
      ingredients: [
        'Pork belly 500g', 'Rock sugar 30g', 'Light soy sauce 3 tbsp', 'Dark soy sauce 1 tbsp',
        'Cooking wine 2 tbsp', 'Green onions 2', 'Ginger 3 slices', 'Star anise 2', 'Cinnamon 1 piece'
      ],
      instructions: 'Cut pork belly into chunks, blanch to remove odor. Caramelize rock sugar in pot. Add pork and stir-fry until colored. Add seasonings and spices. Add water to cover meat. Bring to boil then simmer for 1 hour. Reduce sauce on high heat.',
      cookingTime: '90 minutes',
      servings: 4,
      portions: 4,
      difficulty: 'medium',
      tags: ['Braised', 'Main dish', 'Classic'],
    ),
    Recipe(
      id: '1',
      name: 'Avocado Toast with Egg',
      ingredients: ['Avocado', 'Egg', 'Toast'],
      instructions: 'Toast the bread, Mash the avocado, Cook the egg',
      servings: 1,
      portions: 1,
      imageUrl: 'assets/images/avocado_toast.jpg',
      description: 'A delicious breakfast recipe',
      cookingTime: '10 minutes',
      difficulty: 'easy',
      tags: ['breakfast', 'healthy'],
    ),
    Recipe(
      id: '2',
      name: 'Quinoa Salad with Vegetables',
      ingredients: ['Quinoa', 'Vegetables', 'Olive Oil'],
      instructions: 'Cook the quinoa, Mix with vegetables, Drizzle with olive oil',
      servings: 2,
      portions: 2,
      imageUrl: 'assets/images/quinoa_salad.jpg',
      description: 'A nutritious and delicious salad',
      cookingTime: '30 minutes',
      difficulty: 'medium',
      tags: ['salad', 'healthy'],
    ),
    Recipe(
      id: '3',
      name: 'Salmon with Roasted Vegetables',
      ingredients: ['Salmon', 'Vegetables', 'Lemon'],
      instructions: 'Roast the vegetables, Bake the salmon, Serve with lemon',
      servings: 2,
      portions: 2,
      imageUrl: 'assets/images/salmon_roasted.jpg',
      description: 'A healthy and flavorful meal',
      cookingTime: '45 minutes',
      difficulty: 'hard',
      tags: ['dinner', 'healthy'],
    ),
  ];

  /// Get all sample recipes
  static List<Recipe> get recipes => List.unmodifiable(_sampleRecipes);

  /// Get recipe by ID
  static Recipe? getRecipeById(String id) {
    try {
      return _sampleRecipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get meal plan for specified date
  static List<Meal> getMealsForDay(DateTime day) {
    // For demo purposes, only provide sample data for today and tomorrow
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    
    if (_isSameDay(day, today)) {
      return [
        Meal(
          id: 'meal-1',
          type: MealType.breakfast,
          date: day,
          recipes: [_sampleRecipes[1], _sampleRecipes[3]], // Steamed Egg Custard, Millet Porridge
        ),
        Meal(
          id: 'meal-2',
          type: MealType.lunch,
          date: day,
          recipes: [_sampleRecipes[0], _sampleRecipes[2]], // Tomato Egg Noodles, Kung Pao Chicken
        ),
        Meal(
          id: 'meal-3',
          type: MealType.dinner,
          date: day,
          recipes: [_sampleRecipes[4]], // Braised Pork Belly
        ),
      ];
    } else if (_isSameDay(day, tomorrow)) {
      return [
        Meal(
          id: 'meal-4',
          type: MealType.breakfast,
          date: day,
          recipes: [_sampleRecipes[3]], // Millet Porridge
        ),
        Meal(
          id: 'meal-5',
          type: MealType.lunch,
          date: day,
          recipes: [_sampleRecipes[2]], // Kung Pao Chicken
        ),
      ];
    }
    
    return [];
  }

  /// Check if two dates are the same day
  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Sample delivery address
  static final DeliveryAddress sampleAddress = DeliveryAddress(
    id: 'addr-1',
    name: 'John Smith',
    address: '123 Sample Street, Chaoyang District',
    city: 'Beijing',
    postalCode: '100000',
    phone: '13800138000',
    isDefault: true,
  );

  // Sample inventory items
  static final List<InventoryItem> sampleInventoryItems = [
    InventoryItem(
      id: '1',
      name: 'Tomatoes',
      weight: '500g',
      imageUrl: 'assets/images/veggie_curry.jpg',
    ),
    InventoryItem(
      id: '2',
      name: 'Chicken Breast',
      weight: '1kg',
      imageUrl: 'assets/images/chicken_breast.jpg',
    ),
    InventoryItem(
      id: '3',
      name: 'Salmon',
      weight: '500g',
      imageUrl: 'assets/images/salmon.jpg',
    ),
    InventoryItem(
      id: '4',
      name: 'Ground Beef',
      weight: '300g',
      imageUrl: 'assets/images/ground_beef.jpg',
    ),
    InventoryItem(
      id: '5',
      name: 'Tofu',
      weight: '300g',
      imageUrl: 'assets/images/tofu.jpg',
    ),
    InventoryItem(
      id: '6',
      name: 'Shrimp',
      weight: '300g',
      imageUrl: 'assets/images/shrimp.jpg',
    ),
  ];

  /// Sample product data
  static final List<Product> sampleProducts = [
    Product(
      id: 'chicken_breast',
      name: 'Chicken Breast',
      description: 'Fresh, boneless chicken breast.',
      price: 8.0,
      imageUrl: 'assets/images/chicken_breast.jpg',
      category: 'Meat & Seafood',
      unit: '500g',
      isAvailable: true,
    ),
    Product(
      id: 'ground_beef',
      name: 'Ground Beef',
      description: 'Fresh ground beef, perfect for burgers and meatballs.',
      price: 7.0,
      imageUrl: 'assets/images/ground_beef.jpg',
      category: 'Meat & Seafood',
      unit: '300g',
      isAvailable: true,
    ),
    Product(
      id: 'salmon',
      name: 'Fresh Salmon',
      description: 'Fresh Atlantic salmon fillet.',
      price: 12.0,
      imageUrl: 'assets/images/salmon.jpg',
      category: 'Meat & Seafood',
      unit: '400g',
      isAvailable: true,
    ),
  ];

  /// Sample recipes
  static final List<Recipe> sampleFavoriteRecipes = [
    Recipe(
      id: '1',
      name: 'Braised Duck',
      description: 'Traditional braised duck with rich sauce',
      imageUrl: 'assets/images/duck.jpg',
      ingredients: ['Duck', 'Soy Sauce', 'Ginger', 'Green Onion'],
      instructions: 'Clean the duck, prepare the sauce, braise for 1 hour',
      servings: 4,
      portions: 4,
      cookingTime: '60 minutes',
      difficulty: 'medium',
      tags: ['Braised', 'Main dish', 'Classic'],
    ),
    Recipe(
      id: '2',
      name: 'Grilled Lamb Chops',
      description: 'Juicy grilled lamb chops with herbs',
      imageUrl: 'assets/images/lamb.jpg',
      ingredients: ['Lamb Chops', 'Rosemary', 'Garlic', 'Olive Oil'],
      instructions: 'Marinate the lamb, heat the grill, cook to desired doneness',
      servings: 2,
      portions: 2,
      cookingTime: '30 minutes',
      difficulty: 'medium',
      tags: ['Grilled', 'Main dish', 'Quick'],
    ),
    Recipe(
      id: '3',
      name: 'Shrimp Scampi',
      description: 'Classic shrimp scampi with garlic and white wine',
      imageUrl: 'assets/images/shrimp.jpg',
      ingredients: ['Shrimp', 'Garlic', 'White Wine', 'Butter'],
      instructions: 'Sauté garlic, cook shrimp, add wine, finish with butter',
      servings: 2,
      portions: 2,
      cookingTime: '20 minutes',
      difficulty: 'easy',
      tags: ['Seafood', 'Quick', 'Italian'],
    ),
  ];

  /// Sample meat recipes
  final List<Recipe> sampleMeatRecipes = [
    Recipe(
      id: '6',
      name: 'Classic Roast Chicken',
      description: 'Perfectly roasted chicken with herbs',
      imageUrl: 'assets/images/chicken_breast.jpg',
      ingredients: ['Whole Chicken', 'Herbs', 'Butter', 'Garlic'],
      instructions: 'Season chicken, stuff with herbs, roast until golden',
      servings: 4,
      portions: 4,
      cookingTime: '90 minutes',
      difficulty: 'medium',
      tags: ['Roasted', 'Main dish', 'Classic'],
    ),
    Recipe(
      id: '7',
      name: 'Grilled Salmon',
      description: 'Fresh salmon fillet grilled to perfection',
      imageUrl: 'assets/images/salmon.jpg',
      ingredients: ['Salmon Fillet', 'Lemon', 'Dill', 'Olive Oil'],
      instructions: 'Season salmon, grill skin side down first, flip once',
      servings: 2,
      portions: 2,
      cookingTime: '15 minutes',
      difficulty: 'easy',
      tags: ['Seafood', 'Healthy', 'Quick'],
    ),
  ];

  /// Sample vegetarian recipes
  final List<Recipe> sampleVegetarianRecipes = [
    Recipe(
      id: '8',
      name: 'Vegetable Curry',
      description: 'Rich and spicy vegetable curry',
      imageUrl: 'assets/images/veggie_curry.jpg',
      ingredients: ['Mixed Vegetables', 'Coconut Milk', 'Curry Paste', 'Rice'],
      instructions: 'Sauté vegetables, add curry paste and coconut milk, simmer',
      servings: 4,
      portions: 4,
      cookingTime: '45 minutes',
      difficulty: 'medium',
      tags: ['Vegetarian', 'Spicy', 'Asian'],
    ),
    Recipe(
      id: '9',
      name: 'Quinoa Buddha Bowl',
      description: 'Healthy bowl with quinoa and roasted vegetables',
      imageUrl: 'assets/images/quinoa_salad.jpg',
      ingredients: ['Quinoa', 'Roasted Vegetables', 'Avocado', 'Tahini'],
      instructions: 'Cook quinoa, roast vegetables, assemble bowl, drizzle sauce',
      servings: 2,
      portions: 2,
      cookingTime: '40 minutes',
      difficulty: 'easy',
      tags: ['Vegetarian', 'Healthy', 'Bowl'],
    ),
  ];

  /// Sample products
  final List<Product> sampleProduceProducts = [
    Product(
      id: 'organic_pumpkin',
      name: 'Organic Pumpkin',
      description: 'Fresh organic pumpkin, perfect for soups, pies, and roasting. High in vitamins and minerals.',
      price: 5.0,
      imageUrl: 'assets/images/pumpkin.jpg',
      category: 'Produce',
      unit: '1500g',
      isAvailable: true,
    ),
    Product(
      id: 'organic_eggs',
      name: 'Organic Eggs',
      description: 'Farm-fresh organic eggs from free-range chickens. Rich in protein and omega-3.',
      price: 6.0,
      imageUrl: 'assets/images/eggs.jpg',
      category: 'Produce',
      unit: '12 pcs',
      isAvailable: true,
    ),
  ];

  /// Sample meat products
  final List<Product> sampleMeatProducts = [];

  /// Sample dairy products
  final List<Product> sampleDairyProducts = [];

  /// Sample pantry products
  final List<Product> samplePantryProducts = [];

  /// Sample frozen products
  final List<Product> sampleFrozenProducts = [];

  /// Sample beverage products
  final List<Product> sampleBeverageProducts = [];

  /// Sample snack products
  final List<Product> sampleSnackProducts = [];

  /// Sample bakery products
  final List<Product> sampleBakeryProducts = [];

  /// Get all inventory items
  static List<InventoryItem> get inventoryItems => List.unmodifiable(sampleInventoryItems);

  /// Get inventory item by ID
  static InventoryItem? getInventoryItemById(String id) {
    try {
      return sampleInventoryItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all products
  static List<Product> get products => List.unmodifiable(sampleProducts);

  /// Get product by ID
  static Product? getProductById(String id) {
    try {
      return sampleProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
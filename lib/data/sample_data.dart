import '../models/recipe.dart';
import '../models/meal.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

/// Sample data class providing test data
class SampleData {
  // Sample recipe data
  static final List<Recipe> _sampleRecipes = [
    Recipe(
      id: '1',
      name: 'Tomato Egg Noodles',
      description: 'Classic Chinese noodles, nutritious and easy to make',
      imageUrl: 'https://example.com/tomato-egg-noodles.jpg',
      ingredients: ['Noodles 200g', 'Eggs 2', 'Tomatoes 2', 'Green onion 1', 'Salt to taste', 'Sugar 1 tsp', 'Soy sauce 1 tbsp'],
      instructions: [
        'Cut tomatoes into chunks, slice green onions',
        'Heat oil in pan, scramble eggs and set aside',
        'Stir-fry tomatoes until juicy',
        'Add seasonings and stir well',
        'Cook noodles until tender',
        'Mix noodles with stir-fried tomato and eggs'
      ],
      cookingTime: 15,
      servings: 2,
      difficulty: 'easy',
      tags: ['Chinese', 'Noodles', 'Quick meal'],
    ),
    Recipe(
      id: '2',
      name: 'Steamed Egg Custard',
      description: 'Silky steamed egg, perfect for breakfast',
      imageUrl: 'https://example.com/steamed-egg.jpg',
      ingredients: ['Eggs 3', 'Warm water 150ml', 'Salt pinch', 'Sesame oil few drops', 'Chopped green onions to taste'],
      instructions: [
        'Beat eggs, add warm water and salt',
        'Strain to remove foam',
        'Steam after water boils',
        'Steam on medium heat for 10-12 minutes',
        'Garnish with green onions and sesame oil'
      ],
      cookingTime: 20,
      servings: 2,
      difficulty: 'easy',
      tags: ['Steamed', 'Breakfast', 'Nutritious'],
    ),
    Recipe(
      id: '3',
      name: 'Kung Pao Chicken',
      description: 'Classic Sichuan dish, spicy and flavorful',
      imageUrl: 'https://example.com/kung-pao-chicken.jpg',
      ingredients: [
        'Chicken breast 300g', 'Peanuts 50g', 'Dried chilies 10', 'Sichuan peppercorns 1 tsp',
        'Green onions 2', 'Ginger 1 piece', 'Garlic 3 cloves', 'Light soy sauce 2 tbsp', 'Dark soy sauce 1 tsp',
        'Cooking wine 1 tbsp', 'Sugar 1 tsp', 'Vinegar 1 tsp', 'Cornstarch 1 tbsp'
      ],
      instructions: [
        'Dice chicken, marinate with wine, soy sauce, and cornstarch',
        'Deep fry peanuts until crispy',
        'Stir-fry dried chilies and peppercorns',
        'Add chicken and stir-fry until color changes',
        'Add seasonings and stir well',
        'Finally add peanuts and stir-fry'
      ],
      cookingTime: 25,
      servings: 3,
      difficulty: 'medium',
      tags: ['Sichuan', 'Main dish', 'Spicy'],
    ),
    Recipe(
      id: '4',
      name: 'Millet Porridge',
      description: 'Nourishing and gentle millet porridge',
      imageUrl: 'https://example.com/millet-porridge.jpg',
      ingredients: ['Millet 100g', 'Water 1000ml', 'Red dates 5', 'Goji berries to taste'],
      instructions: [
        'Rinse millet clean',
        'Boil water in pot',
        'Add millet, bring to boil then reduce heat',
        'Cook for 30 minutes until thick',
        'Add dates and goji berries, cook 5 more minutes'
      ],
      cookingTime: 40,
      servings: 2,
      difficulty: 'easy',
      tags: ['Porridge', 'Stomach-friendly', 'Breakfast'],
    ),
    Recipe(
      id: '5',
      name: 'Braised Pork Belly',
      description: 'Classic braised pork belly, rich but not greasy',
      imageUrl: 'https://example.com/braised-pork.jpg',
      ingredients: [
        'Pork belly 500g', 'Rock sugar 30g', 'Light soy sauce 3 tbsp', 'Dark soy sauce 1 tbsp',
        'Cooking wine 2 tbsp', 'Green onions 2', 'Ginger 3 slices', 'Star anise 2', 'Cinnamon 1 piece'
      ],
      instructions: [
        'Cut pork belly into chunks, blanch to remove odor',
        'Caramelize rock sugar in pot',
        'Add pork and stir-fry until colored',
        'Add seasonings and spices',
        'Add water to cover meat',
        'Bring to boil then simmer for 1 hour',
        'Reduce sauce on high heat'
      ],
      cookingTime: 90,
      servings: 4,
      difficulty: 'medium',
      tags: ['Braised', 'Main dish', 'Classic'],
    ),
  ];

  // Sample product category data
  static final List<ProductCategory> _sampleCategories = [
    ProductCategory(
      id: 'vegetables',
      name: 'Vegetables',
      products: [
        Product(
          id: 'tomato',
          name: 'Tomato',
          description: 'Fresh red tomatoes, sweet and tangy',
          imageUrl: 'https://example.com/tomato.jpg',
          price: 8.5,
          unit: 'kg',
          categoryId: 'vegetables',
        ),
        Product(
          id: 'onion',
          name: 'Onion',
          description: 'Quality onions, essential for cooking',
          imageUrl: 'https://example.com/onion.jpg',
          price: 6.0,
          unit: 'kg',
          categoryId: 'vegetables',
        ),
      ],
    ),
    ProductCategory(
      id: 'meat',
      name: 'Meat',
      products: [
        Product(
          id: 'chicken-breast',
          name: 'Chicken Breast',
          description: 'Fresh chicken breast, high protein and low fat',
          imageUrl: 'https://example.com/chicken-breast.jpg',
          price: 25.0,
          unit: 'kg',
          categoryId: 'meat',
        ),
        Product(
          id: 'pork-belly',
          name: 'Pork Belly',
          description: 'Quality pork belly, well-marbled',
          imageUrl: 'https://example.com/pork-belly.jpg',
          price: 32.0,
          unit: 'kg',
          categoryId: 'meat',
        ),
      ],
    ),
    ProductCategory(
      id: 'grains',
      name: 'Grains',
      products: [
        Product(
          id: 'rice',
          name: 'Rice',
          description: 'Premium northeast rice, plump grains',
          imageUrl: 'https://example.com/rice.jpg',
          price: 12.0,
          unit: 'kg',
          categoryId: 'grains',
        ),
        Product(
          id: 'noodles',
          name: 'Noodles',
          description: 'Hand-pulled noodles, chewy texture',
          imageUrl: 'https://example.com/noodles.jpg',
          price: 8.0,
          unit: 'kg',
          categoryId: 'grains',
        ),
      ],
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

  /// Get all product categories
  static List<ProductCategory> get productCategories => List.unmodifiable(_sampleCategories);

  /// Get product by ID
  static Product? getProductById(String id) {
    for (final category in _sampleCategories) {
      try {
        return category.products.firstWhere((product) => product.id == id);
      } catch (e) {
        continue;
      }
    }
    return null;
  }

  /// Get all products
  static List<Product> get allProducts {
    final List<Product> products = [];
    for (final category in _sampleCategories) {
      products.addAll(category.products);
    }
    return products;
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
}
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
  final List<InventoryItem> sampleInventoryItems = [
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
  ];

  // Sample recipes
  final List<Recipe> sampleFavoriteRecipes = [
    Recipe(
      id: '1',
      name: 'Avocado Toast with Eggs',
      description: 'A healthy and delicious breakfast featuring creamy avocado and perfectly cooked eggs on toasted bread.',
      servings: 2,
      cookingTime: 15,
      imageUrl: 'assets/images/avocado_toast.jpg',
      ingredients: [
        'Bread',
        'Avocado',
        'Eggs',
        'Salt',
        'Pepper',
        'Olive oil',
      ],
      instructions: [
        'Toast the bread until golden brown',
        'Mash the avocado and season with salt and pepper',
        'Spread the mashed avocado on the toast',
        'Cook the eggs to your liking and place on top',
        'Drizzle with olive oil and serve',
      ],
      difficulty: 'Easy',
      tags: ['Breakfast', 'Healthy', 'Vegetarian'],
    ),
    Recipe(
      id: '2',
      name: 'Quinoa Salad',
      description: 'A refreshing salad made with quinoa, fresh vegetables, and a light vinaigrette dressing.',
      servings: 4,
      cookingTime: 25,
      imageUrl: 'assets/images/quinoa_salad.jpg',
      ingredients: [
        'Quinoa',
        'Cherry tomatoes',
        'Cucumber',
        'Red onion',
        'Olive oil',
        'Lemon juice',
        'Fresh herbs',
      ],
      instructions: [
        'Cook quinoa according to package instructions',
        'Chop all vegetables into bite-sized pieces',
        'Mix cooked quinoa with vegetables',
        'Whisk together olive oil and lemon juice',
        'Pour dressing over salad and toss',
        'Add fresh herbs and serve',
      ],
      difficulty: 'Medium',
      tags: ['Salad', 'Healthy', 'Vegetarian', 'Gluten-free'],
    ),
    Recipe(
      id: '3',
      name: 'Veggie Curry',
      description: 'A flavorful vegetarian curry packed with seasonal vegetables and aromatic spices.',
      servings: 4,
      cookingTime: 30,
      imageUrl: 'assets/images/veggie_curry.jpg',
      ingredients: [
        'Mixed vegetables',
        'Coconut milk',
        'Curry powder',
        'Onion',
        'Garlic',
        'Ginger',
        'Rice',
      ],
      instructions: [
        'Cook rice according to package instructions',
        'Sauté onion, garlic, and ginger until fragrant',
        'Add curry powder and cook for 1 minute',
        'Add vegetables and coconut milk',
        'Simmer until vegetables are tender',
        'Serve hot over rice',
      ],
      difficulty: 'Medium',
      tags: ['Curry', 'Vegetarian', 'Spicy', 'Asian'],
    ),
  ];

  // Sample products
  final List<Product> sampleProducts = [
    Product(
      id: '1',
      name: 'Fresh Tomatoes',
      description: 'Ripe and juicy tomatoes, perfect for salads or cooking',
      price: 2.99,
      imageUrl: 'assets/images/veggie_curry.jpg',
      category: 'Produce',
      unit: 'lb',
    ),
    Product(
      id: '2',
      name: 'Onions',
      description: 'Fresh onions, essential for many dishes',
      price: 1.99,
      imageUrl: 'assets/images/fresh_from_farm.jpg',
      category: 'Produce',
      unit: 'lb',
    ),
    Product(
      id: '3',
      name: 'Chicken Breast',
      description: 'Boneless, skinless chicken breast, high in protein',
      price: 8.99,
      imageUrl: 'assets/images/chicken_breast.jpg',
      category: 'Meat & Seafood',
      unit: 'lb',
    ),
    Product(
      id: '4',
      name: 'Pork Belly',
      description: 'Fresh pork belly, perfect for braising',
      price: 7.99,
      imageUrl: 'assets/images/pork.jpg',
      category: 'Meat & Seafood',
      unit: 'lb',
    ),
  ];

  /// Sample product data
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
}
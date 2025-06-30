/// Recipe model class representing a recipe
class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final int cookingTime; // minutes
  final int servings;
  final String difficulty; // 'easy', 'medium', 'hard'
  final List<String> tags;
  final bool isFavorite;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.cookingTime,
    required this.servings,
    required this.difficulty,
    required this.tags,
    this.isFavorite = false,
  });

  /// Create Recipe instance from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      instructions: List<String>.from(json['instructions'] as List),
      cookingTime: json['cookingTime'] as int,
      servings: json['servings'] as int,
      difficulty: json['difficulty'] as String,
      tags: List<String>.from(json['tags'] as List),
      isFavorite: json['isFavorite'] as bool,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'instructions': instructions,
      'cookingTime': cookingTime,
      'servings': servings,
      'difficulty': difficulty,
      'tags': tags,
      'isFavorite': isFavorite,
    };
  }

  /// Copy and modify Recipe
  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? ingredients,
    List<String>? instructions,
    int? cookingTime,
    int? servings,
    String? difficulty,
    List<String>? tags,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      cookingTime: cookingTime ?? this.cookingTime,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recipe && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Sample data for favorite recipes
final List<Recipe> sampleFavoriteRecipes = [
  Recipe(
    id: '1',
    name: 'Avocado Toast with Egg',
    description: 'A delicious breakfast recipe',
    imageUrl: 'assets/images/avocado_toast.jpg',
    ingredients: ['Avocado', 'Egg', 'Toast'],
    instructions: ['Toast the bread', 'Mash the avocado', 'Cook the egg'],
    cookingTime: 10,
    servings: 1,
    difficulty: 'easy',
    tags: ['breakfast', 'healthy'],
    isFavorite: true,
  ),
  Recipe(
    id: '2',
    name: 'Quinoa Salad with Vegetables',
    description: 'A nutritious and delicious salad',
    imageUrl: 'assets/images/quinoa_salad.jpg',
    ingredients: ['Quinoa', 'Vegetables', 'Olive Oil'],
    instructions: ['Cook the quinoa', 'Mix with vegetables', 'Drizzle with olive oil'],
    cookingTime: 30,
    servings: 2,
    difficulty: 'medium',
    tags: ['salad', 'healthy'],
    isFavorite: true,
  ),
  Recipe(
    id: '3',
    name: 'Salmon with Roasted Vegetables',
    description: 'A healthy and flavorful meal',
    imageUrl: 'assets/images/salmon_roasted.jpg',
    ingredients: ['Salmon', 'Vegetables', 'Lemon'],
    instructions: ['Roast the vegetables', 'Bake the salmon', 'Serve with lemon'],
    cookingTime: 45,
    servings: 2,
    difficulty: 'hard',
    tags: ['dinner', 'healthy'],
    isFavorite: true,
  ),
];
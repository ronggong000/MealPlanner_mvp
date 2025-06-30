/// Recipe model class representing a recipe
class Recipe {
  final String id;
  final String name;
  final List<String> ingredients;
  final String instructions;
  final String? imageUrl;
  final String? description;
  final int servings;
  final int portions;
  final String? cookingTime;
  final String? difficulty;
  final List<String>? tags;
  final bool isFavorite;

  const Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.servings,
    required this.portions,
    this.imageUrl,
    this.description,
    this.cookingTime,
    this.difficulty,
    this.tags,
    this.isFavorite = false,
  });

  /// Create Recipe instance from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      ingredients: (json['ingredients'] as List<dynamic>).map((e) => e as String).toList(),
      instructions: json['instructions'] as String,
      servings: json['servings'] as int,
      portions: json['portions'] as int,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      cookingTime: json['cookingTime'] as String?,
      difficulty: json['difficulty'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'description': description,
      'servings': servings,
      'portions': portions,
      'cookingTime': cookingTime,
      'difficulty': difficulty,
      'tags': tags,
      'isFavorite': isFavorite,
    };
  }

  /// Copy and modify Recipe
  Recipe copyWith({
    String? id,
    String? name,
    List<String>? ingredients,
    String? instructions,
    String? imageUrl,
    String? description,
    int? servings,
    int? portions,
    String? cookingTime,
    String? difficulty,
    List<String>? tags,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      servings: servings ?? this.servings,
      portions: portions ?? this.portions,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      cookingTime: cookingTime ?? this.cookingTime,
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
    ingredients: ['Avocado', 'Egg', 'Toast'],
    instructions: 'Toast the bread, Mash the avocado, Cook the egg',
    servings: 1,
    portions: 1,
    imageUrl: 'assets/images/avocado_toast.jpg',
    description: 'A delicious breakfast recipe',
    cookingTime: '10 minutes',
    difficulty: 'easy',
    tags: ['breakfast', 'healthy'],
    isFavorite: true,
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
    isFavorite: true,
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
    isFavorite: true,
  ),
];
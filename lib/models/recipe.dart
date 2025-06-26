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
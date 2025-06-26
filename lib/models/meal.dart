import 'recipe.dart';

/// Meal type enumeration
enum MealType {
  breakfast('Breakfast'),
  lunch('Lunch'),
  dinner('Dinner'),
  snack('Snack');

  const MealType(this.displayName);
  final String displayName;
}

/// Meal model class representing a meal
class Meal {
  final String id;
  final MealType type;
  final DateTime date;
  final List<Recipe> recipes;
  final bool isCompleted;

  const Meal({
    required this.id,
    required this.type,
    required this.date,
    required this.recipes,
    this.isCompleted = false,
  });

  /// Create Meal instance from JSON
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as String,
      type: MealType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MealType.breakfast,
      ),
      date: DateTime.parse(json['date'] as String),
      recipes: (json['recipes'] as List)
          .map((recipeJson) => Recipe.fromJson(recipeJson as Map<String, dynamic>))
          .toList(),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'date': date.toIso8601String(),
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
      'isCompleted': isCompleted,
    };
  }

  /// Copy and modify Meal
  Meal copyWith({
    String? id,
    MealType? type,
    DateTime? date,
    List<Recipe>? recipes,
    bool? isCompleted,
  }) {
    return Meal(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
      recipes: recipes ?? this.recipes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Meal && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
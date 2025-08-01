import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe.dart';
import '../data/sample_data.dart';

class RecipesNotifier extends StateNotifier<List<Recipe>> {
  RecipesNotifier() : super(List.from(SampleData.recipes.take(2)));

  void addRecipe(Recipe recipe) {
    // 只要 id 或 name 已存在则不再添加
    if (state.any((r) => r.id == recipe.id || r.name == recipe.name)) return;
    state = [...state, recipe];
  }

  void removeRecipe(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
  }
}

final recipesProvider = StateNotifierProvider<RecipesNotifier, List<Recipe>>(
  (ref) => RecipesNotifier(),
); 
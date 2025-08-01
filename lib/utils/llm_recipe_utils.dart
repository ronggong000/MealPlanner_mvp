import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/inventory_item.dart';

Future<Recipe> generateSingleRecipe({
  required List<InventoryItem> inventoryItems,
  required int servings,
  required String prompt,
  required BuildContext context,
  int? mealIndex,
  int? totalMeals,
  List<String>? usedNames,
  List<String>? usedIngredients,
}) async {
  final apiKey = 'AIzaSyA9EuOrtOjAhbVUyj5Hh6by-KLTA_G_wtM';
  final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');
  final inventoryText = inventoryItems.map((e) => '- ${e.name} ${e.weight}').join('\n');
  String mealPrompt = '''You are an intelligent recipe assistant. The user has the following ingredients at home:\n$inventoryText\nThe user wants to cook for $servings people. Additional requirements: $prompt\n''';
  if (mealIndex != null && totalMeals != null) {
    if (mealIndex == 0) {
      mealPrompt += 'You need to generate $totalMeals different recipes. Now please generate the 1st recipe.';
    } else {
      mealPrompt += 'You need to generate $totalMeals different recipes. Now please generate the ${mealIndex + 1}th recipe. Recipes already generated: ${usedNames?.join(', ') ?? ''}. Ingredients already used: ${usedIngredients?.join(', ') ?? ''}. Please avoid duplicate recipe names and overusing the same ingredients.';
    }
  }
  mealPrompt += '\nReturn the following JSON format:\n{\n  "name": "Recipe Name",\n  "ingredients": ["Ingredient1", "Ingredient2"],\n  "instructions": "Steps",\n  "description": "One sentence description",\n  "cookingTime": "30 minutes",\n  "difficulty": "easy/medium/hard",\n  "imageUrl": "Optional image url"\n}\nOnly return JSON, no extra text.';
  final body = {
    "contents": [
      {
        "parts": [
          {"text": mealPrompt}
        ]
      }
    ]
  };
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final text = data['candidates'][0]['content']['parts'][0]['text'];
    final jsonStart = text.indexOf('{');
    final jsonEnd = text.lastIndexOf('}') + 1;
    if (jsonStart == -1 || jsonEnd == -1) throw Exception('LLM returned content format error');
    final jsonText = text.substring(jsonStart, jsonEnd);
    final recipeData = jsonDecode(jsonText);
    final recipe = Recipe(
      id: DateTime.now().toString(),
      name: recipeData['name'] ?? '',
      ingredients: List<String>.from(recipeData['ingredients'] ?? []),
      instructions: recipeData['instructions'] ?? '',
      servings: servings,
      portions: servings,
      description: recipeData['description'] ?? '',
      cookingTime: recipeData['cookingTime'] ?? '',
      difficulty: recipeData['difficulty'] ?? '',
      imageUrl: recipeData['imageUrl'],
    );
    return recipe;
  } else {
    throw Exception('Request failed: ${response.statusCode}');
  }
} 
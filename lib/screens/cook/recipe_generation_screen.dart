import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/recipe.dart';

class RecipeGenerationScreen extends StatefulWidget {
  const RecipeGenerationScreen({super.key});

  @override
  State<RecipeGenerationScreen> createState() => _RecipeGenerationScreenState();
}

class _RecipeGenerationScreenState extends State<RecipeGenerationScreen> {
  int servings = 2;
  int portions = 1;
  bool isLoading = false;
  Recipe? generatedRecipe;
  String? errorMessage;

  Future<void> generateRecipe() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      const apiKey = 'AIzaSyDqzKbKy70uUyhBOPllc888nhatfX-eZ_4';
      final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');

      final prompt = {
        "contents": [
          {
            "parts": [
              {
                "text": """I have the following ingredients:
- Chicken Breast 500g
- Ground Beef 300g
- Salmon 400g
- Tofu 300g
- Shrimp 300g
- Pork 400g
- Lamb 500g
- Duck 500g
- Turkey 500g

Please create a recipe for $servings people with $portions serving(s) using any of these ingredients.

Return ONLY a JSON object in the following format, with no additional text before or after:
{
  "name": "Dish name",
  "ingredients": ["ingredient1", "ingredient2"],
  "instructions": "Step-by-step instructions"
}

The response must be a valid JSON object with exactly these three fields."""
              }
            ]
          }
        ]
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(prompt),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        
        // Clean up the text to ensure it contains only the JSON part
        final jsonStart = text.indexOf('{');
        final jsonEnd = text.lastIndexOf('}') + 1;
        if (jsonStart == -1 || jsonEnd == -1) {
          throw FormatException('Response does not contain valid JSON');
        }
        
        final jsonText = text.substring(jsonStart, jsonEnd);
        final recipeData = jsonDecode(jsonText);
        
        if (!recipeData.containsKey('name') || 
            !recipeData.containsKey('ingredients') || 
            !recipeData.containsKey('instructions')) {
          throw FormatException('Response JSON is missing required fields');
        }
        
        setState(() {
          generatedRecipe = Recipe(
            id: DateTime.now().toString(),
            name: recipeData['name'],
            ingredients: List<String>.from(recipeData['ingredients']),
            instructions: recipeData['instructions'],
            servings: servings,
            portions: portions,
          );
        });
      } else {
        setState(() {
          errorMessage = 'Failed to generate recipe. Status code: ${response.statusCode}. Response: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Recipe'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recipe Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Number of People'),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: servings > 1
                                        ? () => setState(() => servings--)
                                        : null,
                                  ),
                                  Text('$servings'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => setState(() => servings++),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Number of Portions'),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: portions > 1
                                        ? () => setState(() => portions--)
                                        : null,
                                  ),
                                  Text('$portions'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => setState(() => portions++),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : generateRecipe,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[100],
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Generate Recipe'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (generatedRecipe != null) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              generatedRecipe!.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.save),
                            onPressed: () {
                              // Save recipe and return to cook screen
                              Navigator.pop(context, generatedRecipe);
                            },
                            tooltip: 'Save Recipe',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Ingredients:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...generatedRecipe!.ingredients.map((ingredient) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text('• $ingredient'),
                          )),
                      const SizedBox(height: 16),
                      const Text(
                        'Instructions:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(generatedRecipe!.instructions),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 
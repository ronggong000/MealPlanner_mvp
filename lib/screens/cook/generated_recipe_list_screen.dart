import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import 'recipe_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/recipes_provider.dart';
import 'dart:async'; // Added for Timer
import '../../utils/llm_recipe_utils.dart';

class GeneratedRecipeListScreen extends StatefulWidget {
  final List<Recipe> recipes;
  const GeneratedRecipeListScreen({super.key, required this.recipes});

  @override
  State<GeneratedRecipeListScreen> createState() => _GeneratedRecipeListScreenState();
}

class _GeneratedRecipeListScreenState extends State<GeneratedRecipeListScreen> {
  final Set<String> _marked = {};
  bool _isLoading = false; // Added for loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generated Recipes')),
      body: ListView.builder(
        itemCount: widget.recipes.length,
        itemBuilder: (context, index) {
          final recipe = widget.recipes[index];
          final isMarked = _marked.contains(recipe.id);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(recipe.description ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isMarked ? Icons.remove_circle : Icons.remove_circle_outline,
                      color: isMarked ? Colors.red : Colors.grey,
                    ),
                    tooltip: isMarked ? 'Unmark' : 'Mark for Regenerate',
                    onPressed: () {
                      setState(() {
                        if (isMarked) {
                          _marked.remove(recipe.id);
                        } else {
                          _marked.add(recipe.id);
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(
                            recipe: recipe,
                            isGenerated: true,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: Text('Regenerate ( ${_marked.length})'),
                onPressed: _marked.isNotEmpty ? _regenerateMarkedRecipes : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save All'),
                onPressed: () {
                  final toSave = widget.recipes.where((r) => !_marked.contains(r.id)).toList();
                  if (toSave.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No recipes to save!'), backgroundColor: Colors.orange),
                    );
                    return;
                  }
                  final container = ProviderScope.containerOf(context, listen: false);
                  final notifier = container.read(recipesProvider.notifier);
                  for (final recipe in toSave) {
                    notifier.addRecipe(recipe);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(' ${toSave.length} recipes saved!'), backgroundColor: Colors.green),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _regenerateMarkedRecipes() async {
    if (_marked.isEmpty) return;
    setState(() { _isLoading = true; });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Regenerating...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    Timer? timer = Timer(const Duration(seconds: 30), () {
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      setState(() { _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Regenerate timeout'), backgroundColor: Colors.red),
      );
    });
    try {
      for (int i = 0; i < widget.recipes.length; i++) {
        final recipe = widget.recipes[i];
        if (_marked.contains(recipe.id)) {
          try {
            final newRecipe = await generateSingleRecipe(
              inventoryItems: [], // TODO: 传递真实 inventoryItems
              servings: recipe.servings,
              prompt: '', // TODO: 传递真实 prompt
              context: context,
            );
            setState(() {
              widget.recipes[i] = newRecipe;
            });
          } catch (e) {
            // 失败时保留原有
          }
        }
      }
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      timer.cancel();
      setState(() {
        _isLoading = false;
        _marked.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Regenerate finished!'), backgroundColor: Colors.green),
      );
    } catch (e) {
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      timer.cancel();
      setState(() { _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Regenerate failed: $e'), backgroundColor: Colors.red),
      );
    }
  }
} 
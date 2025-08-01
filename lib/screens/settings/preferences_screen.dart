import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/inventory_item.dart';
import '../../data/sample_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/recipe.dart';
import '../cook/recipe_detail_screen.dart';
import '../../utils/llm_recipe_utils.dart';
import 'dart:async';
import '../cook/generated_recipe_list_screen.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  int _servings = 2;
  int _meals = 1;
  final TextEditingController _dietaryController = TextEditingController();

  @override
  void dispose() {
    _dietaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Your preferences',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Servings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            _buildServingAndMealSelector(),
            const SizedBox(height: 24),
            const Text(
              'Dietary preferences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                TextField(
                  controller: _dietaryController,
                  maxLines: 6,
                  minLines: 6,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'eg.\nBritish style breakfast,\nI want have eggs,\nno beans.',
                    hintStyle: TextStyle(
                      color: Colors.pink[100],
                      fontSize: 15,
                    ),
                    filled: true,
                    fillColor: Colors.pink[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 16, 48, 16),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {}, // 语音输入逻辑
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.mic, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  _generateRecipeAndShowLoading(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Get Recipe...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _roundButton({required IconData icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: onTap != null ? Colors.redAccent : Colors.redAccent.withOpacity(0.3),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildServingAndMealSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Servings
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Servings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 8),
            Row(
              children: [
                _roundButton(
                  icon: Icons.remove,
                  onTap: _servings > 1 ? () => setState(() => _servings--) : null,
                ),
                const SizedBox(width: 8),
                _numberBox(_servings),
                const SizedBox(width: 8),
                _roundButton(
                  icon: Icons.add,
                  onTap: _servings < 10 ? () => setState(() => _servings++) : null,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 32),
        // Meal
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Meal:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 8),
            Row(
              children: [
                _roundButton(
                  icon: Icons.remove,
                  onTap: _meals > 1 ? () => setState(() => _meals--) : null,
                ),
                const SizedBox(width: 8),
                _numberBox(_meals),
                const SizedBox(width: 8),
                _roundButton(
                  icon: Icons.add,
                  onTap: _meals < 5 ? () => setState(() => _meals++) : null,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _numberBox(int value) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        '$value',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Future<void> _generateRecipeAndShowLoading(BuildContext context) async {
    if (_dietaryController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your dietary preferences'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    final inventoryItems = SampleData.inventoryItems;
    final servings = _servings;
    final prompt = _dietaryController.text.trim();
    final meals = _meals;
    bool isTimeout = false;
    Timer? timer;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
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
                    Text('正在生成食谱...'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    timer = Timer(const Duration(seconds: 30), () {
      if (Navigator.of(context).canPop()) {
        isTimeout = true;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('请求超时，请重试'), backgroundColor: Colors.red),
        );
      }
    });
    try {
      List<Recipe> recipes = [];
      List<String> usedNames = [];
      List<String> usedIngredients = [];
      for (int i = 0; i < meals; i++) {
        final recipe = await generateSingleRecipe(
          inventoryItems: inventoryItems,
          servings: servings,
          prompt: prompt,
          context: context,
          mealIndex: i,
          totalMeals: meals,
          usedNames: usedNames,
          usedIngredients: usedIngredients,
        );
        recipes.add(recipe);
        usedNames.add(recipe.name);
        usedIngredients.addAll(recipe.ingredients);
      }
      if (isTimeout) return;
      timer.cancel();
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => GeneratedRecipeListScreen(recipes: recipes),
        ),
      );
    } catch (e) {
      if (!isTimeout) {
        timer.cancel();
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('请求异常: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
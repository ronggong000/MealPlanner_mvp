import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../models/inventory_item.dart';
import '../../data/sample_data.dart';
import '../../theme/app_colors.dart';
import 'recipe_detail_screen.dart';
import '../settings/preferences_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/recipes_provider.dart';

class CookScreen extends ConsumerStatefulWidget {
  const CookScreen({super.key});

  @override
  ConsumerState<CookScreen> createState() => _CookScreenState();
}

class _CookScreenState extends ConsumerState<CookScreen> with SingleTickerProviderStateMixin {
  List<InventoryItem> inventoryItems = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    inventoryItems = SampleData.inventoryItems;
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cook',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.navigationSelected,
          labelColor: AppColors.navigationSelected,
          unselectedLabelColor: AppColors.navigationUnselected,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Inventory'),
            Tab(text: 'Recipe'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Inventory Tab
          _buildInventoryTab(),
          // Cook Tab
          _buildCookTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PreferencesScreen(),
            ),
          );
          if (result is Recipe) {
            ref.read(recipesProvider.notifier).addRecipe(result);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Recipe saved successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          }
        },
        backgroundColor: Colors.pink[100],
        foregroundColor: Colors.black87,
        label: const Text(
          'Create Recipe',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.restaurant_menu),
      ),
    );
  }
  
  Widget _buildInventoryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Inventory',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: inventoryItems.length,
              itemBuilder: (context, index) {
                final item = inventoryItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: item.imageUrl != null
                        ? Image.asset(
                            item.imageUrl!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.image, color: Colors.grey[400]),
                          ),
                        title: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item.weight,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Show options for this inventory item
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Options for ${item.name}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCookTab() {
    return Column(
      children: [
        // Recipe Section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recipes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ref.watch(recipesProvider).isEmpty
                      ? const Center(
                          child: Text(
                            'No recipes yet.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: ref.watch(recipesProvider).length,
                          itemBuilder: (context, index) {
                            final recipe = ref.watch(recipesProvider)[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RecipeDetailScreen(recipe: recipe),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      if (recipe.imageUrl != null)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.asset(
                                            recipe.imageUrl!,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipe.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Servings: ${recipe.servings} | Portions: ${recipe.portions}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Ingredients: ${recipe.ingredients.join(", ")}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.soup_kitchen, color: Colors.orange),
                                            tooltip: 'Cooked',
                                            onPressed: () {
                                              final recipeIngredients = recipe.ingredients;
                                              bool changed = false;
                                              for (final ingredient in recipeIngredients) {
                                                // 简单匹配 inventory 中包含 ingredient 名的项
                                                final match = inventoryItems.indexWhere((item) => item.name.toLowerCase().contains(ingredient.toLowerCase()));
                                                if (match != -1) {
                                                  final item = inventoryItems[match];
                                                  // 解析 weight 字符串（如 500g）
                                                  final regex = RegExp(r'([0-9]+)\s*(g|kg|pcs|个)?', caseSensitive: false);
                                                  final itemMatch = regex.firstMatch(item.weight ?? '');
                                                  if (itemMatch != null) {
                                                    int itemValue = int.tryParse(itemMatch.group(1) ?? '') ?? 0;
                                                    String unit = itemMatch.group(2) ?? 'g';
                                                    // 假设 recipe 里每个 ingredient 默认消耗 100g 或 1 pcs
                                                    int consume = unit == 'pcs' || unit == '个' ? 1 : 100;
                                                    itemValue -= consume;
                                                    if (itemValue <= 0) {
                                                      inventoryItems.removeAt(match);
                                                    } else {
                                                      inventoryItems[match] = item.copyWith(weight: '$itemValue$unit');
                                                    }
                                                    changed = true;
                                                  }
                                                }
                                              }
                                              if (changed) {
                                                // 强制刷新 UI
                                                (context as Element).markNeedsBuild();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Inventory updated!'), backgroundColor: Colors.green),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('No matching inventory found.'), backgroundColor: Colors.orange),
                                                );
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              ref.read(recipesProvider.notifier).removeRecipe(index);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
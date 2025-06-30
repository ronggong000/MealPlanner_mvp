import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/meal.dart';
import '../../models/recipe.dart';
import '../../data/sample_data.dart';
import '../../theme/app_colors.dart';

/// New meal plan page
class NewMealsScreen extends StatefulWidget {
  const NewMealsScreen({super.key});

  @override
  State<NewMealsScreen> createState() => _NewMealsScreenState();
}

class _NewMealsScreenState extends State<NewMealsScreen>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  List<Meal> _generatedMeals = [];
  final Set<String> _unwantedRecipes = {};
  late AnimationController _loadingController;
  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    ));
    
    _loadingController.repeat();
    _simulateAIGeneration();
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  Future<void> _simulateAIGeneration() async {
    // Simulate AI meal plan generation process
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
        _generatedMeals = _generateSampleMeals();
      });
      _loadingController.stop();
    }
  }

  List<Meal> _generateSampleMeals() {
    final recipes = SampleData.recipes;
    final today = DateTime.now();
    
    return [
      Meal(
        id: 'generated-1',
        type: MealType.breakfast,
        date: today,
        recipes: [recipes[1], recipes[3]], // Steamed egg custard, millet porridge
      ),
      Meal(
        id: 'generated-2',
        type: MealType.lunch,
        date: today,
        recipes: [recipes[0], recipes[2]], // Tomato egg noodles, Kung Pao chicken
      ),
      Meal(
        id: 'generated-3',
        type: MealType.dinner,
        date: today,
        recipes: [recipes[4]], // Braised pork
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'New Meal Plan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryButtonText,
          ),
        ),
        backgroundColor: AppColors.primaryButtonBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryButtonText),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
      ),
      body: _isLoading ? _buildLoadingView() : _buildMealsView(),
      bottomNavigationBar: _isLoading ? null : _buildBottomActions(),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _loadingAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _loadingAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                        colors: [
                          AppColors.primaryButtonBackground.withOpacity(0.1),
                          AppColors.primaryButtonBackground,
                        ],
                      ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.restaurant_menu,
                      size: 40,
                      color: AppColors.primaryButtonText,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'AI is generating your meal plan...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.titleText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait, this may take a few seconds',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.subtitleText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsView() {
    return Column(
      children: [
        // Title and description
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: AppColors.cardBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recommended Meal Plan for You',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap the mark button on the right to mark dishes you don\'t like',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.subtitleText,
                ),
              ),
            ],
          ),
        ),
        
        // Meal plan list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _generatedMeals.length,
            itemBuilder: (context, index) {
              final meal = _generatedMeals[index];
              return _buildMealCard(meal);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMealCard(Meal meal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getMealIcon(meal.type),
                  color: AppColors.primaryButtonBackground,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  meal.type.displayName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...meal.recipes.map((recipe) => _buildRecipeItem(recipe)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeItem(Recipe recipe) {
    final isUnwanted = _unwantedRecipes.contains(recipe.id);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          context.push('/recipe-detail/${recipe.id}');
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUnwanted 
                ? AppColors.errorText.withOpacity(0.1)
                : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isUnwanted 
                  ? AppColors.errorText.withOpacity(0.3)
                  : AppColors.subtitleText.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 50,
                  height: 50,
                  color: AppColors.subtitleText.withOpacity(0.3),
                  child: recipe.imageUrl?.isNotEmpty == true
                      ? Image.asset(
                          recipe.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.restaurant,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isUnwanted 
                            ? AppColors.errorText
                            : AppColors.titleText,
                        decoration: isUnwanted 
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${recipe.cookingTime} min · ${recipe.servings} servings',
                      style: TextStyle(
                        fontSize: 12,
                        color: isUnwanted 
                            ? AppColors.errorText.withOpacity(0.7)
                            : AppColors.subtitleText,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (isUnwanted) {
                      _unwantedRecipes.remove(recipe.id);
                    } else {
                      _unwantedRecipes.add(recipe.id);
                    }
                  });
                },
                icon: Icon(
                  isUnwanted ? Icons.remove_circle : Icons.remove_circle_outline,
                  color: isUnwanted ? AppColors.errorText : AppColors.subtitleText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.subtitleText.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Regenerate button
          Expanded(
            child: OutlinedButton(
              onPressed: _unwantedRecipes.isNotEmpty ? _regenerateUnwantedRecipes : null,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryButtonBackground),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Regenerate (${_unwantedRecipes.length})',
                style: const TextStyle(
                  color: AppColors.primaryButtonBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Complete button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _finishMealPlanning,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButtonBackground,
                foregroundColor: AppColors.primaryButtonText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 2,
              ),
              child: const Text(
                'Complete and Add to Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _regenerateUnwantedRecipes() {
    setState(() {
      _isLoading = true;
    });
    
    _loadingController.repeat();
    
    // Simulate regenerating disliked dishes
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Here should call AI API to regenerate marked dishes
          // Now just simply clear the marks
          _unwantedRecipes.clear();
        });
        _loadingController.stop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dishes regenerated'),
            backgroundColor: AppColors.primaryButtonBackground,
          ),
        );
      }
    });
  }

  void _finishMealPlanning() {
    // Save meal plan to local storage
    // Extract all ingredients and add to cart
    // Navigate to cart page
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Meal plan saved, related ingredients added to cart'),
        backgroundColor: AppColors.primaryButtonBackground,
      ),
    );
    
    // Navigate to cart page
    context.go('/shopping');
    Future.delayed(const Duration(milliseconds: 500), () {
      context.push('/cart');
    });
  }

  IconData _getMealIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Icons.free_breakfast;
      case MealType.lunch:
        return Icons.lunch_dining;
      case MealType.dinner:
        return Icons.dinner_dining;
      case MealType.snack:
        return Icons.cookie;
    }
  }
}
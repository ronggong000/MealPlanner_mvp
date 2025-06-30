import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import '../../models/meal.dart';
import '../../models/recipe.dart';
import '../../data/sample_data.dart';
import '../../theme/app_colors.dart';

/// Meal planning main page
class MealPlanningScreen extends StatefulWidget {
  const MealPlanningScreen({super.key});

  @override
  State<MealPlanningScreen> createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Meal> _mealsForSelectedDay = [];

  @override
  void initState() {
    super.initState();
    _loadMealsForDay(_selectedDay);
  }

  void _loadMealsForDay(DateTime day) {
    // Load today's meal plan from sample data
    setState(() {
      _mealsForSelectedDay = SampleData.getMealsForDay(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Meal Planning',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryButtonText,
          ),
        ),
        backgroundColor: AppColors.primaryButtonBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primaryButtonText),
            onPressed: () {
              context.push('/preference-collection');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar section
          Container(
            color: AppColors.cardBackground,
            child: TableCalendar<Meal>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primaryButtonBackground,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primaryButtonBackground.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: AppColors.primaryButtonBackground,
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _loadMealsForDay(selectedDay);
              },
              eventLoader: (day) {
                return SampleData.getMealsForDay(day);
              },
            ),
          ),
          
          // Today's meal plan
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meal Plan for ${_selectedDay.day}/${_selectedDay.month}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _mealsForSelectedDay.isEmpty
                        ? _buildEmptyState()
                        : _buildMealsList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/preference-collection');
        },
        backgroundColor: AppColors.primaryButtonBackground,
        child: const Icon(Icons.add, color: AppColors.primaryButtonText),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 64,
            color: AppColors.subtitleText,
          ),
          const SizedBox(height: 16),
          Text(
            'No meal plan for today',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.subtitleText,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              context.push('/preference-collection');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButtonBackground,
              foregroundColor: AppColors.primaryButtonText,
            ),
            child: const Text('Create New Plan'),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsList() {
    return ListView.builder(
      itemCount: _mealsForSelectedDay.length,
      itemBuilder: (context, index) {
        final meal = _mealsForSelectedDay[index];
        return _buildMealCard(meal);
      },
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
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.subtitleText.withOpacity(0.3),
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${recipe.cookingTime} min · ${recipe.servings} servings',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.subtitleText,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.subtitleText,
              ),
            ],
          ),
        ),
      ),
    );
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
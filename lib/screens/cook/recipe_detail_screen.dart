import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Recipe',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Avocado Toast with Eggs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Recipe Image
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                'assets/images/avocado_toast.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Details Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      _DetailItem(
                        icon: Icons.people,
                        label: 'Servings',
                        value: '2',
                      ),
                      SizedBox(width: 24),
                      _DetailItem(
                        icon: Icons.timer,
                        label: 'Prep time',
                        value: '2min',
                      ),
                      SizedBox(width: 24),
                      _DetailItem(
                        icon: Icons.local_fire_department,
                        label: 'Cook time',
                        value: '10min',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Ingredients Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _IngredientItem(text: 'Bread'),
                  _IngredientItem(text: 'Avocado'),
                  _IngredientItem(text: 'Eggs'),
                  _IngredientItem(text: 'Seasonings'),
                  _IngredientItem(text: 'Butter'),
                  _IngredientItem(text: 'Olive oil'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tools Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tools',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _ToolItem(text: 'Pan'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Instructions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _InstructionStep(
                    stepNumber: 1,
                    text: 'The first step is to toast the bread and add sliced avocados right on the toasted bread.',
                  ),
                  const _InstructionStep(
                    stepNumber: 2,
                    text: 'Use a fork to mash the avocados right on the toasted bread. You can season it at this point if you\'d like or just season any of the eggs below.',
                  ),
                  const _InstructionStep(
                    stepNumber: 3,
                    text: 'Fried eggs: The first method is fried eggs. This is the best method I\'ve found for frying eggs that creates perfectly cooked egg whites with slightly undercooked egg yolks. Heat some olive oil or butter, break an egg onto the skillet and reduce the heat to low. Cook it uncovered until the whites set. You could cover it up once the whites set if you wanted a more firm yolk.',
                  ),
                  const _InstructionStep(
                    stepNumber: 4,
                    text: 'Scrambled eggs: Heat the oil or butter on a skillet. Whisk the eggs in a small bowl, then pour them into the center of a nonstick pan. The egg mixture will spread, and you want to watch the edges and wait for them to set. Then gently fold the eggs from one side of the pan to the other without smashing the eggs. You\'ll get soft fluffy eggs without any milk.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _IngredientItem extends StatelessWidget {
  final String text;

  const _IngredientItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.fiber_manual_record, size: 8),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _ToolItem extends StatelessWidget {
  final String text;

  const _ToolItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.kitchen, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final int stepNumber;
  final String text;

  const _InstructionStep({
    required this.stepNumber,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.pink[100],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
} 
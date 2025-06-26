import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';

/// Preference collection page
class PreferenceCollectionScreen extends StatefulWidget {
  const PreferenceCollectionScreen({super.key});

  @override
  State<PreferenceCollectionScreen> createState() => _PreferenceCollectionScreenState();
}

class _PreferenceCollectionScreenState extends State<PreferenceCollectionScreen> {
  DateTime _focusedDay = DateTime.now();
  final Set<DateTime> _selectedDays = {};
  double _budget = 100.0;
  int _mealsPerDay = 3;
  final TextEditingController _preferencesController = TextEditingController();
  bool _isListening = false;

  @override
  void dispose() {
    _preferencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Create Meal Plan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Budget and meal count settings
                  _buildSettingsCard(),
                  const SizedBox(height: 16),
                  
                  // Calendar selection
                  _buildCalendarCard(),
                  const SizedBox(height: 16),
                  
                  // Preference input
                  _buildPreferencesCard(),
                ],
              ),
            ),
          ),
          
          // Bottom button
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            // Budget setting
            Row(
              children: [
                const Icon(
                  Icons.attach_money,
                  color: Color(0xFF4CAF50),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Budget:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _budget,
                    min: 50,
                    max: 500,
                    divisions: 45,
                    activeColor: const Color(0xFF4CAF50),
                    onChanged: (value) {
                      setState(() {
                        _budget = value;
                      });
                    },
                  ),
                ),
                Text(
                  '¥${_budget.toInt()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Daily meal count setting
            Row(
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  color: Color(0xFF4CAF50),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Daily Meals:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: _mealsPerDay > 1
                            ? () {
                                setState(() {
                                  _mealsPerDay--;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                        iconSize: 20,
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '$_mealsPerDay',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _mealsPerDay < 5
                            ? () {
                                setState(() {
                                  _mealsPerDay++;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.add),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Card(
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
                const Text(
                  'Select Dates',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const Spacer(),
                if (_selectedDays.isNotEmpty)
                  Text(
                    '${_selectedDays.length} days selected',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TableCalendar<DateTime>(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 30)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => _selectedDays.contains(day),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(
                  color: Colors.red[400],
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                  if (_selectedDays.contains(selectedDay)) {
                    _selectedDays.remove(selectedDay);
                  } else {
                    _selectedDays.add(selectedDay);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dietary Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please describe your dietary preferences, allergies, taste requirements, etc.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                TextField(
                  controller: _preferencesController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'For example: I prefer light dishes, don\'t eat spicy food, allergic to seafood...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: FloatingActionButton.small(
                    onPressed: _toggleListening,
                    backgroundColor: _isListening
                        ? Colors.red
                        : const Color(0xFF4CAF50),
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _selectedDays.isNotEmpty ? _generateMealPlan : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Generate Meal Plan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
    
    // TODO: Implement voice input function
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isListening ? 'Starting voice input...' : 'Stopping voice input'),
        duration: const Duration(seconds: 1),
      ),
    );
    
    if (_isListening) {
      // Simulate voice input end
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _isListening) {
          setState(() {
            _isListening = false;
          });
        }
      });
    }
  }

  void _generateMealPlan() {
    // Pass user preference data to new meal plan page
    final preferences = {
      'selectedDays': _selectedDays.toList(),
      'budget': _budget,
      'mealsPerDay': _mealsPerDay,
      'preferences': _preferencesController.text,
    };
    
    context.push('/new-meals', extra: preferences);
  }
}
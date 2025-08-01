import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'preferences_screen.dart';

/// Settings page
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 60, 60),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.primaryButtonText,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 41, 108, 232),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User info card
            _buildUserProfileCard(),
            
            const SizedBox(height: 16),
            
            // App settings
            _buildSettingsSection(
              'App Settings',
              [
                _buildSwitchTile(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Receive meal plan and shopping reminders',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Use dark theme',
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dark mode feature coming soon')),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: _selectedLanguage,
                  onTap: _showLanguageDialog,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Account settings
            _buildSettingsSection(
              'Account Settings',
              [
                _buildListTile(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle: 'Edit personal information',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile feature coming soon')),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.location_on_outlined,
                  title: 'Delivery Address',
                  subtitle: 'Manage delivery addresses',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Address management feature coming soonsssssssss')),
                    );  
                  },
                ),
                _buildListTile(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  subtitle: 'Manage payment methods',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment methods feature coming soon')),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Dietary preferences
            _buildSettingsSection(
              'Dietary Preferences',
              [
                _buildListTile(
                  icon: Icons.restaurant_menu_outlined,
                  title: 'Dietary Restrictions',
                  subtitle: 'Set allergens and dietary restrictions',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dietary restrictions feature coming soon')),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.favorite_outline,
                  title: 'Preferences',
                  subtitle: 'Set liked and disliked foods',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreferencesScreen(),
                      ),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.schedule_outlined,
                  title: 'Meal Times',
                  subtitle: 'Set default meal times',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Meal time feature coming soon')),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Help & support
            _buildSettingsSection(
              'Help & Support',
              [
                _buildListTile(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'FAQ and user guide',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Help center feature coming soon')),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.feedback_outlined,
                  title: 'Feedback',
                  subtitle: 'Provide suggestions to us',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Feedback feature coming soon')),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.info_outline,
                  title: 'About Us',
                  subtitle: 'Version info and development team',
                  onTap: _showAboutDialog,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Other
            _buildSettingsSection(
              'Other',
              [
                _buildListTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Learn how we protect your privacy',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Privacy policy feature coming soon')),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  subtitle: 'Terms of use and service agreement',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Terms of service feature coming soon')),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.logout_outlined,
                  title: 'Logout',
                  subtitle: 'Sign out of current account',
                  onTap: _showLogoutDialog,
                  textColor: AppColors.primaryButtonBackground,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  Widget _buildUserProfileCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [AppColors.primaryButtonBackground, AppColors.primaryButtonBackground.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              // User avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryButtonText.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 30,
                  color: AppColors.primaryButtonText,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryButtonText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'zhangsan@example.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryButtonText.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Edit button
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit profile feature coming soon')),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryButtonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleText,
                ),
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
  
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? AppColors.primaryButtonBackground,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? AppColors.titleText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.subtitleText,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.subtitleText,
      ),
      onTap: onTap,
    );
  }
  
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primaryButtonBackground,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.titleText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.subtitleText,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryButtonBackground,
      ),
    );
  }
  
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Select Language',
          style: TextStyle(color: AppColors.titleText),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text(
                'Chinese',
                style: TextStyle(color: AppColors.titleText),
              ),
              value: 'Chinese',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: const Text(
                'English',
                style: TextStyle(color: AppColors.titleText),
              ),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Multi-language feature coming soon')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.subtitleText),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'MealPlanner',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primaryButtonBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.restaurant_menu,
          color: AppColors.primaryButtonText,
          size: 30,
        ),
      ),
      children: [
        const Text(
          'MealPlanner is a smart meal planning application that helps you easily plan your daily diet and enjoy a healthy life.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.subtitleText,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Development Team: MealPlanner Team',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.titleText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Contact us: support@mealplanner.com',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.subtitleText,
          ),
        ),
      ],
    );
  }
  
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Logout',
          style: TextStyle(color: AppColors.titleText),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: AppColors.subtitleText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.subtitleText),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout successful'),
                  backgroundColor: AppColors.primaryButtonBackground,
                ),
              );
              // TODO: Implement logout logic
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.errorText),
            ),
          ),
        ],
      ),
    );
  }
}
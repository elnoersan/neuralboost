import 'package:flutter/material.dart';
import 'package:neuralboost/utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.backgroundColor,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Account'),
              _buildSettingsTile(
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  // Navigate to Profile Settings
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              _buildSettingsTile(
                icon: Icons.lock,
                title: 'Change Password',
                onTap: () {
                  // Navigate to Change Password
                  Navigator.pushNamed(context, '/change-password');
                },
              ),
              _buildSectionTitle('Notifications'),
              _buildSettingsTile(
                icon: Icons.notifications,
                title: 'Notification Settings',
                onTap: () {
                  // Navigate to Notification Settings
                  Navigator.pushNamed(context, '/notification-settings');
                },
              ),
              _buildSettingsTile(
                icon: Icons.do_not_disturb_alt,
                title: 'Do Not Disturb',
                onTap: () {
                  // Navigate to Do Not Disturb Settings
                  Navigator.pushNamed(context, '/do-not-disturb');
                },
              ),
              _buildSectionTitle('Privacy'),
              _buildSettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Settings',
                onTap: () {
                  // Navigate to Privacy Settings
                  Navigator.pushNamed(context, '/privacy-settings');
                },
              ),
              _buildSettingsTile(
                icon: Icons.security,
                title: 'Security',
                onTap: () {
                  // Navigate to Security Settings
                  Navigator.pushNamed(context, '/security-settings');
                },
              ),
              _buildSectionTitle('General'),
              _buildSettingsTile(
                icon: Icons.language,
                title: 'Language',
                onTap: () {
                  // Navigate to Language Settings
                  Navigator.pushNamed(context, '/language-settings');
                },
              ),
              _buildSettingsTile(
                icon: Icons.brightness_medium,
                title: 'Theme',
                onTap: () {
                  // Navigate to Theme Settings
                  Navigator.pushNamed(context, '/theme-settings');
                },
              ),
              _buildSectionTitle('Support'),
              _buildSettingsTile(
                icon: Icons.help,
                title: 'Help Center',
                onTap: () {
                  // Navigate to Help Center
                  Navigator.pushNamed(context, '/help-center');
                },
              ),
              _buildSettingsTile(
                icon: Icons.feedback,
                title: 'Send Feedback',
                onTap: () {
                  // Navigate to Send Feedback
                  Navigator.pushNamed(context, '/send-feedback');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppTheme.primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.primaryColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppTheme.primaryColor,
        ),
        onTap: onTap,
      ),
    );
  }
}

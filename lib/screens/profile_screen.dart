import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils/app_theme.dart'; // Import the custom theme

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> _userFuture;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _userFuture = _authService.getCurrentUser();
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                await _authService.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppTheme.scaffoldBackgroundColor,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: FutureBuilder<User>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Error loading user data'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _userFuture = _authService.getCurrentUser();
                          });
                        },
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: Text('No user data found'));
              }

              final User user = snapshot.data!;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildProfileHeader(context, user),
                      const SizedBox(height: 30),
                      _buildUserDetailsCard(context, user),
                      const SizedBox(height: 20),
                      _buildAdditionalInfo(context, user),
                      const SizedBox(height: 30),
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: AppTheme.primaryColor,
            child: Icon(
              Icons.person,
              size: 70,
              color: AppTheme.scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            user.email.split('@')[0],
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTextColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetailsCard(BuildContext context, User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: AppTheme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(context, Icons.account_circle, 'User ID', user.id),
            const Divider(height: 20, color: Colors.black12),
            _buildDetailRow(context, Icons.email, 'Email Address', user.email),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 24),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(BuildContext context, User user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoChip(context, Icons.paid, 'Points', user.points.toString(),
              AppTheme.primaryColor),
          _buildInfoChip(
              context,
              Icons.health_and_safety,
              'ADHD Status',
              user.adhdStatus,
              user.adhdStatus == 'Likely ADHD'
                  ? Colors.red[700]!
                  : user.adhdStatus == 'Possible ADHD'
                      ? Colors.orange[700]!
                      : Colors.green[700]!),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label,
      String value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Edit Profile Coming Soon!')),
            );
          },
          style: AppTheme.elevatedButtonStyle,
          child: const Text('Edit Profile'),
        ),
        OutlinedButton(
          onPressed: _showLogoutConfirmationDialog,
          style: AppTheme.outlinedButtonStyle,
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

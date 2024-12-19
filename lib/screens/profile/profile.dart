import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';

class ProfileContent extends StatelessWidget {
  final String userName;
  final String email;
  final String profileImageUrl;

  ProfileContent({
    this.userName = 'John Doe',
    this.email = 'johndoe@example.com',
    this.profileImageUrl = 'https://via.placeholder.com/150', // Placeholder Image
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(),
      bottomNavigationBar: NmtdNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile Image
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            SizedBox(height: 10),

            // User Name
            Text(
              userName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),

            // User Email
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 20),

            // Profile Options
            _buildProfileOption(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                // Navigate to Edit Profile Page
              },
            ),
            _buildProfileOption(
              icon: Icons.history,
              title: 'Order History',
              onTap: () {
                // Navigate to Order History Page
              },
            ),
            _buildProfileOption(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () {
                // Navigate to Change Password Page
              },
            ),
            _buildProfileOption(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Navigate to Settings Page
              },
            ),
            _buildProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                // Navigate to Help & Support Page
              },
            ),

            SizedBox(height: 30),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                // Handle Logout Logic
                _showLogoutConfirmation(context);
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Profile Options
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // Logout Confirmation Dialog
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform logout operation here
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}

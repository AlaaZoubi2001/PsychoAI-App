import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/common/Objects/User.dart';
import 'package:psychoai/common/db_functions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppUser userInfo= DBFunctions.instance.logedInUser!;
      final GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();

  @override
  Widget build(BuildContext context, ) 
  {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Adjust size if needed
        child: CustomAppBar(key: _appBarKey), // Assign GlobalKey to the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // User profile header
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Text(
                userInfo.name[0], // Show first letter of the user's name
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                userInfo.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                userInfo.email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Display user information
            _buildUserInfoRow(Icons.person, 'Name', userInfo.name),
            _buildUserInfoRow(Icons.email, 'Email', userInfo.email),
            _buildUserInfoRow(Icons.fingerprint, 'Password', '******'),
            _buildUserInfoRow(Icons.wc, 'Sex', userInfo.sex),
            _buildUserInfoRow(Icons.cake, 'Age', userInfo.age.toString()),
            _buildUserInfoRow(Icons.star, 'Points', userInfo.points.toString()),
            _buildUserInfoRow(Icons.access_time, 'Last Login',
                _formatDate(DateTime.parse(userInfo.lastLogin))),

            // Logout Button
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add your logout functionality here
                  print('User logged out');
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );;
  }

  
  // Helper widget to display a row of user info
  Widget _buildUserInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 16),
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to format the last login date
  String _formatDate(DateTime lastLogin) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(lastLogin);
  }
}
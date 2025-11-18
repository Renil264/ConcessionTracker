import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/changepassword.dart';
import 'package:concession_tracker/views/auth/login_screen.dart';
import 'package:concession_tracker/views/auth/myorders.dart';
import 'package:concession_tracker/views/auth/personaldetails.dart';
import 'package:concession_tracker/views/auth/selectmarketpage.dart';
import 'package:concession_tracker/views/auth/termsndconditions.dart';
import 'package:flutter/material.dart';

class HamburgerPage extends StatelessWidget {
  const HamburgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.googleWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.googleWhite,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: AppTheme.appleBlack,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppTheme.appleBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            
            const CircleAvatar(
              radius: 35,
              backgroundColor: AppTheme.brandPurple,
              child: Icon(Icons.person, color: AppTheme.googleWhite, size: 40),
            ),
            const SizedBox(height: 10),

           
            const Text(
              "Johnson",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.appleBlack,
              ),
            ),

           
            const SizedBox(height: 4),
            const Text(
              "johnson@gmail.com",
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.appleBlack,
              ),
            ),
            const SizedBox(height: 30),

            
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem(
                    context,
                    Icons.store_mall_directory_outlined,
                    "Switch Market",
                    const SelectMarketPage(),
                  ),
                  _buildMenuItem(
                    context,
                    Icons.person_outline,
                    "Personal details",
                    const PersonalDetailsScreen()
                  ),
                  _buildMenuItem(
                    context,
                    Icons.lock_outline,
                    "Change Password",
                    const ChangePasswordScreen()
                  ),
                  _buildMenuItem(
                    context,
                    Icons.shopping_bag_outlined,
                    "My Orders",
                    const MyOrdersPage()
                  ),
                  _buildMenuItem(
                    context,
                    Icons.description_outlined,
                    "Terms and conditions",
                    const PrivacyPolicyPage()
                  ),
                ],
              ),
            ),

            
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const LoginScreen()),
                );
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brandGreen,
                  foregroundColor: AppTheme.googleWhite,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Sign out",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  
  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Widget destinationPage) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: AppTheme.appleBlack),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.appleBlack,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: AppTheme.appleBlack),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            );
          },
        ),
        const Divider(height: 1, thickness: 0.2, color: AppTheme.labelGray),
      ],
    );
  }
}


class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppTheme.brandPurple,
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

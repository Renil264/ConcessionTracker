import 'package:concession_tracker/views/auth/notification.dart';
import 'package:concession_tracker/widgets/bottombar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/hamburger.dart';
import 'package:concession_tracker/views/auth/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.googleWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.brandPurple,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppTheme.googleWhite,
              child: Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(width: 8),
            const Text(
              "Johnson",
              style: TextStyle(color: AppTheme.googleWhite, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Stack(
              children: [
                IconButton(
                  onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()),
                );},
                  icon: const Icon(Icons.notifications, color: AppTheme.googleWhite),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        "2",
                        style: TextStyle(color: AppTheme.googleWhite, fontSize: 10),
                      ),
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HamburgerPage()),
                );
              },
              icon: const Icon(Icons.menu, color: AppTheme.googleWhite),
            ),
          ],
        ),
      ),
      body: const _HomeContent(), // ✅ this stays right here
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

// 👇 This part stays in the same file — it’s just a helper widget
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),

        // Scrollable Restaurant List
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildRestaurantCard("Marketplace Grill", "assets/images/marketplace_grill.jpg", context),
                _buildRestaurantCard("Freddie's Pizza's", "assets/images/freddies_pizza.jpg", context),
                _buildRestaurantCard("Taco Corner", "assets/images/taco_corner.jpg", context),
                _buildRestaurantCard("Burger Shack", "assets/images/burger_shack.png", context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for each restaurant card
  static Widget _buildRestaurantCard(String title, String imagePath, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.appleBlack),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(imagePath,
                    height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.deepOrangeAccent, size: 20),
                  Icon(Icons.star, color: Colors.deepOrangeAccent, size: 20),
                  Icon(Icons.star, color: Colors.deepOrangeAccent, size: 20),
                  Icon(Icons.star, color: Colors.deepOrangeAccent, size: 20),
                  Icon(Icons.star_half, color: Colors.deepOrangeAccent, size: 20),
                  SizedBox(width: 6),
                  Text("(4.5)", style: TextStyle(fontSize: 12, color: AppTheme.appleBlack)),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brandGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const MenuPage()),
                  );
                },
                child: const Text("View Menu", style: TextStyle(color: AppTheme.googleWhite)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

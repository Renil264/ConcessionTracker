import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/viewmodels/menu_viewmodel.dart';
import 'package:concession_tracker/views/auth/bottomsheet.dart';
import 'package:concession_tracker/views/auth/hamburger.dart';
import 'package:concession_tracker/views/auth/notification.dart';
import 'package:concession_tracker/widgets/bottombar_navigation.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final MenuViewModel viewModel = MenuViewModel();

  // Track favorite status for each menu item
  final Set<int> favoriteItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.googleWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.brandPurple,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppTheme.googleWhite,
              child: Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(width: 8),
            const Text(
              "Johnson",
              style: TextStyle(
                color: AppTheme.googleWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),

            // Notifications with badge
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()),
                );
                  },
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
                        style: TextStyle(
                          color: AppTheme.googleWhite,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔎 Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // 🍴 Categories
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 27.5,
                          backgroundColor: AppTheme.brandPurple,
                          child: Icon(Icons.fastfood, color: AppTheme.googleWhite),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          viewModel.categories[index],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.appleBlack,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "MENU",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // 🍔 Menu Grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: viewModel.menuItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = viewModel.menuItems[index];
                final isFavorite = favoriteItems.contains(index);

                return _buildMenuCard(
                  item["name"],
                  item["image"],
                  item["price"].toString(),
                  context,
                  index,
                  isFavorite,
                );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  

  void _showAddToCartBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return BottomSheetContent();
    },
  );
}



  // 🔹 Menu Card UI (with favorite moved to ListTile)
  Widget _buildMenuCard(
    String title,
    String image,
    String price,
    BuildContext context,
    int index,
    bool isFavorite,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🖼️ Food Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // 🧾 Food Details + Favorite Button
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppTheme.appleBlack,
              ),
            ),
            subtitle: Text(
              "\$$price",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: AppTheme.appleBlack,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : AppTheme.appleBlack,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoriteItems.remove(index);
                  } else {
                    favoriteItems.add(index);
                  }
                });
              },
            ),
          ),

          // 🛒 Add to Cart Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.brandGreen,
                minimumSize: const Size(double.infinity, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                _showAddToCartBottomSheet(context);
              },
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                  color: AppTheme.googleWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

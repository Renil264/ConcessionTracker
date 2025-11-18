import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/addtocart.dart';
import 'package:concession_tracker/views/auth/credits_page.dart';
import 'package:concession_tracker/views/auth/homepage.dart';
import 'package:concession_tracker/views/auth/savedpage.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget destination;
    switch (index) {
      case 0:
        destination = const HomePage();
        break;
      case 1:
        destination = const SavedScreen();
        break;
      case 2:
        destination = const CartScreen();
        break;
      case 3:
        destination = const CreditsPage();
        break;
      default:
        destination = const HomePage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔴 For demo — you can later connect this with your actual cart logic
    bool hasItemsInCart = true; // Show badge only if cart has items

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppTheme.brandPurple,
      unselectedItemColor: AppTheme.appleBlack,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        // 🏠 Home
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),

        // ❤️ Saved
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "Saved",
        ),

        // 🛒 Cart — with Red Dot Badge
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart_outlined),
              if (hasItemsInCart)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          label: "Cart",
        ),

        // 💵 Credits
        const BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: "Credits",
        ),
      ],
    );
  }
}

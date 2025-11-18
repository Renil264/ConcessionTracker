import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/widgets/bottombar_navigation.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.googleWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.googleWhite,
        automaticallyImplyLeading: false,
        title: const Text(
          "Saved",
          style: TextStyle(
            color: AppTheme.appleBlack, 
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/book_icon.png',
                height: 150,
              ),
              const SizedBox(height: 5),

              const Text(
                'Nothing saved just yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.appleBlack,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Save your favorite item to see it here',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.labelGray,
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: 200,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brandPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Find favorite food',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.googleWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

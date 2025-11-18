import 'package:concession_tracker/app_theme.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: AppTheme.googleWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Close button on top left
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Image.asset(
                  'assets/success.png', 
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),

                const Text(
                  "Order Placed!",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppTheme.appleBlack,
                  ),
                ),
                const SizedBox(height: 6),

                const Text(
                  "Present this code at collection",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.labelGray,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brandPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                ),
                child: const Text(
                  "Go back home",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.googleWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

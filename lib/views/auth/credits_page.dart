import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/widgets/bottombar_navigation.dart';
import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget{
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppTheme.googleWhite,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.googleWhite,
        automaticallyImplyLeading: false,
        title: const Text(
          "Credits",
          style: TextStyle(
            color: AppTheme.appleBlack,
            fontWeight: FontWeight.w700
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.brandPurplelight,AppTheme.brandPurpledark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppTheme.appleBlack.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0,4),
                  )
                ]
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("POINT BALANCE",
                  style: TextStyle(
                    color: AppTheme.googleWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                 ),
                 SizedBox(height: 8),
                 Text(
                  "\$1200.31",
                  style: TextStyle(
                    color: AppTheme.googleWhite,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                 SizedBox(height:16),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Transactions",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppTheme.appleBlack,
              ),
            ),
            const SizedBox(height:10),

            Column(
              children: List.generate(4,(index) => const TransactionCard()),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNavBar(currentIndex: 3),

    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.brandPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Storage Name",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "09 September, 7:09 AM",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          // Right section
          Text(
            "-\$21.00",
            style: TextStyle(
              color:AppTheme.googleWhite,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
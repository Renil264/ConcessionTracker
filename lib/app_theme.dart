import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors picked to match the XD (purple/maroon + neutral grays)
  static const Color brandPurple = Color(0xFF7F296A);
  static const Color brandPurpledark = Color(0xFF23167B);
  static const Color brandPurplelight = Color(0xFF913A7C);
  static const Color facebookBlue = Color.fromARGB(255, 14, 63, 52);
  static const Color appleBlack = Colors.black;
  static const Color googleWhite = Colors.white;
  static const Color dividerGray = Color(0xFFE7E7E7);
  static const Color labelGray = Color(0xFF7C7C7C);
  static const Color brandGreen = Color(0xFF007F5F);
  static const Color brandyellow = Color(0xFFF98601);
  static const Color yellowaccent = Color(0xFFFDFFC4);
  static const Color greenAccent = Color(0xFFC4FFE1);

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: false);

    return base.copyWith(
      primaryColor: brandPurple,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      // 👇 Apply DM Sans globally
      textTheme: GoogleFonts.dmSansTextTheme(base.textTheme).copyWith(
        headlineSmall: GoogleFonts.dmSans(
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 14,
          color: labelGray,
        ),
        labelLarge: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always, // 👈 keeps label outside
        filled: false, // no background color inside field
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8), // smaller rounded corners
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.4),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

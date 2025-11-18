import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectMarketPage extends StatefulWidget {
  const SelectMarketPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectMarketPageState createState() => _SelectMarketPageState();
}

class _SelectMarketPageState extends State<SelectMarketPage> {
  String? selectedCity;
  String? selectedMarket;

  final Map<String, List<String>> cityMarkets = {
    "Aromas": ["Mile High Flea Market", "Red Barn Flea Market"],
    "Houston": ["Cole's Flea Market",],
    "Lexington": ["Flamingo Island"],
    "Antioch": ["Antioch Fleamarket"]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.googleWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.brandPurple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Select Your Market",
              style: TextStyle(
                  fontSize: 25,
                  color: AppTheme.appleBlack,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please choose your city and market to login into your account.",
              style: TextStyle(fontSize: 14, color: AppTheme.appleBlack),
            ),
            const SizedBox(height: 30),

            // CITY DROPDOWN
            const Text(
              "Choose a City",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppTheme.appleBlack
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.appleBlack),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Select city"),
                  value: selectedCity,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                      selectedMarket = null; // Reset market when city changes
                    });
                  },
                  items: cityMarkets.keys.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // MARKET DROPDOWN
            const Text(
              "Choose a Market",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.appleBlack),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.appleBlack),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Select market"),
                  value: selectedMarket,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: selectedCity == null
                      ? null
                      : (value) {
                          setState(() {
                            selectedMarket = value;
                          });
                        },
                  items: selectedCity == null
                      ? []
                      : cityMarkets[selectedCity]!
                          .map(
                            (market) => DropdownMenuItem(
                              value: market,
                              child: Text(market),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brandPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (selectedCity != null && selectedMarket != null) {
                    if (kDebugMode) {
                      print("Selected City: $selectedCity");
                      print("Selected Market: $selectedMarket");
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select both city and market"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

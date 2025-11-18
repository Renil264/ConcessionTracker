import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SwitchMarketPage extends StatefulWidget{
  const SwitchMarketPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SwitchMarketPageState createState()=> _SwitchMarketPageState();
}

class _SwitchMarketPageState extends State<SwitchMarketPage>{
  String? selectedMarket;
  final List<String> market = [
    "Mile High Flea Market",
    "Cole's Flea Market",
    "Flamingo Island",
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppTheme.brandPurple),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    
        actions: [TextButton(onPressed: (){

        }, child: const Text("Next", style: TextStyle (color: AppTheme.brandPurple, fontSize: 16),
        )
      )
    ],
  ),
  body: Padding(padding: const EdgeInsets.all(20.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [const SizedBox(height: 10),
    const Text(" Select Your Market", style: TextStyle(fontSize: 25, color: Colors.black,fontWeight: FontWeight.bold)),
    const SizedBox(height: 10),
    const Text("  Please choose your market to login in to your account.",
    style: TextStyle(fontSize: 14, color: Colors.black),
    ),
    const SizedBox(height: 30),
    const Text(
       "  Choose a Market",
       style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
       ),
       const SizedBox(height: 12),
       Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: const Text("select"),
            value: selectedMarket,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (value){
              setState((){
                selectedMarket = value;
              });
            },
            items: market.map((market){
              return DropdownMenuItem(value: market,
              child: Text(market),
              );
            }).toList(),
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
            padding : const EdgeInsets.symmetric(vertical: 14), 
          ),
          onPressed: () {
            if (selectedMarket != null) {
              if (kDebugMode) {
                print("Selected Market: $selectedMarket");
              }

              // Navigate to HomePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );

            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select a mark"),
                ),
              );
            }
          },
          child: const Text(
            "Continue",
            style: TextStyle(fontSize:16,
            fontWeight: FontWeight.bold,
            ),
          ),
        )
       )
     ],
    ),
   ),
  );
 }
}
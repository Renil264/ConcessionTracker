import 'package:flutter/material.dart';

void showFoodBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Curve look
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.60,
        minChildSize: 0.35,
        maxChildSize: 0.90,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    height: 6,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const Text("Burritos",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                const SizedBox(height: 16),

                /// Main Price + Qty Row
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      /// Fake food image
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4B244A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      const SizedBox(width: 16),

                      /// Price
                      const Text(
                        "\$4.50",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),

                      const Spacer(),

                      /// Buttons
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.delete_outline),
                            SizedBox(width: 8),
                            Text("1",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            SizedBox(width: 8),
                            Icon(Icons.add),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      const Text("Food Mods",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      _buildAddonRow("Pepsi 330ml", "\$2.00"),
                      _buildAddonRow("Fanta 330ml", "\$2.00"),
                      _buildAddonRow("Fries (Small)", "\$2.00"),
                      _buildAddonRow("Ketchup", "\$1.00"),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// Add Item Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B244A),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Add Item",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

/// Helper: Add-ons row with checkbox
Widget _buildAddonRow(String name, String price) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: TextStyle(fontSize: 15)),
        Row(
          children: [
            Text(price, style: const TextStyle(fontSize: 15)),
            const SizedBox(width: 6),
            Checkbox(value: false, onChanged: (_) {}),
          ],
        )
      ],
    ),
  );
}



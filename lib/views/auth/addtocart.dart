import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/bottomsheet.dart';
import 'package:concession_tracker/views/auth/menu.dart';
import 'package:concession_tracker/views/auth/payment_options_sheet.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String? option;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.option,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(id: '1', name: 'Burritos', price: 14.50, option: 'Pepsi 330ml'),
  ];

  double serviceFee = 0.30;

 
  int availableCredits = 10;



  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get rawTotal => subtotal + serviceFee;


  double get payableAmount {
    if (availableCredits >= rawTotal) {
      return 0;
    } else {
      return rawTotal - availableCredits;
    }
  }

  
  int get remainingCredits {
    if (availableCredits >= rawTotal) {
      return (availableCredits - rawTotal).toInt();
    } else {
      return 0;
    }
  }

  void _removeItem(String id) {
    setState(() {
      cartItems.removeWhere((item) => item.id == id);
    });
  }

  void _updateQuantity(String id, int delta) {
    setState(() {
      final item = cartItems.firstWhere((item) => item.id == id);
      item.quantity += delta;
      if (item.quantity < 1) {
        item.quantity = 1;
      }
    });
  }

  void _showAddonBottomSheet(BuildContext context, CartItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => BottomSheetContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    double baseFont = screenWidth * 0.045;
    double padding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: AppTheme.googleWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.brandPurple,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart, color: Colors.white, size: baseFont + 2),
            SizedBox(width: screenWidth * 0.02),
            Text(
              'My Cart',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: baseFont + 2,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: baseFont + 2),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order items',
                    style: TextStyle(
                      fontSize: baseFont + 6,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.appleBlack,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  /// CART ITEMS
                  ...cartItems.map((item) => Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                        child:
                            _buildCartItem(item, baseFont, screenWidth, screenHeight),
                      )),

                  SizedBox(height: screenHeight * 0.04),

                  Text(
                    'Order summary',
                    style: TextStyle(
                      fontSize: baseFont + 6,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildSummaryRow('Item subtotal', '\$${subtotal.toStringAsFixed(2)}', baseFont),
                  SizedBox(height: screenHeight * 0.015),
                  _buildSummaryRow('Extra fee', '\$${serviceFee.toStringAsFixed(2)}', baseFont),
                  SizedBox(height: screenHeight * 0.02),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
    
                  _buildSummaryRow('Total Payable',
                      '\$${payableAmount.toStringAsFixed(2)}', baseFont, isBold: true),

                  SizedBox(height: screenHeight * 0.03),

             
                  _buildCreditRow("Available Credits", availableCredits, baseFont),
                  SizedBox(height: screenHeight * 0.015),
                  _buildCreditRow("Remaining Credits", remainingCredits, baseFont),
                ],
              ),
            ),
          ),

  
          Container(
            padding: EdgeInsets.all(padding),
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.065,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F8558),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    builder: (_) => PaymentOptionsSheet(
                      totalAmount: payableAmount,
                      onApplePay: () {},
                      onGooglePay: () {},
                      onCardPayment: () {},
                    ),
                  );
                },
                child: Text(
                  'PAY  \$${payableAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: baseFont,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.googleWhite,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
      CartItem item, double baseFont, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: screenWidth * 0.13,
                height: screenWidth * 0.13,
                decoration: BoxDecoration(
                  color: AppTheme.brandPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.fastfood,
                  color: Colors.white.withOpacity(0.3),
                  size: baseFont + 12,
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: baseFont,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: baseFont - 2,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 22),
                    color: Colors.grey[600],
                    onPressed: () => _removeItem(item.id),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 18),
                          color: Colors.black,
                          onPressed: () => _updateQuantity(item.id, -1),
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: screenWidth * 0.07,
                          child: Text(
                            item.quantity.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: baseFont - 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          color: Colors.grey[300],
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          color: Colors.black,
                          onPressed: () => _updateQuantity(item.id, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (item.option != null) ...[
            SizedBox(height: screenHeight * 0.015),
            InkWell(
              onTap: () => _showAddonBottomSheet(context, item),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.option!,
                        style: TextStyle(
                          fontSize: baseFont - 2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, double baseFont,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: baseFont - 2,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: baseFont - 1,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCreditRow(String title, int value, double baseFont) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.googleWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.card_giftcard, color: AppTheme.brandPurple, size: baseFont + 2),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: baseFont - 1,
                fontWeight: FontWeight.w600,
                color: AppTheme.appleBlack,
              ),
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: baseFont - 1,
              fontWeight: FontWeight.bold,
              color: AppTheme.appleBlack
            ),
          ),
        ],
      ),
    );
  }
}

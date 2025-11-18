import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/placing_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
 // 👈 Import your new screen

class PaymentOptionsSheet extends StatefulWidget {
  final VoidCallback onApplePay;
  final VoidCallback onGooglePay;
  final VoidCallback onCardPayment;
  final double totalAmount;

  const PaymentOptionsSheet({
    super.key,
    required this.onApplePay,
    required this.onGooglePay,
    required this.onCardPayment,
    required this.totalAmount,
  });

  @override
  State<PaymentOptionsSheet> createState() => _PaymentOptionsSheetState();
}

class _PaymentOptionsSheetState extends State<PaymentOptionsSheet> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppTheme.googleWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppTheme.appleBlack,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const Text(
            "Pay with",
            style: TextStyle(
              color: AppTheme.appleBlack,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),

          // Apple Pay
          _buildPaymentButton(
            context,
            svgPath: 'assets/apple.svg',
            label: "Apple Pay",
            paymentMethod: 'apple',
            onTap: () {
              setState(() {
                selectedPaymentMethod = 'apple';
              });
            },
          ),
          const SizedBox(height: 10),

          // Google Pay
          _buildPaymentButton(
            context,
            svgPath: 'assets/google_logo.svg',
            label: "Google Pay",
            paymentMethod: 'google',
            onTap: () {
              setState(() {
                selectedPaymentMethod = 'google';
              });
            },
          ),
          const SizedBox(height: 10),

          // Card Payment
          _buildPaymentButton(
            context,
            svgPath: 'assets/card_payment.svg',
            label: "Card Payment",
            subtitle: "Add Debit or Credit Card",
            paymentMethod: 'card',
            onTap: () {
              setState(() {
                selectedPaymentMethod = 'card';
              });
            },
          ),

          const SizedBox(height: 25),

          // Continue button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedPaymentMethod != null
                    ? AppTheme.brandPurple
                    : Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: selectedPaymentMethod != null
                  ? () {
                      // Call respective callback
                      if (selectedPaymentMethod == 'apple') {
                        widget.onApplePay();
                      } else if (selectedPaymentMethod == 'google') {
                        widget.onGooglePay();
                      } else if (selectedPaymentMethod == 'card') {
                        widget.onCardPayment();
                      }

                      // Close the bottom sheet
                      Navigator.pop(context);

                      // Navigate to the Place Order screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PlaceOrderScreen(),
                        ),
                      );
                    }
                  : null,
              child: Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedPaymentMethod != null
                      ? AppTheme.googleWhite
                      : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(
    BuildContext context, {
    required String svgPath,
    required String label,
    required String paymentMethod,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedPaymentMethod == paymentMethod;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppTheme.brandGreen : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
          color: isSelected
              // ignore: deprecated_member_use
              ? AppTheme.brandGreen.withOpacity(0.05)
              : AppTheme.googleWhite,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              height: 28,
              width: 28,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.appleBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppTheme.appleBlack,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.brandGreen,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

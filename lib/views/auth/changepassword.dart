import 'package:concession_tracker/app_theme.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = AppTheme.brandPurple;
    const Color borderColor = AppTheme.googleWhite;

    return Scaffold(
      backgroundColor: AppTheme.googleWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.googleWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.brandPurple),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: AppTheme.appleBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Password",
              style: TextStyle(color: AppTheme.appleBlack),
            ),
            const SizedBox(height: 6),
            TextField(
              cursorColor: AppTheme.appleBlack,
              controller: _currentPasswordController,
              obscureText: _obscureCurrent,
              style: const TextStyle(color: AppTheme.appleBlack),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: AppTheme.appleBlack),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureCurrent ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.appleBlack,
                  ),
                  onPressed: () =>
                      setState(() => _obscureCurrent = !_obscureCurrent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: borderColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "New Password",
              style: TextStyle(color: AppTheme.appleBlack),
            ),
            const SizedBox(height: 6),
            TextField(
              cursorColor: AppTheme.appleBlack,
              controller: _newPasswordController,
              obscureText: _obscureNew,
              style: const TextStyle(color: AppTheme.appleBlack),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: AppTheme.appleBlack),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNew ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.appleBlack,
                  ),
                  onPressed: () =>
                      setState(() => _obscureNew = !_obscureNew),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: borderColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Confirm Password",
              style: TextStyle(color: AppTheme.appleBlack),
            ),
            const SizedBox(height: 6),
            TextField(
              cursorColor: AppTheme.appleBlack,
              controller: _confirmPasswordController,
              obscureText: _obscureConfirm,
              style: const TextStyle(color: AppTheme.appleBlack),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: AppTheme.appleBlack),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.appleBlack,
                  ),
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: borderColor),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: primaryColor, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

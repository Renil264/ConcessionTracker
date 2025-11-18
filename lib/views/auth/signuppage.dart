import 'package:concession_tracker/app_theme.dart';
import 'package:concession_tracker/views/auth/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirpasswordController =
      TextEditingController();

  bool _obscurePassword = true;

  bool _acceptedTerms = false; // << CHANGE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.brandPurple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              " Lets get you started!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.appleBlack,
              ),
            ),
            const SizedBox(height: 30),

            const Text(" Name",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.appleBlack)),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text(" Email",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.appleBlack)),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Your Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text(" Password",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.appleBlack)),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppTheme.appleBlack,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // << CHANGE — Checkbox opens popup instead of toggling directly
            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  activeColor: AppTheme.brandPurple,
                  onChanged: (value) {
                    _showTermsPopup(); // << CHANGE
                  },
                ),
                const Expanded(
                  child: Text(
                    "I Agree to the Terms & Conditions",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.appleBlack),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

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
                  if (!_acceptedTerms) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Please accept the Terms & Conditions to continue")),
                    );
                    return;
                  }

                  if (kDebugMode) {
                    print("Signing up user: ${emailController.text}");
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Center(child: Text("or sign up with")),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton("assets/google_logo.svg"),
                _buildSocialButton("assets/facebook.svg"),
                _buildSocialButton("assets/apple.svg"),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        color: AppTheme.appleBlack, fontSize: 14),
                    children: [
                      TextSpan(text: "Have an account? "),
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                            color: AppTheme.brandPurple,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
  void _showTermsPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Terms & Conditions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: const SizedBox(
            height: 350,
            child: SingleChildScrollView(
              child: Text(
                """By using this application, you agree to the following terms:

1. **Account Responsibility**  
   You are responsible for maintaining the confidentiality of your login details.

2. **Accurate Information**  
   All information provided must be accurate and up to date.

3. **Acceptable Use**  
   You agree not to misuse, hack, or disrupt the app or its services.

4. **Privacy & Data Usage**  
   Your data may be used for improving user experience.  
   We will not share your personal information without consent.

5. **Service Changes**  
   The app may update features or policies at any time.

6. **Termination**  
   Violation of any terms may result in suspension of your access.

By clicking “I Agree,” you confirm that you have read and understood all the terms above.
                """,
                style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppTheme.appleBlack),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.brandPurple,
              ),
              onPressed: () {
                setState(() {
                  _acceptedTerms = true; // << CHANGE
                });
                Navigator.pop(context);
              },
              child: const Text("I Agree"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSocialButton(String assetPath) {
    bool isSvg = assetPath.toLowerCase().endsWith('.svg');

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 50,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.appleBlack),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isSvg
              ? SvgPicture.asset(assetPath, height: 24, width: 24)
              : Image.asset(assetPath, height: 24, width: 24),
        ),
      ),
    );
  }
}

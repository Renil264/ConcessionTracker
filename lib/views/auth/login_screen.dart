import 'package:concession_tracker/views/auth/forgotpasswordpage.dart';
import 'package:concession_tracker/views/auth/selectmarketpage.dart';
import 'package:concession_tracker/views/auth/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../../viewmodels/auth_view_model.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true; // 👈 For show/hide password
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.height * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: size.height * 0.02),

                /// Logo
                const _LogoBox(),
                SizedBox(height: size.height * 0.03),

                /// Title
                Text(
                  'Sign in your account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign up or log in to get started',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                /// Email Label + Field
                const Text(" Email Id", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.appleBlack),),
                const SizedBox(height: 5),
                TextField(
                  cursorColor: Colors.black, // 👈 black cursor
                  decoration: InputDecoration(
                    hintText: 'Your email',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 1.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(" Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.appleBlack)),
                const SizedBox(height:5),
                TextField(
                  cursorColor: Colors.black, // 👈 black cursor
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black, // 👈 force black color for icon
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 1.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          activeColor: AppTheme.brandPurple,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.appleBlack,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>  const ForgotPasswordPage()),
                    );
                        
                      },
                      child: const Text(
                        "Forgot password",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.brandPurple,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Sign in button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brandPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>  const SelectMarketPage()),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// OR Divider
                const OrDivider(),
                const SizedBox(height: 20),

                /// Facebook
                SocialButton(
                  style: SocialStyle.facebook,
                  label: 'Continue with Facebook',
                  icon: Icons.facebook,
                  onPressed: vm.isBusy ? null : () => vm.onFacebookTap(),
                ),
                const SizedBox(height: 14),

                /// Google
                SocialButton(
                  style: SocialStyle.google,
                  label: 'Continue with Google',
                  customIcon: SvgPicture.asset(
                    'assets/google_logo.svg',
                    width: 20,
                    height: 20,
                  ),
                  onPressed: vm.isBusy ? null : () => vm.onGoogleTap(context),

                ),
                const SizedBox(height: 14),

                /// Apple
                SocialButton(
                  style: SocialStyle.apple,
                  label: 'Continue with Apple',
                  icon: Icons.apple,
                  onPressed: vm.isBusy ? null : () => vm.onAppleTap(),
                ),

                const SizedBox(height: 20),

                /// Bottom text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>const SignUpPage() )
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppTheme.brandPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                if (vm.isBusy) ...[
                  const SizedBox(height: 18),
                  const _BusyBar(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BusyBar extends StatelessWidget {
  const _BusyBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.75),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Processing...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoBox extends StatelessWidget {
  const _LogoBox();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppTheme.brandPurple, width: 1.4),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.store_mall_directory,
                  size: width * 0.12,
                  color: AppTheme.brandPurple,
                ),
                SizedBox(height: width * 0.01),
                Text(
                  'LOGO',
                  style: TextStyle(
                    color: AppTheme.brandPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.07,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_theme.dart';
import 'viewmodels/auth_view_model.dart';
import 'views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize google_sign_in singleton with Web client id (serverClientId)
  await GoogleSignIn.instance.initialize(
    serverClientId: '680237986242-m7b4hq8fftq6rurtcufjd2bgr5dsvbna.apps.googleusercontent.com',
  );

  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store Login',
        theme: AppTheme.light,
        home: const LoginScreen(),
      ),
    );
  }
}

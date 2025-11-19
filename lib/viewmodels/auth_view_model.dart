import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> onFacebookTap() async => _fakeWork();
  Future<void> onAppleTap() async => _fakeWork(); 
  Future<void> onEmailTap() async => _fakeWork();


  Future<void> onGoogleTap(BuildContext context) async {
    _setBusy(true);
    try {
      final userCredential = await _signInWithGoogle();
      if (userCredential.user != null) {

        final idToken = await userCredential.user!.getIdToken();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const _PostSignInPlaceholder()),
        );
      }
    } on FirebaseAuthException catch (fae) {
      _showErrorDialog(context, 'Auth error', fae.message ?? fae.code);
    } catch (e) {
      _showErrorDialog(context, 'Sign in failed', e.toString());
    } finally {
      _setBusy(false);
    }
  }

  Future<void> signOut() async {
    _setBusy(true);
    try {
      await GoogleSignIn.instance.signOut();
      await FirebaseAuth.instance.signOut();
    } finally {
      _setBusy(false);
      notifyListeners();
    }
  }

  

  Future<UserCredential> _signInWithGoogle() async {

    final GoogleSignIn googleSignIn = GoogleSignIn.instance;


    final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

    if (googleUser == null) {

      throw Exception('Google sign-in cancelled');
    }


    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


    final String? idToken = googleAuth.idToken;
    if (idToken == null) {
      throw Exception('Google idToken is null. Ensure the Google Sign-In configuration is correct.');
    }

    
    final credential = GoogleAuthProvider.credential(idToken: idToken);

    // Sign in to Firebase with the credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
  
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}


class _PostSignInPlaceholder extends StatelessWidget {
  const _PostSignInPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signed in')),
      body: const Center(
        child: Text('Google sign-in successful. Replace this page with SelectMarketPage.'),
      ),
    );
  }
}

// Keep your fakeWork helper used elsewhere
Future<void> _fakeWork() async {
  // Intentionally left for placeholder functions used previously.
  await Future.delayed(const Duration(milliseconds: 700));
}

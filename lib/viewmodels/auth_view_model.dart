import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  Future<void> onFacebookTap() async => _fakeWork();
  Future<void> onGoogleTap() async => _fakeWork();
  Future<void> onAppleTap() async => _fakeWork();
  Future<void> onEmailTap() async => _fakeWork();

  Future<void> _fakeWork() async {
    _isBusy = true; notifyListeners();
    await Future.delayed(const Duration(milliseconds: 700));
    _isBusy = false; notifyListeners();
  }
}

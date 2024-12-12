import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginprovider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password, BuildContext context) async {
    if ((username == 'admin' && password == '0000') || (username == 'user' && password == '1234')) {
      // Update login state
      _isLoggedIn = true;
      notifyListeners();

      // Save login state to SharedPreferences
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setBool('isLoggedIn', true);

      // Navigate to home screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const ScreenHome()));
    } else {
      // Handle invalid login
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Username or password is incorrect.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

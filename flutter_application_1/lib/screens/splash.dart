import 'package:flutter/material.dart';
import 'package:flutter_application_1/commen/splashprovider.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/screens/login.dart'; // Import your Login screen
import 'package:provider/provider.dart';

class Screensplash extends StatelessWidget {
  const Screensplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context);

    // Call checkUserLoggedIn to update the isLoggedIn state
    splashProvider.checkUserLoggedIn();

    Future.delayed(const Duration(seconds: 3), () {
      if (splashProvider.isLoggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ScreenHome()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Screenlogin())); // Navigate to Login screen
      }
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/mylogo.png',
          height: 250,
        ),
      ),
    );
  }
}

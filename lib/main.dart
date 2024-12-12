import 'package:flutter/material.dart';
import 'package:flutter_application_1/commen/Addstudentprovider.dart';
import 'package:flutter_application_1/commen/loginprovider.dart';
import 'package:flutter_application_1/commen/splashprovider.dart';
import 'package:flutter_application_1/commen/studentsprovide.dart';
import 'package:flutter_application_1/screens/gridscreen.dart';
import 'package:flutter_application_1/screens/splash.dart';
import 'package:flutter_application_1/servises/functions.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializedatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Loginprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddStudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StudentListProvider(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Screensplash()),
    );
  }
}

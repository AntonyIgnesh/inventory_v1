import 'package:flutter/material.dart';
import 'package:inventory_v1/screens/login_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/view_products_screen.dart';
import 'screens/add_products_screen.dart';
import 'screens/update_products_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

void getInitLoginPrefs() async {}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: SplashScreen(),
      routes: {
        SplashScreen().id: (context) => SplashScreen(),
        LoginScreen().id: (context) => LoginScreen(),
        LandingScreen().id: (context) => LandingScreen(),
        '/updateProductsScreen': (context) => UpdateProductsScreen(),
        ViewProductsScreen().id: (context) => ViewProductsScreen(),
        AddProductsScreen().id: (context) => AddProductsScreen(),
      },
    );
  }
}

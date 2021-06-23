import 'package:flutter/material.dart';
import 'package:inventory_v1/screens/login_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/view_products_screen.dart';
import 'screens/add_products_screen.dart';
import 'screens/update_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: LoginScreen(),
      routes: {
        '/landingScreen': (context) => LandingScreen(),
        '/updateProductsScreen': (context) => UpdateProductsScreen(),
        '/viewProductsScreen': (context) => ViewProductsScreen(),
        '/addProductsScreen': (context) => AddProductsScreen(),
      },
    );
  }
}

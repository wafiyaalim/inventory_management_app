import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'categories_screen.dart';
import 'product_details.dart';

void main() {
  runApp(InventoryApp());
}

class InventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Removes the debug banner
      title: 'Inventory Management',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',  // Default route
      routes: {
        '/': (context) => HomeScreen(),  // Home Page
        '/categories': (context) => CategoriesScreen(),  // Category List Page
        '/product-details': (context) => ProductDetailsScreen(),  // Product Details Page
      },
    );
  }
}

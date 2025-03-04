import 'package:flutter/material.dart';
import 'package:inventory_management_app/products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Sports Category", "image": "assets/sports category.jpg"},
    {"name": "Fruits Category", "image": "assets/fruits category.jpg"},
    {"name": "Drinks Category", "image": "assets/drinks category.jpg"},
    {"name": "Snacks Category", "image": "assets/snacks category.jpg"},
    {"name": "Vegetables Category", "image": "assets/vegetables category.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(categories[index]['image']!, width: 50, height: 50),
              title: Text(categories[index]['name']!),
              subtitle: Text("View inventory"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

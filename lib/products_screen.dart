import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, animationDuration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF17982),
        title: Text("Inventory"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: "Sports"),
            Tab(text: "Fruits"),
            Tab(text: "Drinks"),
            Tab(text: "Snacks"),
            Tab(text: "Vegetables"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text("Sports (Coming Soon)")),
          FruitsInventory(),
          DrinksInventory(),
          SnacksInventory(),
          VegetablesInventory(),
        ],
      ),
    );
  }
}

// Inventory Screens
class FruitsInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildInventoryList([
      "Watermelon",
      "Apples",
      "Muskmelon",
      "Pineapple",
      "Oranges"
    ]);
  }
}

class DrinksInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildInventoryList([
      "Cold Drinks",
      "Juices",
      "Coffee",
      "Tea",
      "Water"
    ]);
  }
}

class SnacksInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildInventoryList([
      "Chips",
      "Chocolates",
      "Candies",
      "Cakes",
      "Fritters"
    ]);
  }
}

class VegetablesInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildInventoryList([
      "Root Vegetables",
      "Edible Stem Plants",
      "Starchy Vegetables",
      "Cruciferous Vegetables",
      "Beans, Peas, and Lentils"
    ]);
  }
}

// UI Components
Widget buildInventoryList(List<String> categories) {
  return ListView(
    padding: EdgeInsets.all(16),
    children: [
      ...categories.map((category) => buildExpandableCategory(category, getShopItems())),
      SizedBox(height: 20),
      addProductButton(),
    ],
  );
}

Widget buildExpandableCategory(String title, List<Widget> children) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Color(0xFFF17982), width: 1),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          children: children,
          tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
          childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        ),
      ),
    ),
  );
}

List<Widget> getShopItems() {
  return [
    buildShopItem("Shop 1", "Complete (95%)", Colors.green),
    buildShopItem("Shop 2", "Partial (50%)", Colors.yellow),
    buildShopItem("Shop 3", "Partial (30%)", Colors.orange),
    buildShopItem("Shop 4", "Almost empty (1%)", Colors.red),
  ];
}

Widget buildShopItem(String shop, String status, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Text(shop, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          status,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget addProductButton() {
  return Center(
    child: ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.add, color: Color(0xFFF17982)),
      label: Text("Add Product", style: TextStyle(color: Color(0xFFF17982))),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Color(0xFFF17982)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
  );
}

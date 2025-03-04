import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'product_details.dart';
import 'products_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(-1.0, 0), end: Offset(0, 0))
        .animate(_animationController);
  }

  void toggleDrawer() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFFE141D8),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: toggleDrawer, // Open animated drawer
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/logo.png', height: 150), // Warehouse Image
                SizedBox(height: 20),
                _buildNavButton(context, 'Read Product', 'Get the inventory for your shop', ProductDetailsScreen()),
                _buildNavButton(context, 'Edit/Update Product', 'You can update/edit your product details here', ProductDetailsScreen()),
                _buildNavButton(context, 'Map', 'List of shops using this app', null),
                _buildNavButton(context, 'Inventory', 'Categories of products', CategoriesScreen()),
              ],
            ),
          ),

          // Full-Screen Animated Drawer (No curve effect)
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Adjust width (80% of screen)
              height: double.infinity, // Full screen height
              color: Colors.white, // Background color
              child: Column(
                children: [
                  // Remove DrawerHeader for full height effect
                  Container(
                    color: Color(0xFFE141D8),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(Icons.person, size: 40, color: Color(0xFFE141D8)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Menu",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildDrawerItem(Icons.home, "Home", () => toggleDrawer()),
                        _buildDrawerItem(Icons.list, "Inventory", () => navigateTo(context, CategoriesScreen())),
                        _buildDrawerItem(Icons.shopping_cart, "Products", () => navigateTo(context, ProductsScreen())),
                        _buildDrawerItem(Icons.map, "Map", () => toggleDrawer()),
                        _buildDrawerItem(Icons.person, "Profile", () => toggleDrawer()),
                        _buildDrawerItem(Icons.menu_book, "Read", () => navigateTo(context, ProductDetailsScreen())),
                        _buildDrawerItem(Icons.update, "Update", () => navigateTo(context, ProductDetailsScreen())),
                        _buildDrawerItem(Icons.delete, "Delete", () => toggleDrawer(), Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, String subtitle, Widget? screen) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.list_alt),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          if (screen != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
          }
        },
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, [Color color = Colors.black]) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFE141D8)),
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }

  void navigateTo(BuildContext context, Widget screen) {
    toggleDrawer();
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

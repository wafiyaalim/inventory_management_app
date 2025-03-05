import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'categories_screen.dart';
import 'products_screen.dart';
import 'product_details.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  bool isEditing = false;
  TextEditingController firstNameController = TextEditingController(text: "John");
  TextEditingController lastNameController = TextEditingController(text: "Doe");
  TextEditingController emailController = TextEditingController(text: "johndoe@gmail.com");
  TextEditingController genderController = TextEditingController(text: "Male");
  TextEditingController ageController = TextEditingController(text: "25");
  String userType = "Shopkeeper"; // Default selection

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

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void toggleDrawer() {
    _animationController.isCompleted ? _animationController.reverse() : _animationController.forward();
  }

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFFF17982),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: toggleDrawer,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFF17982))),
                  SizedBox(height: 10),

                  // Profile Picture Placeholder
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Edit Button
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                      onPressed: toggleEdit,
                      icon: Icon(Icons.edit, color: Colors.purple),
                      label: Text("Edit", style: TextStyle(color: Colors.purple)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.purple),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  _buildTextField(firstNameController, "First Name"),
                  _buildTextField(lastNameController, "Last Name"),
                  _buildTextField(emailController, "Email"),
                  _buildTextField(genderController, "Gender"),
                  _buildTextField(ageController, "Age"),

                  SizedBox(height: 10),
                  Text("Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  _buildUserTypeRadio(),

                  SizedBox(height: 20),
                  Text("Shop Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple)),
                  SizedBox(height: 10),
                  _buildTextField(TextEditingController(text: "Shop 1"), "Shop", readOnly: true),
                  _buildTextField(TextEditingController(text: "Chembur Colony"), "Location", readOnly: true),
                ],
              ),
            ),
          ),

          // Animated Drawer
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Adjust width (80% of screen)
              height: double.infinity, // Full screen height
              color: Colors.white, // Background color
              child: Column(
                children: [
                  // Drawer Header
                  Container(
                    color: Color(0xFFF17982),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(Icons.person, size: 40, color: Color(0xFFF17982)),
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
                        _buildDrawerItem(Icons.home, "Home", () => navigateTo(context, HomeScreen())),
                        _buildDrawerItem(Icons.list, "Inventory", () => navigateTo(context, CategoriesScreen())),
                        _buildDrawerItem(Icons.shopping_cart, "Products", () => navigateTo(context, ProductsScreen())),
                        _buildDrawerItem(Icons.map, "Map", toggleDrawer),
                        _buildDrawerItem(Icons.person, "Profile", () => navigateTo(context, ProfileScreen())),
                        _buildDrawerItem(Icons.menu_book, "Read", () => navigateTo(context, ProductDetailsScreen())),
                        _buildDrawerItem(Icons.update, "Update", () => navigateTo(context, ProductDetailsScreen())),
                        _buildDrawerItem(Icons.delete, "Delete", toggleDrawer, Colors.black),
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

  Widget _buildTextField(TextEditingController controller, String label, {bool readOnly = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        readOnly: readOnly || !isEditing, // Only editable when isEditing is true
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildUserTypeRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _animatedRadioButton("Shopkeeper"),
        _animatedRadioButton("Manager"),
        _animatedRadioButton("Employee"),
      ],
    );
  }

  Widget _animatedRadioButton(String value) {
    return GestureDetector(
      onTap: isEditing
          ? () {
        setState(() {
          userType = value;
        });
      }
          : null,
      child: Row(
        children: [
          Icon(
            userType == value ? Icons.radio_button_checked : Icons.radio_button_off,
            color: Colors.purple,
          ),
          SizedBox(width: 5),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, [Color color = Colors.black]) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFF17982)),
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }
}

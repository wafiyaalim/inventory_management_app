import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: "BasketBall");
  TextEditingController priceController = TextEditingController(text: "₹450.00");
  TextEditingController quantityController = TextEditingController(text: "20");
  TextEditingController shopController = TextEditingController(text: "Shop 1");
  TextEditingController categoryController = TextEditingController(text: "Sports");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: Text("Inventory"),
          backgroundColor: Color(0xFFE141D8)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(nameController, "Product Name"),
              _buildTextField(priceController, "Price"),
              _buildTextField(quantityController, "Quantity"),
              _buildTextField(shopController, "Shop Name"),
              _buildTextField(categoryController, "Category"),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Add Product"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Product Added")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true, // Read-only fields for now
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

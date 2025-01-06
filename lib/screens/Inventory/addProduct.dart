import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purnomerchant/models/product.dart';

import '../../services/authService.dart';
import '../../services/inventoryService.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _gtnController = TextEditingController();
  final TextEditingController _unitTypeController = TextEditingController();
  final InventoryService inventoryService = Get.put(InventoryService());
  final AuthService authService = Get.put(AuthService());

  bool validateInputs() {
    // Validate product name
    if (_productNameController.text.isEmpty) {
      print("Product name cannot be empty.");
      return false;
    }

    // Validate price for correct format and non-negative values
    double? price = double.tryParse(_priceController.text);
    if (price == null || price < 0) {
      print("Invalid price. Please enter a valid non-negative number.");
      return false;
    }

    // Validate SKU (assuming it shouldn't be empty)
    if (_skuController.text.isEmpty) {
      print("SKU cannot be empty.");
      return false;
    }

    // Validate GTN (assuming it shouldn't be empty)
    if (_gtnController.text.isEmpty) {
      print("GTN cannot be empty.");
      return false;
    }

    // Validate stock for correct format and non-negative values
    double? stock = double.tryParse(_stockController.text);
    if (stock == null || stock < 0) {
      print("Invalid stock. Please enter a valid non-negative number.");
      return false;
    }

    // Validate unit type (assuming it shouldn't be empty)
    if (_unitTypeController.text.isEmpty) {
      print("Unit type cannot be empty.");
      return false;
    }

    // Validate category (assuming it shouldn't be empty)
    if (_categoryController.text.isEmpty) {
      print("Category cannot be empty.");
      return false;
    }

    // Optionally validate description if required
    if (_descriptionController.text.isEmpty) {
      print("Description cannot be empty.");
      return false;
    }

    // If all checks pass
    return true;
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            if (_image != null)
              Image.file(File(_image!.path)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
              validator: (value) => value!.isEmpty ? 'This field is required' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'This field is required' : null,
            ),
            TextFormField(
              controller: _stockController,
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: _skuController,
              decoration: InputDecoration(labelText: 'sku'),
            ),
            TextFormField(
              controller: _gtnController,
              decoration: InputDecoration(labelText: 'gtn'),
            ),
            TextFormField(
              controller: _unitTypeController,
              decoration: InputDecoration(labelText: 'unitType'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 if(validateInputs()){///conditions;
                   Product createdProduct = Product(productName: _productNameController.text, price: double.parse(_priceController.text), sku: _skuController.text, gtn: _gtnController.text, stock: double.parse(_stockController.text), unitType: _unitTypeController.text, description: _descriptionController.text, productImage: "", category: _categoryController.text, businessID: authService.businesses.first.uid, options: []);
                   inventoryService.addProduct(createdProduct, File(_image!.path));
                   Get.back();
                 }else{
                   Get.snackbar(
                     "Oops!",
                     "You missed something",
                     snackPosition: SnackPosition.BOTTOM,
                     backgroundColor: Colors.redAccent,
                     colorText: Colors.white,
                     duration: const Duration(seconds: 3),
                   );
                 }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selected = await _picker.pickImage(source: source);
    setState(() {
      _image = selected;
    });
  }
}

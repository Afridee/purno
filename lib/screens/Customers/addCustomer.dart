import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/customer.dart';
import '../../services/authService.dart';
import '../../services/crudService.dart';
import '../../services/customerService.dart';

class AddCustomerPage extends StatefulWidget {
  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _nameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedCustomerType;

  final CRUDService crudService = Get.put(CRUDService());
  final AuthService authService = Get.put(AuthService());
  final CustomerService customerService = Get.put(CustomerService());

  List<String> customerTypes = ['Regular', 'VIP', 'Wholesale'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CRUDService>(builder: (cs){
      return cs.isLoading ? Container(
          color: Colors.white,
          child: const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ))) : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Customer',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  suffixIcon: Icon(Icons.person, color: Colors.purple),
                ),
              ),
              SizedBox(height: 16),
              // Contact Number
              TextFormField(
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  suffixIcon: Icon(Icons.phone, color: Colors.purple),
                ),
              ),
              SizedBox(height: 16),
              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email (Optional)',
                  suffixIcon: Icon(Icons.email, color: Colors.purple),
                ),
              ),
              SizedBox(height: 16),
              // Customer Type
              DropdownButtonFormField<String>(
                value: _selectedCustomerType,
                hint: Text('Customer Type'),
                items: customerTypes
                    .map((type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCustomerType = newValue;
                  });
                },
              ),
              SizedBox(height: 30),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () async{
                    if (_nameController.text != "" &&
                        _contactNumberController.text != "" &&
                        _emailController.text != "" &&
                        _selectedCustomerType != null) {
                      Customer customer = Customer(name: _nameController.text, contactNumber: _contactNumberController.text, customerType: _selectedCustomerType!, businessID: authService.businesses.first.uid, email: _emailController.text);
                      await crudService.createCustomer(customer);
                      customerService.fetchCustomers();
                      Navigator.pop(context);
                    } else {
                      Get.snackbar(
                        "Error",
                        "You missed something!!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                      );
                    }
                    print('Save Customer');
                  },
                  child:
                  const Text('Save', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

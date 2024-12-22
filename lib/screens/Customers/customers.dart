import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/services/customerService.dart';

import '../../models/customer.dart';
import 'addCustomer.dart';
import 'customersDetails.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  // List of customer objects
  // List<Customer> customers = [
  //   Customer(
  //     name: 'Roy Kabir Chowdhury',
  //     contactNumber: '01711223102',
  //     email: 'deeeeepalom11@gmail.com',
  //     customerType: 'VIP', businessID: '',
  //   ),
  //   Customer(
  //     name: 'Deep Alomgir',
  //     contactNumber: '01711223344',
  //     email: 'deeeeepalom11@gmail.com',
  //     customerType: 'Regular', businessID: '',
  //   ),
  //   // Add more customers here as needed
  // ];

  TextEditingController _searchController = TextEditingController();
  final CustomerService customerService = Get.put(CustomerService());

  @override
  void initState() {
    customerService.fetchCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Customers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.purple),
            onPressed: () {
              Get.to(AddCustomerPage());
              print("Add new customer");
            },
          ),
        ],
      ),
      body: GetBuilder<CustomerService>(
        builder: (cs){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Customers',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                ),
                SizedBox(height: 20),
                // Display message when no customers are added
                cs.customers.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('No customers added', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Handle "Add a customer" action
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: Text('Add a customer', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
                    : Expanded(
                  child: ListView.builder(
                    itemCount: cs.customers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(cs.customers[index].name),
                          subtitle: Text(cs.customers[index].contactNumber),
                          trailing: cs.customers[index].email != null
                              ? Text(cs.customers[index].email ?? '')
                              : null,
                          onTap: () {
                            Get.to(CustomerDetailPage());
                            print("Tapped on ${cs.customers[index].name}");
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

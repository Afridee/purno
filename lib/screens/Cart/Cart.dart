import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purnomerchant/constants/themecolors.dart';

import '../../models/customer.dart';
import '../../models/customer_order.dart';
import '../../services/cartService.dart';
import '../../services/customerService.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  int discountPoints = 0;

  final CartService cartService = Get.put(CartService());
  final CustomerService customerService = Get.put(CustomerService());
  List<Customer> filteredCustomers = [];
  final FocusNode _focusNode1 = FocusNode();
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    queryController.addListener(querytextChanged);
    _focusNode1.addListener(() {
      if (_focusNode1.hasFocus) {
        filter(query: queryController.text);
      } else {
        filteredCustomers.clear();
        setState(() {});
      }
    });
    customerService.fetchCustomers();
    super.initState();
  }

  void querytextChanged() {
    filter(query: queryController.text);
  }

  filter({required String query}){
    filteredCustomers = customerService.customers.where((customer) => customer.name.toLowerCase().removeAllWhitespace.contains(query.toLowerCase().removeAllWhitespace)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartService>(builder: (cartS){
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(
            'Cart',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Keypad action
              },
              child: Text(
                'Keypad',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
        body: InkWell(
          splashColor: Colors.transparent,
          onTap: (){
            _focusNode1.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    controller: queryController,
                    focusNode: _focusNode1,
                    decoration: InputDecoration(
                      hintText: 'Search customer by name',
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      ),
                    ),
                  ),
                  !_focusNode1.hasFocus && cartS.selectedCustomer!=null ? Card(
                    color: light_purple.withOpacity(0.5),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(cartS.selectedCustomer!.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text(cartS.selectedCustomer!.contactNumber, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      trailing: cartS.selectedCustomer!.email != null
                          ? Text(cartS.selectedCustomer!.email ?? '',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                          : null,
                    ),
                  ) : Container(),
                  filteredCustomers.isNotEmpty && _focusNode1.hasFocus ? GetBuilder<CustomerService>(builder: (customerS){
                    return Container(
                      height: 300,
                      child: ListView.builder(
                          itemCount: filteredCustomers.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.grey.withOpacity(0.1),
                                child: InkWell(
                                  onTap: (){
                                    _focusNode1.unfocus();
                                    cartService.selectCustomer(customer: filteredCustomers[index]);
                                    print("Customer tapped");
                                  },
                                  child: ListTile(
                                    title: Text(filteredCustomers[index].name),
                                    subtitle: Text(filteredCustomers[index].email ?? ""),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }) : Container(),
                  const SizedBox(height: 16),
                  // Cart Items Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cart Items (${cartS.products.length})',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.expand_more, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Cart Items List
                  Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: cartS.products.length,
                      itemBuilder: (context, index) {
                        final item = cartS.products[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Product Image
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.productImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Product Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Product Name
                                      Text(
                                        item.productName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      // Product Price
                                      Text(
                                        '৳${item.price}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Quantity Adjustments and Delete Button
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Subtract Button
                                    IconButton(
                                      onPressed: () {
                                        cartService.decreaseQty(productIndex: index);
                                      },
                                      icon: Icon(Icons.remove, color: Colors.grey.shade800),
                                    ),
                                    // Quantity Text
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Add Button
                                    IconButton(
                                      onPressed: () {
                                        print(item.productImage);
                                        cartService.increaseQty(productIndex: index);
                                      },
                                      icon: Icon(Icons.add, color: Colors.purple),
                                    ),
                                    // Delete Button
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          cartService.removeFromCart(productIndex: index);
                                        });
                                      },
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Discounts Section
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Customer Points',
                      suffixText: 'Points',
                      suffixStyle: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.purple,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        discountPoints = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // Apply discount action
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple.shade50,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Apply discount',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.purple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Order Summary
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Summary Title
                      Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Order Items
                      Column(
                        children: cartS.products.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.productName} x ${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                Text(
                                  '৳${item.price * item.quantity}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const Divider(color: Colors.grey, height: 24),
                      // Total Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '৳${cartS.totalPrice}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Checkout Button
                  ElevatedButton(
                    onPressed: () async{
                      if(cartService.products.isNotEmpty && cartService.selectedCustomer!=null){
                        cartService.placeOrder();
                        Get.back();
                      }else{
                        Get.snackbar(
                          "Error!",
                          "missed Somethig!! Set a customer/add products",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Checkout',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

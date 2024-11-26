import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // Sample cart data
  final List<Map<String, dynamic>> cartItems = [
    {
      'image': 'assets/images/lays_demo.png', // Replace with your image path
      'name': 'Diet Coke (Can)',
      'price': 50,
      'quantity': 2,
      'selected': true,
    },
    {
      'image': 'assets/images/lays_demo.png',
      'name': 'Custom Payment',
      'price': 1282,
      'quantity': 2,
      'selected': true,
    },
    {
      'image': 'assets/images/lays_demo.png',
      'name': 'Spirit Drink',
      'price': 1282,
      'quantity': 2,
      'selected': true,
    },
    {
      'image': 'assets/images/lays_demo.png',
      'name': 'Kinder Joy (Boys)',
      'price': 80,
      'quantity': 1,
      'selected': true,
    },
  ];

  int discountPoints = 0;

  void adjustQuantity(int index, int delta) {
    setState(() {
      cartItems[index]['quantity'] =
          (cartItems[index]['quantity'] + delta).clamp(0, 100);
    });
  }

  void toggleSelection(int index) {
    setState(() {
      cartItems[index]['selected'] = !cartItems[index]['selected'];
    });
  }

  num get totalPrice => cartItems
      .where((item) => item['selected'])
      .map((item) => item['price'] * item['quantity'])
      .fold(0, (prev, curr) => prev + curr);

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Customer Name or Phone',
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
              const SizedBox(height: 16),
              // Cart Items Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cart Items (${cartItems.length})',
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
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
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
                            // Checkbox
                            Checkbox(
                              value: item['selected'],
                              activeColor: Colors.purple,
                              onChanged: (value) {
                                setState(() {
                                  item['selected'] = value!;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
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
                                child: Image.asset(
                                  item['image'],
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
                                    item['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Product Price
                                  Text(
                                    '৳${item['price']}',
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
                                    if (item['quantity'] > 0) {
                                      setState(() {
                                        item['quantity']--;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.remove, color: Colors.grey.shade800),
                                ),
                                // Quantity Text
                                Text(
                                  '${item['quantity']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Add Button
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      item['quantity']++;
                                    });
                                  },
                                  icon: Icon(Icons.add, color: Colors.purple),
                                ),
                                // Delete Button
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      cartItems.remove(item);
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
                    children: cartItems.map((item) {
                      if (item['selected']) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item['name']} x ${item['quantity']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Text(
                                '৳${item['price'] * item['quantity']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
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
                        '৳$totalPrice',
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
                onPressed: () {
                  // Checkout action
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
    );
  }
}

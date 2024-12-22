import 'package:flutter/material.dart';

class CustomerDetailPage extends StatefulWidget {
  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  String? selectedCustomerType;

  final List<Map<String, String>> orders = [
    {
      'orderId': '35001',
      'amount': '৳35005',
      'productCount': '110 Products',
      'orderStatus': 'On Hold',
      'customerName': 'MD Rayhan Uddin Si.',
      'orderTime': '3:05 PM',
    },
    {
      'orderId': '35002',
      'amount': '৳1500',
      'productCount': '50 Products',
      'orderStatus': 'Completed',
      'customerName': 'Alex Smith',
      'orderTime': '2:15 PM',
    },
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Customers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.purple),
            onPressed: () {
              // Add new customer functionality
              print("Add new customer");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Customer Detail Card
            Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Roy Kabir Chowdhury',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text('01711223102'),
                              Text('roykabir1231@gmail.com'),
                              Text('General Customer'),
                              Text('Account created on 30 Sept, 2024'),
                              Text('10.35K Purno points'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.phone, color: Colors.purple),
                          onPressed: () {
                            // Handle phone call functionality
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.email, color: Colors.purple),
                          onPressed: () {
                            // Handle email functionality
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Purchases Section
            Text(
              'Purchases',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: orders.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         margin: EdgeInsets.symmetric(vertical: 8),
            //         child: ListTile(
            //           title: Text('Order #${orders[index]['orderNumber']}'),
            //           subtitle: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(orders[index]['amount']!),
            //               Text(orders[index]['products']!),
            //               Row(
            //                 children: [
            //                   Text(orders[index]['status']!),
            //                   SizedBox(width: 10),
            //                   Text(orders[index]['date']!),
            //                   SizedBox(width: 10),
            //                   Text(orders[index]['time']!),
            //                 ],
            //               ),
            //             ],
            //           ),
            //           trailing: Icon(Icons.arrow_forward),
            //           onTap: () {
            //             // Handle order tap (show order details)
            //             print("Tapped on Order #${orders[index]['orderNumber']}");
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(child: ListView.builder(
              itemCount: orders.length, // The number of items in the list
              itemBuilder: (context, index) {
                // Get the order details from the list
                final order = orders[index];
                return OrderCard(
                  orderId: order['orderId']!,
                  amount: order['amount']!,
                  productCount: order['productCount']!,
                  orderStatus: order['orderStatus']!,
                  customerName: order['customerName']!,
                  orderTime: order['orderTime']!,
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}


class OrderCard extends StatelessWidget {
  final String orderId;
  final String amount;
  final String productCount;
  final String orderStatus;
  final String customerName;
  final String orderTime;

  OrderCard({
    required this.orderId,
    required this.amount,
    required this.productCount,
    required this.orderStatus,
    required this.customerName,
    required this.orderTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Row(
          children: [
            Icon(Icons.monetization_on, color: Colors.purple),
            SizedBox(width: 8),
            Text('Order #$orderId', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('$productCount', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: orderStatus == 'On Hold' ? Colors.yellow : Colors.green,
                  size: 12,
                ),
                SizedBox(width: 5),
                Text(orderStatus, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(width: 10),
                Text(customerName, style: TextStyle(fontSize: 14)),
                SizedBox(width: 10),
                Text(orderTime, style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle tap, navigate to order details
        },
      ),
    );
  }
}




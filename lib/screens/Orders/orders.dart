

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:purnomerchant/services/crudService.dart';

import '../../services/ordersService.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  final OrderService orderService = Get.put(OrderService());

  @override
  void initState() {
    orderService.fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(
      builder: (os){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Orders',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              Expanded(child: ListView.builder(
                itemCount: os.orders.length, // The number of items in the list
                itemBuilder: (context, index) {
                  // Get the order details from the list
                  final order = os.orders[index];
                  return OrderCard(
                    orderId: order.orderId,
                    amount: order.totalAmount.toStringAsFixed(3),
                    productCount: order.products.length.toString(),
                    orderStatus: order.status,
                    customerName: order.customer.name,
                    orderTime: order.orderPlacedAt,
                  );
                },
              )),
            ],
          ),
        );
      }
    );
  }
}


class OrderCard extends StatelessWidget {
  final String orderId;
  final String amount;
  final String productCount;
  final String orderStatus;
  final String customerName;
  final DateTime orderTime;

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
            Text('Order #${orderId.substring(0,8)}', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("৳ "+ amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(DateFormat('MMMM dd, yyyy - hh:mm a').format(orderTime), style: TextStyle(fontSize: 14, color: Colors.grey)),
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
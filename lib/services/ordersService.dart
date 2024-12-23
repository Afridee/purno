import 'package:get/get.dart';
import 'package:purnomerchant/models/customer_order.dart';

import 'authService.dart';
import 'crudService.dart';

class OrderService extends GetxController {
  final CRUDService crudService = Get.put(CRUDService());
  final AuthService authService = Get.put(AuthService());

  List<CustomerOrder> orders = [];

  fetchOrders() async{
    orders = await crudService.fetchCustomerOrders();
    print(orders);
    update();
  }
}
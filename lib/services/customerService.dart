
import 'package:get/get.dart';
import '../models/customer.dart'; // Replace with the actual path to your Customer model
import '../models/customer_order.dart';
import 'crudService.dart'; // Replace with the actual path to your CustomerOrder model


class CustomerService extends GetxController {
  final CRUDService crudService = Get.put(CRUDService());

  List<Customer> customers = [];

  fetchCustomers() async{
    customers =  await crudService.fetchCustomers();
    update();
  }
}
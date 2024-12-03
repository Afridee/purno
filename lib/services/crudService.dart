import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/product.dart'; // Replace with the actual path to your Product model
import '../models/customer.dart'; // Replace with the actual path to your Customer model
import '../models/customer_order.dart'; // Replace with the actual path to your CustomerOrder model
import '../models/business.dart'; // Replace with the actual path to your Business model

class CRUDService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ===================== Products =====================

  Future<void> createProduct(Product product) async {
    final doc = _firestore.collection('products').doc();
    final productId = doc.id;
    await doc.set({'productId': productId, ...product.toJson()});
  }

  Future<List<Product>> fetchProducts() async {
    final querySnapshot = await _firestore.collection('products').get();
    return querySnapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateProduct(String productId, Map<String, dynamic> updatedData) async {
    await _firestore.collection('products').doc(productId).update(updatedData);
  }

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  /// ===================== Customers =====================

  Future<void> createCustomer(Customer customer) async {
    final doc = _firestore.collection('customers').doc();
    final customerId = doc.id;
    await doc.set({'customerId': customerId, ...customer.toJson()});
  }

  Future<List<Customer>> fetchCustomers() async {
    final querySnapshot = await _firestore.collection('customers').get();
    return querySnapshot.docs
        .map((doc) => Customer.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateCustomer(String customerId, Map<String, dynamic> updatedData) async {
    await _firestore.collection('customers').doc(customerId).update(updatedData);
  }

  Future<void> deleteCustomer(String customerId) async {
    await _firestore.collection('customers').doc(customerId).delete();
  }

  /// ===================== Customer Orders =====================

  Future<void> createCustomerOrder(CustomerOrder order) async {
    final doc = _firestore.collection('orders').doc();
    final orderId = doc.id;
    await doc.set({'orderId': orderId, ...order.toJson()});
  }

  Future<List<CustomerOrder>> fetchCustomerOrders() async {
    final querySnapshot = await _firestore.collection('orders').get();
    return querySnapshot.docs
        .map((doc) => CustomerOrder.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<CustomerOrder>> fetchCustomerOrdersByCustomer(String customerId) async {
    final querySnapshot = await _firestore
        .collection('orders')
        .where('customer.customerId', isEqualTo: customerId)
        .get();
    return querySnapshot.docs
        .map((doc) => CustomerOrder.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateCustomerOrder(String orderId, Map<String, dynamic> updatedData) async {
    await _firestore.collection('orders').doc(orderId).update(updatedData);
  }

  Future<void> deleteCustomerOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }

  /// ===================== Businesses =====================

  Future<void> createBusiness(Business business) async {
    final doc = _firestore.collection('businesses').doc();
    final businessId = doc.id;
    await doc.set({'businessId': businessId, ...business.toJson()});
  }

  Future<List<Business>> fetchBusinesses() async {
    final querySnapshot = await _firestore.collection('businesses').get();
    return querySnapshot.docs
        .map((doc) => Business.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<Business?> fetchBusinessById(String businessId) async {
    final doc = await _firestore.collection('businesses').doc(businessId).get();
    if (doc.exists) {
      return Business.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> updateBusiness(String businessId, Map<String, dynamic> updatedData) async {
    await _firestore.collection('businesses').doc(businessId).update(updatedData);
  }

  Future<void> deleteBusiness(String businessId) async {
    await _firestore.collection('businesses').doc(businessId).delete();
  }

  Future<void> updateBusinessPeople(String businessId, List<Person> newPeople) async {
    await _firestore.collection('businesses').doc(businessId).update({
      'people': newPeople.map((person) => person.toJson()).toList(),
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart'; // Replace with the actual path to your Product model
import '../models/customer.dart'; // Replace with the actual path to your Customer model
import '../models/customer_order.dart'; // Replace with the actual path to your CustomerOrder model
import '../models/business.dart';
import '../models/user.dart'; // Replace with the actual path to your Business model

class CRUDService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  /// ===================== Create User =====================
  Future<void> createUser(User user) async {
    isLoading = true;
    update();

    try{
      final docUser = _firestore.collection('users').doc(user.uid); // Use uid as document ID
      await docUser.set(user.toJson());
    }catch(e){
      Get.snackbar(
        "Oops!",
        "Something went wrong!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    isLoading = true;
    update();
  }

  /// ===================== Read User by UID =====================
  Future<User?> fetchUserById(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return User.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null; // Return null if user doesn't exist
    }
  }

  /// ===================== Read All Users =====================
  Future<List<User>> fetchAllUsers() async {
    final querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// ===================== Fetch User by Phone Number =====================
  Future<User?> fetchUserByPhoneNumber(String phoneNumber) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('contactNumber', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return User.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      return null; // Return null if no user is found
    }
  }

  /// ===================== Update User =====================
  Future<void> updateUser(String uid, Map<String, dynamic> updatedData) async {
    await _firestore.collection('users').doc(uid).update(updatedData);
  }

  /// ===================== Delete User =====================
  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

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

    isLoading = true;
    update();

    try {
      final doc = _firestore.collection('customers').doc();
      final customerId = doc.id;
      await doc.set({'customerId': customerId, ...customer.toJson()});
      Get.snackbar(
        "Oops!",
        "Customer created!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Oops!",
        "Something went wrong!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    isLoading = false;
    update();
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

    isLoading = true;
    update();

    try {
      final doc = _firestore.collection('orders').doc();
      final orderId = doc.id;
      await doc.set({'orderId': orderId, ...order.toJson()});
      Get.snackbar(
        "Success!",
        "Order placed successfully!!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Oops!",
        "Something went wrong!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    isLoading = false;
    update();
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

   isLoading = true;
   update();

   try{
     final docBusiness = _firestore.collection('businesses').doc(business.uid);
     await docBusiness.set(business.toJson());
   }catch(e){
     Get.snackbar(
       "Oops!",
       "Something went wrong!",
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.redAccent,
       colorText: Colors.white,
       duration: const Duration(seconds: 3),
     );
   }

   isLoading = false;
   update();
  }

  Future<List<Business>> fetchBusinesses() async {
    final querySnapshot = await _firestore.collection('businesses').get();
    return querySnapshot.docs
        .map((doc) => Business.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Business>> fetchBusinessByUser(String userUid) async {
    final querySnapshot = await _firestore.collection('businesses').get();

    // Filter businesses where the user exists in the 'people' list
    final businesses = querySnapshot.docs.where((doc) {
      final businessData = doc.data() as Map<String, dynamic>;
      final peopleList = businessData['people'] as List;

      // Check if the 'people' list contains the user with the given UID
      return peopleList.any((person) => person['user']['uid'] == userUid);
    }).map((doc) => Business.fromJson(doc.data() as Map<String, dynamic>)).toList();

    return businesses;
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

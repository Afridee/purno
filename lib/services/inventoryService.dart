import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/services/storageService.dart';
import '../models/customer.dart'; // Replace with the actual path to your Customer model
import '../models/product.dart';
import 'authService.dart';
import 'crudService.dart'; // Replace with the actual path to your CustomerOrder model


class InventoryService extends GetxController {
  final CRUDService crudService = Get.put(CRUDService());
  final AuthService authService = Get.put(AuthService());
  final StorageService storageService = Get.put(StorageService());

  List<Customer> customers = [];
  bool isLoading = false;

  List<Product> productList = [
    Product(
      productName: 'Imported Russian Diet Coke',
      price: 500.0,
      sku: '35001202',
      gtn: '20221202',
      stock: 50.0,
      unitType: 'pieces',
      description: 'Imported Russian Diet Coke in a can.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Beverages',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Deshi Shagor Bananas',
      price: 200.0,
      sku: '35001203',
      gtn: '20221203',
      stock: 100.0,
      unitType: 'kg',
      description: 'Fresh and ripe Deshi Shagor Bananas.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Imported Organic Swedish Apples',
      price: 200.0,
      sku: '35001204',
      gtn: '20221204',
      stock: 30.0,
      unitType: 'kg',
      description: 'Fresh organic Swedish apples.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Walton HS-15 Professional Juicer',
      price: 5200.0,
      sku: '35001205',
      gtn: '20221205',
      stock: 20.0,
      unitType: 'pieces',
      description: 'Professional juicer with multiple speed settings.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Electronics',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Red Grapes',
      price: 100.0,
      sku: '35001206',
      gtn: '20221206',
      stock: 75.0,
      unitType: 'kg',
      description: 'Fresh and sweet red grapes.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Malaysian Oranges',
      price: 320.0,
      sku: '35001207',
      gtn: '20221207',
      stock: 60.0,
      unitType: 'kg',
      description: 'Juicy and sweet Malaysian oranges.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Apple iPhone 14 Pro',
      price: 1299.0,
      sku: '35001208',
      gtn: '20221208',
      stock: 100.0,
      unitType: 'pieces',
      description: 'Apple iPhone 14 Pro with 128GB storage.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Electronics',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Samsung Galaxy S21',
      price: 999.0,
      sku: '35001209',
      gtn: '20221209',
      stock: 50.0,
      unitType: 'pieces',
      description: 'Samsung Galaxy S21 with 256GB storage.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Electronics',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Fresh Broccoli',
      price: 150.0,
      sku: '35001210',
      gtn: '20221210',
      stock: 120.0,
      unitType: 'kg',
      description: 'Fresh, green and crunchy broccoli.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Fruits & Vegetables',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Coca Cola 500ml',
      price: 100.0,
      sku: '35001211',
      gtn: '20221211',
      stock: 200.0,
      unitType: 'pieces',
      description: 'Coca Cola 500ml bottle.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Beverages',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Nestle KitKat',
      price: 50.0,
      sku: '35001212',
      gtn: '20221212',
      stock: 150.0,
      unitType: 'pieces',
      description: 'Nestle KitKat chocolate bar.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Snacks',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Lays Classic Chips',
      price: 120.0,
      sku: '35001213',
      gtn: '20221213',
      stock: 80.0,
      unitType: 'pieces',
      description: 'Lays Classic Chips, a savory snack.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Snacks',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Toshiba 1TB Hard Drive',
      price: 4500.0,
      sku: '35001214',
      gtn: '20221214',
      stock: 30.0,
      unitType: 'pieces',
      description: 'Toshiba 1TB external hard drive.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Electronics',
      businessID: "", options: [],
    ),
    Product(
      productName: 'Whirlpool Refrigerator',
      price: 18999.0,
      sku: '35001215',
      gtn: '20221215',
      stock: 10.0,
      unitType: 'pieces',
      description: 'Whirlpool 320L refrigerator with energy saving mode.',
      productImage: 'https://firebasestorage.googleapis.com/v0/b/purno-7e189.firebasestorage.app/o/Screenshot%202024-12-22%20at%2010.56.11%E2%80%AFPM.png?alt=media&token=533662df-b19d-4d98-8f16-e8a530812f68',
      category: 'Electronics',
      businessID: "", options: [],
    ),
  ];

  fetchProducts() async{
    productList = await crudService.fetchProducts(yourBusinessId: authService.businesses.first.uid);
    update();
  }

  addProduct(Product product, File img) async{

    isLoading = true;
    update();

    String? fileURL =  await storageService.uploadImageAndGetURL(img);

    if(fileURL!=null){
      product.productImage = fileURL;
      try {
        await crudService.createProduct(product);
        Get.snackbar(
                "Success!",
                "Product added successfully!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
              );
        fetchProducts();
      } catch (e) {
        Get.snackbar(
          "Error!",
          "while adding product to inventory",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    }else{
      Get.snackbar(
        "Error!",
        "while adding product to inventory",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    isLoading = false;
    update();
  }


}
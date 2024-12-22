import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/constants/themecolors.dart';
import 'package:purnomerchant/models/customer_order.dart';
import '../../models/product.dart';
import '../../services/cartService.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.productList,
  });

  final List<Product> productList;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search products',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
          const SizedBox(height: 10),
          // Grid View for Products
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Number of columns in the grid
                crossAxisSpacing: 10,  // Horizontal space between grid items
                mainAxisSpacing: 10,  // Vertical space between grid items
                childAspectRatio: 0.75,  // Adjust height/width ratio for items
              ),
              itemCount: widget.productList.length, // Total number of products
              itemBuilder: (context, index) {
                return ProductCard(product: widget.productList[index]); // Product card widget
              },
            ),
          ),
          // Cart Summary and Button
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {

  final Product product;
  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final CartService cartService = Get.put(CartService());
    return Card(
      color: Colors.white,
      elevation: 10, // Adds a more prominent shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for a classier look
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Ensures the child widgets stay rounded
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)), // Rounded top corners for the image
                image: DecorationImage(
                  image: NetworkImage(product.productImage), // Replace with actual image URL
                  fit: BoxFit.cover, // Ensure the image covers the area without distortion
                ),
              ),
            ),
            // Product details section
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Container(
                    height: 32,
                    child: AutoSizeText(
                      product.productName,  // Replace with actual product name
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600, // Make the product name stand out
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Product price
                  Text(
                    '৳ ${product.price}',  // Replace with actual product price
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  // Add to Cart Button
                  ElevatedButton(
                    onPressed: () {
                      cartService.addToCart(product: OrderProduct(productName: product.productName, category: product.category, price: product.price, quantity: 1, unitType: product.unitType, productImage: product.productImage));
                      Get.snackbar(
                        "Added to cart",
                        "...",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: light_purple,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: light_purple, // Button color
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Rounded button for a modern look
                      ),
                    ),
                    child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
                  ),
                  // Optional: Icon buttons for likes, ratings, etc.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
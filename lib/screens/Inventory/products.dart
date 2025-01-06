import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:purnomerchant/screens/Inventory/addProduct.dart';
import 'package:purnomerchant/screens/Inventory/addstockperpiece.dart';
import 'package:purnomerchant/screens/Inventory/filterProducts.dart';
import 'package:purnomerchant/screens/Inventory/sortProducts.dart';
import 'package:purnomerchant/services/inventoryService.dart';

import '../../models/product.dart';
import '../../services/authService.dart';

class InventoryProducts extends StatefulWidget {
  @override
  _InventoryProductsState createState() => _InventoryProductsState();
}

class _InventoryProductsState extends State<InventoryProducts> {
  int selectedTabIndex = 0;
  final InventoryService inventoryService = Get.put(InventoryService());

  @override
  void initState() {
    inventoryService.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventoryService>(builder: (iser) {
      return iser.isLoading
          ? Container(
              color: Colors.white,
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.purple,
              )))
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                title: Text(
                  'Inventory',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.to(AddProduct());
                    },
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FlutterToggleTab(
                      width: 90,
                      borderRadius: 30,
                      selectedTextStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      unSelectedTextStyle: GoogleFonts.roboto(
                        color: Colors.grey,
                      ),
                      labels: ['All', 'Low Stock'],
                      selectedIndex: selectedTabIndex,
                      selectedLabelIndex: (index) {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                      selectedBackgroundColors: [Colors.purple],
                      unSelectedBackgroundColors: [Colors.grey.shade200],
                    ),
                  ),
                  SearchFilterSortWidget(
                    onFilterTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FilterProducts(),
                        ),
                      );
                    },
                    onSearch: (val) {},
                    onSortTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SortProducts(),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: iser.productList.length,
                      itemBuilder: (context, index) {
                        final product = iser.productList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddStockPerPrice(product: product),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category and Arrow Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.category,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward,
                                        color: Colors.black54),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Product Name and Options Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.productName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '1 option',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Stock and Status Row
                                Row(
                                  children: [
                                    Text(
                                      '${product.stock}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: product.stock > 10
                                            ? Colors.green.withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        product.stock > 10
                                            ? "Good Stock"
                                            : "Low Stock",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: product.stock > 10
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // SKU and GTIN Information
                                Text(
                                  'SKU: ${product.sku} • GTIN: ${product.gtn}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
    });
  }
}

class SearchFilterSortWidget extends StatelessWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;
  final ValueChanged<String> onSearch;

  const SearchFilterSortWidget({
    Key? key,
    required this.onFilterTap,
    required this.onSortTap,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: 'Search product',
              hintStyle: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
        ),
        // Filter and Sort buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              // Filter Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onFilterTap,
                  icon: Icon(
                    Icons.filter_alt,
                    color: Colors.purple,
                  ),
                  label: Text(
                    'Filter',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade50,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16), // Spacing between buttons
              // Sort Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSortTap,
                  icon: Icon(
                    Icons.sort,
                    color: Colors.purple,
                  ),
                  label: Text(
                    'Sort',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade50,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

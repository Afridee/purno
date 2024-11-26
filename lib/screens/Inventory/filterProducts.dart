import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterProducts extends StatefulWidget {
  const FilterProducts({super.key});

  @override
  FilterProductsState createState() => FilterProductsState();
}

class FilterProductsState extends State<FilterProducts> {
  bool inStock = false;
  final List<Map<String, dynamic>> categories = [
    {'name': 'Chocolates', 'selected': true},
    {'name': 'Snacks', 'selected': false},
    {'name': 'Vegetables and fruits', 'selected': false},
  ];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Products',
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
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add product action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter products section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter products',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    // Clear filters action
                  },
                ),
              ],
            ),
            CheckboxListTile(
              title: Text(
                'In stock',
                style: GoogleFonts.roboto(fontSize: 14),
              ),
              value: inStock,
              activeColor: Colors.purple,
              onChanged: (value) {
                setState(() {
                  inStock = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 16),
            // Filter by categories section
            Text(
              'Filter by categories',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            // Search bar for categories
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Categories',
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
            const SizedBox(height: 8),
            // List of categories
            Expanded(
              child: ListView(
                children: categories
                    .where((category) => category['name']
                    .toLowerCase()
                    .contains(searchQuery))
                    .map((category) {
                  return CheckboxListTile(
                    title: Text(
                      category['name'],
                      style: GoogleFonts.roboto(fontSize: 14),
                    ),
                    value: category['selected'],
                    activeColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        category['selected'] = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }).toList(),
              ),
            ),
            // Search button
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Apply filters action
                  print('Filters applied:');
                  print('In stock: $inStock');
                  print('Selected categories: ${categories.where((category) => category['selected']).map((category) => category['name']).toList()}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Search',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

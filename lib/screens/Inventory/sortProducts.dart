import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SortProducts extends StatefulWidget {
  const SortProducts({super.key});

  @override
  SortProductsState createState() => SortProductsState();
}

class SortProductsState extends State<SortProducts> {
  String? selectedOption = 'Price: High → Low'; // Default selected option

  final List<String> sortOptions = [
    'Stock: High → Low',
    'Stock: Low → High',
    'Price: High → Low',
    'Price: Low → High',
    'Newest',
    'Best Selling',
    'Latest stock updated',
    'Latest edited',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Products',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
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
              // Add new product action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Stocks are sorted according to quantity regardless of their alert state',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Section Title
            Text(
              'Sort products',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            // Sort Options
            Expanded(
              child: ListView.builder(
                itemCount: sortOptions.length,
                itemBuilder: (context, index) {
                  final option = sortOptions[index];
                  return RadioListTile<String>(
                    title: Text(
                      option,
                      style: GoogleFonts.roboto(fontSize: 14),
                    ),
                    value: option,
                    groupValue: selectedOption,
                    activeColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  );
                },
              ),
            ),
            // Search Button
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Perform search action
                  print('Selected option: $selectedOption');
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddStockPerPrice extends StatefulWidget {
  @override
  _AddStockPerPriceState createState() => _AddStockPerPriceState();
}

class _AddStockPerPriceState extends State<AddStockPerPrice> {
  int stock = 50; // Initial stock value

  void addStock(int value) {
    setState(() {
      stock += value;
    });
  }

  void subtractStock(int value) {
    setState(() {
      if (stock - value >= 0) stock -= value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Inventory',
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
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Additional options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image and Name
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/lays_demo.png', // Replace with your image asset path
                    height: 100,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Lay's Salt and Pepper",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Snacks',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Crispy and tangy flavour of salt and pepper at every bite. Now, includes an extra 10g',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Product Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.grey.shade300),
                _buildDetailRow('Price', '৳100 per kg'),
                _buildDetailRow('Brand', "Lay's"),
                _buildDetailRow('SKU', '35001202'),
                _buildDetailRow('GTIN', '20221202'),
                _buildDetailRow('Stock', '$stock kg'),
                Divider(color: Colors.grey.shade300),
              ],
            ),
            const SizedBox(height: 12),
            // Edit Product Button
            Center(
              child: TextButton(
                onPressed: () {
                  // Edit product action
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.purple.shade50,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Edit product',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Add Stock Section
            Text(
              'Add stock',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Subtract Button
                IconButton(
                  onPressed: () => subtractStock(1),
                  icon: Icon(Icons.remove, color: Colors.purple),
                  color: Colors.purple.shade50,
                  iconSize: 24,
                ),
                // Stock Value Display
                Text(
                  '$stock kg',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add Button
                IconButton(
                  onPressed: () => addStock(1),
                  icon: Icon(Icons.add, color: Colors.purple),
                  color: Colors.purple.shade50,
                  iconSize: 24,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Quick Add Stock Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickAddButton('+5', 5),
                _buildQuickAddButton('+10', 10),
                _buildQuickAddButton('+25', 25),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddButton(String label, int value) {
    return ElevatedButton(
      onPressed: () => addStock(value),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.shade50,
        elevation: 0,
        minimumSize: const Size(100, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.purple,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

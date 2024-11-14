import 'package:flutter/material.dart';
import 'package:purnomerchant/constants/themecolors.dart';


class ShopSetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back action
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle skip action
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.purple, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Title
            Text(
              'Shop setup',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            // Subtitle
            Text(
              'Help us set up your shop or business',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),

            // Logo Upload Section
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.add, color: Colors.grey),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle upload logo action
                      },
                      style: ElevatedButton.styleFrom(
                        primary: light_purple,
                        minimumSize: Size(160, 40),
                      ),
                      child: Text('Upload business logo', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 5),
                    OutlinedButton(
                      onPressed: () {
                        // Handle take photo action
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.purple,
                        minimumSize: Size(160, 40),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text('Take photo of logo'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Business Name TextField
            TextField(
              decoration: InputDecoration(
                hintText: 'Business Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Contact Number TextField
            TextField(
              decoration: InputDecoration(
                hintText: 'Business Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Address TextField with "Mark in map" Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Business Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle mark in map action
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[50],
                    minimumSize: Size(90, 50),
                  ),
                  child: Text(
                    'Mark in map',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Business Type Dropdown
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(child: Text('Retail'), value: 'Retail'),
                DropdownMenuItem(child: Text('Wholesale'), value: 'Wholesale'),
                DropdownMenuItem(child: Text('Service'), value: 'Service'),
              ],
              onChanged: (value) {
                // Handle business type selection
              },
              decoration: InputDecoration(
                hintText: 'Select Business Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Business Description TextArea
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe your business (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            Spacer(),

            // Disabled Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null, // Disable the button initially
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300], // Disabled color
                  onPrimary: Colors.grey[600], // Disabled text color
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

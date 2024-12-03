import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/constants/themecolors.dart';
import 'package:purnomerchant/models/business.dart';
import 'package:uuid/uuid.dart';

import '../../../services/authService.dart';
import '../../../services/crudService.dart';
import '../../Account and Setting/account.dart';
import '../../Home.dart';
import '../../conditions/introOrElse.dart';

class ShopSetupPage extends StatefulWidget {
  @override
  _ShopSetupPageState createState() => _ShopSetupPageState();
}

class _ShopSetupPageState extends State<ShopSetupPage> {
  // Controllers for TextFields
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessContactController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  final TextEditingController businessDescriptionController = TextEditingController();

  // Variable to store selected business type
  String? selectedBusinessType;

  final AuthService authService = Get.put(AuthService());
  final CRUDService crudService = Get.put(CRUDService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back action
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle skip action
            },
            child: const Text(
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
            const SizedBox(height: 20),

            // Title
            const Text(
              'Shop setup',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              'Help us set up your shop or business',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),

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
                  child: const Icon(Icons.add, color: Colors.grey),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle upload logo action
                      },
                      style: ElevatedButton.styleFrom(
                        primary: light_purple,
                        minimumSize: const Size(160, 40),
                      ),
                      child: const Text('Upload business logo', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 5),
                    // OutlinedButton(
                    //   onPressed: () {
                    //     // Handle take photo action
                    //   },
                    //   style: OutlinedButton.styleFrom(
                    //     primary: Colors.purple,
                    //     minimumSize: Size(160, 40),
                    //     side: BorderSide(color: Colors.grey[300]!),
                    //   ),
                    //   child: Text('Take photo of logo'),
                    // ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Business Name TextField
            TextField(
              controller: businessNameController,
              decoration: InputDecoration(
                hintText: 'Business Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Number TextField
            TextField(
              controller: businessContactController,
              decoration: InputDecoration(
                hintText: 'Business Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Address TextField
            TextField(
              controller: businessAddressController,
              decoration: InputDecoration(
                hintText: 'Business Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Business Type Dropdown
            DropdownButtonFormField<String>(
              value: selectedBusinessType,
              items: [
                const DropdownMenuItem(child: Text('Retail'), value: 'Retail'),
                const DropdownMenuItem(child: Text('Wholesale'), value: 'Wholesale'),
                const DropdownMenuItem(child: Text('Service'), value: 'Service'),
              ],
              onChanged: (value) {
                setState(() {
                  selectedBusinessType = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Select Business Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Business Description TextArea
            TextField(
              controller: businessDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe your business (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const Spacer(),

            // Disabled Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  var uuid = const Uuid();
                  Business business = Business(uid: uuid.v1(), businessName: businessNameController.text, businessContactNumber: businessContactController.text, businessAddress: businessAddressController.text, businessType: selectedBusinessType!, businessDescription: businessDescriptionController.text, businessLogo: "...", people: [Person(user: authService.user!, role: "Owner")]);
                  print(business.toJson());
                  await crudService.createBusiness(business);
                  Get.offAll(const IntroOrElse());
                }, // Disable the button initially
                style: ElevatedButton.styleFrom(
                  primary: light_purple, // Disabled color
                  onPrimary: Colors.white, // Disabled text color
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    businessNameController.dispose();
    businessContactController.dispose();
    businessAddressController.dispose();
    businessDescriptionController.dispose();
    super.dispose();
  }
}

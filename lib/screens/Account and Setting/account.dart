import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  final TextEditingController nameController =
  TextEditingController(text: "Roy Kabir Chowdhury");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Account',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Section
            Text(
              'Profile',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Edit your name and profile picture',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            // Name Input Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
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
            const SizedBox(height: 16),
            // Profile Picture Section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/dp.jpg'), // Replace with your asset path
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    // Upload Photo Button
                    ElevatedButton(
                      onPressed: () async{
                        // Upload photo action
                        /// Get the base url:
                        final FirebaseFirestore firestore = FirebaseFirestore.instance;
                        DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore.collection('baseurl').doc('baseurl').get();
                        String baseUrlValue = documentSnapshot.data()?['baseurl'] ?? 'No data found';
                        print(baseUrlValue);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        elevation: 0,
                        minimumSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Upload photo',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Take Photo Button
                    TextButton(
                      onPressed: () {
                        // Take photo action
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        minimumSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Take photo',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Edit Email Section
            Text(
              'Edit email',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A verification will be sent to your present email',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'roykabirchowdhury@gmail.com',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Edit email action
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple.shade50,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Edit email',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Delete Account Section
            Text(
              'Delete Account',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Deleting your account will remove existing records and products saved in your business',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Delete account action
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Delete',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

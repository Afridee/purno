import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../constants/themecolors.dart';
import '../../../services/authService.dart';
import '../../../services/crudService.dart';
import '../../../models/user.dart';
import '../../conditions/introOrElse.dart';

class CreateAccountPage1 extends StatefulWidget {
  const CreateAccountPage1({super.key});

  @override
  State<CreateAccountPage1> createState() => _CreateAccountPage1State();
}

class _CreateAccountPage1State extends State<CreateAccountPage1> {
  TextEditingController contactNumber = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();

  final AuthService authService = Get.put(AuthService());
  final CRUDService crudService = Get.put(CRUDService());

  @override
  void initState() {
    if (authService.auth.currentUser != null) {
      contactNumber.text = authService.auth.currentUser!.phoneNumber!;
    }
    super.initState();
  }

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Title
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              'Enter the details below to create an account for your business',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),

            // Full Name TextField
            TextField(
              controller: fullName,
              decoration: InputDecoration(
                hintText: 'Enter your Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Number TextField
            // TextField(
            //   controller: contactNumber,
            //   decoration: InputDecoration(
            //     hintText: 'Enter your Contact Number',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.grey),
            //     ),
            //     contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //   ),
            // ),
            // SizedBox(height: 20),

            // Email Address TextField
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Enter your Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Password TextField
            // TextField(
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     hintText: 'Set Password',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.grey),
            //     ),
            //     suffixIcon: Icon(Icons.visibility_off),
            //     contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //   ),
            // ),
            const Spacer(),

            // Disabled Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  var uuid = const Uuid();
                  User user = User(
                      uid: uuid.v1(),
                      fullName: fullName.text,
                      contactNumber: authService.auth.currentUser!.phoneNumber!,
                      emailAddress: email.text,
                      profilePicture: "");
                  await crudService.createUser(user);
                  Get.offAll(const IntroOrElse());
                },
                style: ElevatedButton.styleFrom(
                  primary: light_purple,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

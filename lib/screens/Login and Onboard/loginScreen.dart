import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/constants/themecolors.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/otpScreen.dart';

import '../../services/authService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isButtonEnabled = false;
  TextEditingController phoneNumberController = TextEditingController();
  final AuthService authService = Get.put(AuthService());

  void toggleButtonState() {
    if (phoneNumberController.text.isNotEmpty) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as) {
      return !as.isLoading
          ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // Title
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Subtitle
                    Text(
                      'It is quick and easy to log in. Enter your phone number below.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 30),

                    // Email TextField
                    TextField(
                      controller: phoneNumberController,
                      onChanged: (value) {
                        toggleButtonState(); // Enable the button when text is entered
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefix: Text("+880"),
                        hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),

                    ///Password
                    // Password TextField
                    // TextField(
                    //   obscureText: true,
                    //   controller: passwordController,
                    //   onChanged: (value) {
                    //     toggleButtonState(); // Enable the button when text is entered
                    //   },
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter Password',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //     suffixIcon: Icon(Icons.visibility_off),
                    //     contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    //   ),
                    // ),
                    // SizedBox(height: 15),

                    // Forgot Password Link
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       // Handle forgot password action
                    //     },
                    //     child: Text(
                    //       'Forgot Password',
                    //       style: TextStyle(
                    //         color: Colors.purple,
                    //         fontSize: 14,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Spacer(),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () {
                                authService.sendOtp(
                                    phoneNumber: "+880${phoneNumberController.text}");
                              }
                            : null, // Disable the button if not enabled
                        style: ElevatedButton.styleFrom(
                          primary: isButtonEnabled
                              ? light_purple
                              : Colors.grey[300], // Purple when enabled
                          onPrimary: isButtonEnabled
                              ? Colors.white
                              : Colors.grey[600], // White text when enabled
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          : Container(
              color: Colors.white,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.purple,
              )));
    });
  }
}

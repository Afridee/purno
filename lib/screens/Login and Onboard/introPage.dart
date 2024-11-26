import 'package:flutter/material.dart';
import 'package:purnomerchant/constants/themecolors.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/registrationPages/regPage1.dart';

import 'loginScreen.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                // Logo
                Container(
                    width: 80,
                    child: Image.asset("assets/images/purnologo.png")
                ),
                SizedBox(height: 20),

                // Title and Subtitle
                const Text(
                  'Manage orders, stocks and accept payment digitally',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'No matter what you sell',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: light_purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                // Placeholder for the illustration
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 220,
                    width: 220,
                    child: Image.asset("assets/images/Group38.png"),
                  ),
                ),
                // Login Button
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: light_purple,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                // Registration Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateAccountPage1(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: Colors.purple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Registration',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

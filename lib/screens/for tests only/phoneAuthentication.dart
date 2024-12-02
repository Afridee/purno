import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _verificationId;

  void _sendOtp() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification
          await _auth.signInWithCredential(credential);
          print("Phone number automatically verified and user signed in.");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Failed to verify phone number: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
          print("Verification code sent to phone.");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
          print("Auto-retrieval timeout.");
        },
      );
    } catch (e) {
      print("Error during phone number verification: $e");
    }
  }

  void _verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);
      print("Phone number verified and user signed in.");
    } catch (e) {
      print("Failed to verify OTP: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: _sendOtp,
              child: Text("Send OTP"),
            ),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: "Enter OTP"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}

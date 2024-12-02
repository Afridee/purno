import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../constants/themecolors.dart';
import '../../services/authService.dart';
import 'createAccountandShopSetup/regPage1.dart';
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController otpController = TextEditingController();
  final AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as){
      return Scaffold(
        appBar: AppBar(
          title: const Text("OTP Verification", style: TextStyle(color: Colors.white)),
          backgroundColor: light_purple,
        ),
        body: !as.isLoading ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter the OTP sent to your phone",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: light_purple,
                  selectedColor: light_purple,
                  inactiveColor: Colors.grey,
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String enteredOtp = otpController.text;
                  if (enteredOtp.length == 6) {
                    bool verified = await authService.verifyOTP(otp: enteredOtp);
                    if (verified) {
                      Get.snackbar(
                        "Success",
                        "OTP Verified Successfully!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                      );
                      Get.to(() => CreateAccountPage1());
                    } else {
                      Get.snackbar(
                        "Error",
                        "Invalid OTP. Please try again.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Error",
                      "Please enter a valid 6-digit OTP",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  backgroundColor: light_purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ) : Container(
            color: Colors.white,
            child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ))),
      );
    });
  }
}

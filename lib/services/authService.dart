import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/otpScreen.dart';

class AuthService extends GetxController {

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? _verificationId;
  bool isLoading = false;
  bool accountCreated = false;

  void signOut(){
    auth.signOut();
    update();
  }

  void sendOtp({required String phoneNumber}) async {

    isLoading = true;
    update();

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification
          await auth.signInWithCredential(credential);
          print("Phone number automatically verified and user signed in.");
          isLoading = false;
          update();
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Failed to verify phone number: ${e.message}");
          isLoading = false;
          update();
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          update();
          print("Verification code sent to phone.");
          isLoading = false;
          update();
          Get.to(OtpScreen());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          update();
          print("Auto-retrieval timeout.");
          isLoading = false;
          update();
        },
      );
    } catch (e) {
      isLoading = false;
      update();
      print("Error during phone number verification: $e");
    }
  }

  Future<bool> verifyOTP({required String otp}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }
}
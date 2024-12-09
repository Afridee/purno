import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/createAccountandShopSetup/regPage1.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/createAccountandShopSetup/regPage2.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/otpScreen.dart';
import '../models/business.dart';
import '../models/user.dart' as usermodel;
import 'crudService.dart';

class AuthService extends GetxController {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CRUDService crudService = Get.put(CRUDService());
  String? _verificationId;
  bool isLoading = false;
  bool accountCreated = false;
  usermodel.User? user;
  List<Business> businesses = [];

  Future<void> getUsr() async{
     isLoading =  true;
     update();

     user = await crudService.fetchUserByPhoneNumber(auth.currentUser!.phoneNumber!);
     update();

     isLoading =  false;
     update();
  }

  Future<void> getUsersBusiness() async{
    businesses = await crudService.fetchBusinessByUser(user!.uid!);
    isLoading =  false;
    update();
  }

  void signOut() async{
    await auth.signOut();
    user = null;
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
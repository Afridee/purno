import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import '../../services/authService.dart';
import '../Login and Onboard/createAccountandShopSetup/regPage1.dart';

class IntroOrElse extends StatefulWidget {
  const IntroOrElse({Key? key}) : super(key: key);

  @override
  State<IntroOrElse> createState() => _IntroOrElseState();
}

class _IntroOrElseState extends State<IntroOrElse> {

  final AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as){
     return  as.auth.currentUser!=null ? CreateAccountPage1() : IntroPage();
    });
  }
}

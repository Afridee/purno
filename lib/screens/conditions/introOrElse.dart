import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/loginScreen.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/registrationPages/regPage1.dart';

import '../../services/authService.dart';

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

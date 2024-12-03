import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/constants/themecolors.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import 'package:purnomerchant/screens/conditions/createAccountOrElse.dart';
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
  void initState() {
    final timer = Timer(
      const Duration(milliseconds: 1),
          () async{
        if(authService.auth.currentUser!=null){
          await authService.getUsr();
        }
        if(authService.user!=null) {
          await authService.getUsersBusiness();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as){
     return as.isLoading ? Container(
       color: Colors.white,
       child: const Center(
         child: CircularProgressIndicator(
           color: Colors.purple,
         ),
       ),
     )  : as.auth.currentUser!=null ? CreateAccountOrElse() : IntroPage();
    });
  }
}

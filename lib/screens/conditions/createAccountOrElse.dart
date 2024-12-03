import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import 'package:purnomerchant/screens/conditions/shopSetupOrElse.dart';
import '../../constants/themecolors.dart';
import '../../services/authService.dart';
import '../Login and Onboard/createAccountandShopSetup/regPage1.dart';
import '../Login and Onboard/createAccountandShopSetup/regPage2.dart';

class CreateAccountOrElse extends StatefulWidget {
  const CreateAccountOrElse({Key? key}) : super(key: key);

  @override
  State<CreateAccountOrElse> createState() => _CreateAccountOrElseState();
}

class _CreateAccountOrElseState extends State<CreateAccountOrElse> {

  final AuthService authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as){
      return as.isLoading ? Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: light_purple,
          ),
        ),
      ) :  as.user==null ? CreateAccountPage1() : ShopSetupOrElse();
    });
  }
}

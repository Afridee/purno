import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import '../../constants/themecolors.dart';
import '../../services/authService.dart';
import '../Account and Setting/account.dart';
import '../Home.dart';
import '../Login and Onboard/createAccountandShopSetup/regPage1.dart';
import '../Login and Onboard/createAccountandShopSetup/regPage2.dart';

class ShopSetupOrElse extends StatefulWidget {
  const ShopSetupOrElse({Key? key}) : super(key: key);

  @override
  State<ShopSetupOrElse> createState() => _ShopSetupOrElseState();
}

class _ShopSetupOrElseState extends State<ShopSetupOrElse> {

  final AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (as){
      return  as.isLoading ? Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: light_purple,
          ),
        ),
      ) :  as.businesses.isNotEmpty ? HomePage() : ShopSetupPage();
    });
  }
}

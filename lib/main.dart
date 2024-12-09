import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purnomerchant/screens/Account%20and%20Setting/setting.dart';
import 'package:purnomerchant/screens/Cart/Cart.dart';
import 'package:purnomerchant/screens/Inventory/products.dart';
import 'package:purnomerchant/screens/Login%20and%20Onboard/introPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:purnomerchant/screens/conditions/introOrElse.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'screens/Account and Setting/account.dart';
import 'screens/for tests only/phoneAuthentication.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://rbdskhtakzgoueqlsdmc.supabase.co',  // Replace with your Supabase project URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJiZHNraHRha3pnb3VlcWxzZG1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMyOTQwMjEsImV4cCI6MjA0ODg3MDAyMX0.lTeJQpcDIdD_o8gVqJ1GE_24fVX2ZHWUL0KItgZn9es',  // Replace with your Supabase anon key
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: IntroOrElse(),
    );
  }
}

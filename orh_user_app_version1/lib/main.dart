import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/splash_screen.dart';
import 'Home/home.dart';
import 'Hospitals/hospitals.dart';
import 'Login/login.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        // GetPage(name: "/", page: ()=> GoogleMLKitExample()),
        GetPage(name: "/", page: ()=> const MyCustomSplashScreen()),
        GetPage(name: "/login", page: ()=> const Login()),
        GetPage(name: "/home", page: ()=> const Home()),
        GetPage(name: "/Hospitals", page: ()=> const Hospitals()),
        // GetPage(name: "/form1", page: ()=> const form1()),
        // GetPage(name: "/firstPage", page: ()=> const FirstPage()),
        // GetPage(name: "/Doctors", page: ()=> const Doctors()),
        // GetPage(name: "/TimeSequence", page: ()=> const TimeSequence()),
        // GetPage(name: "/Hospitals", page: ()=> const Hospitals()),
        // GetPage(name: "/profile", page: ()=> const Profile())
      ],
    );
  }
}

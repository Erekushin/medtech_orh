import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/splash_screen.dart';
import 'Doctors/doctors.dart';
import 'Home/home.dart';
import 'Hospitals/hospital_prifile.dart';
import 'Hospitals/hospitals.dart';
import 'Lavlagaa1/lavlagaa.dart';
import 'Login/login.dart';
import 'TimeSequence/time_sequence.dart';

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
        GetPage(name: "/hospitals", page: ()=> const Hospitals()),
        GetPage(name: "/hospital/hospitalProfile", page: ()=> const HospitalProfile()),
        GetPage(name: "/hospital/doctors", page: ()=> const Doctors()),
        GetPage(name: "/doctors", page: ()=> const Doctors()),
        GetPage(name: "/lavlagaa1", page: ()=> const Lavlagaa()),
        GetPage(name: "/doctorTimeSequence", page: ()=> const DoctorTimeSequence()),
        // GetPage(name: "/Hospitals", page: ()=> const Hospitals()),
        // GetPage(name: "/profile", page: ()=> const Profile())
        // GetPage(name: "/firstPage", page: ()=> const FirstPage()),
        // GetPage(name: "/Doctors", page: ()=> const Doctors()),
      ],
    );
  }
}

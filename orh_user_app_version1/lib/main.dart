import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/splash_screen.dart';
import 'Doctors/doctor_profile.dart';
import 'Doctors/doctors.dart';
import 'Home/home.dart';
import 'Hospitals/hospital_prifile.dart';
import 'Hospitals/hospitals.dart';
import 'Lavlagaa1/lavlagaa.dart';
import 'Login/login.dart';
import 'Profile/profile.dart';
import 'TimeSequence/time_sequence.dart';
import 'global_constant.dart';

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
        ///Root
        GetPage(name: "/", page: ()=> const MyCustomSplashScreen()),
        ///login
        GetPage(name: RouteUnits.login, page: ()=> const Login()),
        ///home
        GetPage(name: RouteUnits.home, page: ()=> const Home()),
        ///Prifel
        GetPage(name: RouteUnits.profile, page: ()=> const Profile()),
        ///Үйлчлүүлэгч үзлэгийн цаг захиалах
        GetPage(name: RouteUnits.timeOrder + RouteUnits.hospitals, page: ()=> const Hospitals()),
        GetPage(name: RouteUnits.timeOrder + RouteUnits.hospitals + RouteUnits.doctors, page: ()=> const Doctors()),
        GetPage(name: RouteUnits.timeOrder + RouteUnits.hospitals + RouteUnits.doctors + RouteUnits.timeSequence, page: ()=> const DoctorTimeSequence()),
        ///Эмнэлэгүүдийн мэдээлэл
        GetPage(name: RouteUnits.hospitals, page: ()=> const Hospitals()),
        GetPage(name: RouteUnits.hospitals + RouteUnits.hospitalProfile, page: ()=> const HospitalProfile()),
        ///Эмч нарын мэдээлэл
        GetPage(name: RouteUnits.doctors, page: ()=> const Doctors()),
        GetPage(name: RouteUnits.doctors + RouteUnits.doctorProfile, page: ()=> const DoctorProfile()),
        ///Лавлагаа
        GetPage(name: RouteUnits.lavlagaa1, page: ()=> const Lavlagaa()),

      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/views/AnswerFormRelated/answer_form.dart';
import 'package:orh_user_app_version1/views/IndicatorCalculatorRelated/indicator_calculators.dart';
import 'package:orh_user_app_version1/views/PreDiagnosis/pre_diagnosis.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/survey.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/survey_creation.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/survey_list.dart';
import 'package:orh_user_app_version1/views/TreatmentRecipe/treatment_recipe.dart';
import 'package:orh_user_app_version1/views/splash_screen.dart';
import 'package:orh_user_app_version1/views/ProfileRelated/profile.dart';
import 'package:orh_user_app_version1/views/home.dart';
import 'package:orh_user_app_version1/views/LoginRelatedViews/login.dart';
import 'package:orh_user_app_version1/views/SettingsRelatedViews/setting.dart';
import 'Controllers/calculator_controller.dart';
import 'Controllers/image_controller.dart';
import 'Controllers/login_controller.dart';
import 'Controllers/sql_controller.dart';
import 'views/DoctorRelated/doctor_profile.dart';
import 'views/DoctorRelated/doctors.dart';
import 'MyWidgets/my_bottom_navbar.dart';
import 'views/HospitalRelated/hospital_prifile.dart';
import 'views/HospitalRelated/hospitals.dart';
import 'views/ProfileRelated/profile_devicelog.dart';
import 'views/ProfileRelated/profile_diagnosis_history.dart';
import 'views/ProfileRelated/profile_info.dart';
import 'views/ProfileRelated/profile_lifetoken.dart';
import 'views/TimeSequenceRelated/time_sequence.dart';
import 'VideoCall/camera_ex.dart';
import 'VideoCall/video_call.dart';
import 'file_check_ui.dart';
import 'global_constant.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'global_helpers.dart';

// this is fucking Development branch ..
Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late Stream<bool> bottomNavbarSwitcher;
  @override
  void initState(){
    super.initState();
    GlobalHelpers.bottomnavbarSwitcher = StreamController();
    bottomNavbarSwitcher = GlobalHelpers.bottomnavbarSwitcher.stream;
    GlobalHelpers.bottomnavbarSwitcher.add(false);
  }
  bindInitialControllers(){
    Get.put(ImageController(), permanent: true);
    Get.put(LoginController(), permanent: true);
    Get.put(SettingController(), permanent: true);
    Get.put(SqlController(), permanent: true);
    Get.put(SurveyController());
    Get.put(CalculatorController());
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
          GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteUnits.splashScreen,
      initialBinding: BindingsBuilder(() => bindInitialControllers()),
      getPages: [
        GetPage(name: RouteUnits.splashScreen, page: ()=> const MyCustomSplashScreen()),
        //basic profile input
        GetPage(name: RouteUnits.answerform, page: ()=> const AnswerForm(),),
        //login
        GetPage(name: RouteUnits.login, page: ()=> const Login()),
        //home
        GetPage(name: RouteUnits.home, page: ()=> const Home()),
        //Profile
        GetPage(name: RouteUnits.profile, page: ()=> const Profile()),
        GetPage(name: RouteUnits.profileInfo, page: ()=> const ProfileInfo()),
        GetPage(name: RouteUnits.profileDiagnosisHistory, page: ()=> const ProfileDiagnosisHistory()),
        GetPage(name: RouteUnits.profileLifeToken, page: ()=> const ProfileLifeToken()),
        GetPage(name: RouteUnits.profileDeviceLog, page: ()=> const ProfileDevicelog()),
        //Үйлчлүүлэгч үзлэгийн цаг захиалах
        GetPage(name: RouteUnits.timeOrder + RouteUnits.hospitals, page: ()=> Hospitals()),
        GetPage(name: RouteUnits.timeOrder + RouteUnits.hospitals + RouteUnits.doctors, page: ()=> const Doctors()),
        GetPage(name: RouteUnits.timeOrder + RouteUnits.hospitals + RouteUnits.doctors + RouteUnits.timeSequence, page: ()=> const DoctorTimeSequence()),
        //Эмнэлэгүүдийн мэдээлэл
        GetPage(name: RouteUnits.hospitals, page: ()=> Hospitals()),
        GetPage(name: RouteUnits.hospitals + RouteUnits.hospitalProfile, page: ()=> const HospitalProfile()),
        //Эмч нарын мsэдээлэл
        GetPage(name: RouteUnits.doctors, page: ()=> const Doctors()),
        GetPage(name: RouteUnits.doctors + RouteUnits.doctorProfile, page: ()=> const DoctorProfile()),
        //Судалгаанууд
        GetPage(name: RouteUnits.surveyCreation, page: ()=> const SurveyCreation()),
        GetPage(name: RouteUnits.surveyList, page: ()=> const SurveyList()),
        GetPage(name: RouteUnits.surveyList + RouteUnits.individualSurvey, page: ()=> const SurveyUnit()),
        //Calculators
        GetPage(name: RouteUnits.treatmentRecipe, page: ()=> const TreatmentRecipe() ),// CalculatorHome()
        //Setting
        GetPage(name: RouteUnits.setting, page: ()=> Setting()),
        //Урьдчилан сэргийлэх үзлэг
        GetPage(name: RouteUnits.preDiagnosis, page: ()=> const PreDiagnosis()),

        //card test
        // GetPage(name: "/loginforvchat", page: ()=> LoginView()),
        // GetPage(name: "/", page: ()=> LoginView()),
        GetPage(name: RouteUnits.calculators, page: ()=> const CalculatorsHome()),
        // GetPage(name: "/login", page: ()=> LoginView()),
        GetPage(name: "/camera", page: ()=> (CameraApp())),
      ], 
    ),
        StreamBuilder<bool>(
          stream: bottomNavbarSwitcher,
          builder: (context, snapshot){
            if (snapshot.data == true) 
            {
              return const Align(alignment: Alignment.bottomCenter, child: MyBottomNavbar(),);
            }
            else {
              return const SizedBox(height: 1);
            }
          })
        ],
      ),
      ),
    );
  }
}

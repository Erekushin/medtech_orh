import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/views/AnswerFormRelated/answer_form.dart';
import 'package:orh_user_app_version1/views/IndicatorCalculatorRelated/indicator_calculators.dart';
import 'package:orh_user_app_version1/views/PreDiagnosis/pre_diagnosis.dart';
import 'package:orh_user_app_version1/views/ProfileRelated/own_s_responses.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/response/researchers.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/response/responses.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/response/answers.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/survey.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/creation/survey_creation.dart';
import 'package:orh_user_app_version1/views/TreatmentRecipe/treatment_recipe.dart';
import 'package:orh_user_app_version1/views/home/home_info_flow.dart';
import 'package:orh_user_app_version1/views/splash_screen.dart';
import 'package:orh_user_app_version1/views/ProfileRelated/profile.dart';
import 'package:orh_user_app_version1/views/LoginRelatedViews/login.dart';
import 'package:orh_user_app_version1/views/SettingsRelatedViews/setting.dart';
import 'Controllers/SurveyRelated/survey_creation_controller.dart';
import 'Controllers/calculator_controller.dart';
import 'Controllers/image_controller.dart';
import 'Controllers/auth_controller.dart';
import 'Controllers/sql_controller.dart';
import 'views/DoctorRelated/doctor_profile.dart';
import 'views/DoctorRelated/doctors.dart';
import 'MyWidgets/my_bottom_navbar.dart';
import 'views/HospitalRelated/hospital_prifile.dart';
import 'views/HospitalRelated/hospitals.dart';
import 'views/ProfileRelated/profile_devicelog.dart';
import 'views/ProfileRelated/profile_diagnosis_history.dart';
import 'views/ProfileRelated/profile_info.dart';
import 'views/TimeSequenceRelated/time_sequence.dart';
import 'global_constant.dart';
import 'dart:async';
import 'global_helpers.dart';
import 'package:flutter/services.dart';
// this is fucking survey branch ..
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    Get.put(SurveyController());
    Get.put(AuthController(), permanent: true);
    Get.put(ImageController(), permanent: true);
    Get.put(SettingController(), permanent: true);
    Get.put(SqlController(), permanent: true);
    Get.put(CreationCont());
    Get.put(CalculatorController());
  }
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
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
        GetPage(name: RouteUnits.home, page: ()=> const HomeInfoFlow()),
        //Profile
        GetPage(name: RouteUnits.profile, page: ()=> const Profile()),
        GetPage(name: RouteUnits.profileInfo, page: ()=> const ProfileInfo()),
        GetPage(name: RouteUnits.profileDiagnosisHistory, page: ()=> const ProfileDiagnosisHistory()),
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
        GetPage(name: RouteUnits.surveyList + RouteUnits.individualSurvey, page: ()=> const SurveyUnit()),
        GetPage(name: RouteUnits.respondResearchers, page: ()=> const ResponseResearchers()),
        GetPage(name: RouteUnits.surveyResponses, page: ()=> const ResMain()),
        GetPage(name: RouteUnits.surveyResponses + RouteUnits.responseAnswers, page: ()=> const ResponseAnswers()),
        //Calculators
        GetPage(name: RouteUnits.treatmentRecipe, page: ()=> const TreatmentRecipe() ),// CalculatorHome()
        //Setting
        GetPage(name: RouteUnits.setting, page: ()=> Setting()),
        //Урьдчилан сэргийлэх үзлэг
        GetPage(name: RouteUnits.preDiagnosis, page: ()=> const PreDiagnosis()),
        GetPage(name: RouteUnits.calculators, page: ()=> const CalculatorsHome()),
        GetPage(name: RouteUnits.myResponds, page: ()=> const MyResponds()),
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

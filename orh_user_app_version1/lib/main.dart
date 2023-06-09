import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/query_controller.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/views/PCR_Related/pcr_view.dart';
import 'package:orh_user_app_version1/views/PreDiagnosis/pre_diagnosis.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/survey.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/survey_list.dart';
import 'package:orh_user_app_version1/views/splash_screen.dart';
import 'package:orh_user_app_version1/views/ProfileRelated/profile.dart';
import 'package:orh_user_app_version1/views/home.dart';
import 'package:orh_user_app_version1/views/LoginRelatedViews/login.dart';
import 'package:orh_user_app_version1/views/SettingsRelatedViews/setting.dart';
import 'BasicProfileCreation/basic_profile_data_cards.dart';
import 'Controllers/image_controller.dart';
import 'Controllers/login_controller.dart';
import 'MyWidgets/my_switcher.dart';
import 'views/DoctorRelated/doctor_profile.dart';
import 'views/DoctorRelated/doctors.dart';
import 'Helpers/Calculators/CalculatorViews/calculators_home.dart';
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

// this is fucking main branch ..
// survey deer hoyr gazar
// drop down deer neg gazar
//global helpers deer
//query controller deer 3 gazar
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Stream<bool> bottomNavbarSwitcher;
  CounterStorage sstorage = CounterStorage();
  @override
  void initState() {
    super.initState();
    GlobalHelpers.bottomnavbarSwitcher = StreamController();
    bottomNavbarSwitcher = GlobalHelpers.bottomnavbarSwitcher.stream;
    GlobalHelpers.bottomnavbarSwitcher.add(false);
  }

  bindInitialControllers() {
    Get.put(ImageController(), permanent: true);
    Get.put(LoginController(), permanent: true);
    Get.put(SettingController(), permanent: true);
    Get.put(SurveyController());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                GetPage(
                    name: RouteUnits.splashScreen,
                    page: () => const MyCustomSplashScreen()),
                //basic profile input
                GetPage(
                  name: RouteUnits.basicProfileInput,
                  page: () => const BasicPrifileDataCard(),
                ),
                //login
                GetPage(name: RouteUnits.login, page: () => const Login()),
                //home
                GetPage(name: RouteUnits.home, page: () => const Home()),
                //Profile
                GetPage(name: RouteUnits.profile, page: () => const Profile()),
                GetPage(
                    name: RouteUnits.profileInfo,
                    page: () => const ProfileInfo()),
                GetPage(
                    name: RouteUnits.profileDiagnosisHistory,
                    page: () => const ProfileDiagnosisHistory()),
                GetPage(
                    name: RouteUnits.profileLifeToken,
                    page: () => const ProfileLifeToken()),
                GetPage(
                    name: RouteUnits.profileDeviceLog,
                    page: () => const ProfileDevicelog()),
                //Үйлчлүүлэгч үзлэгийн цаг захиалах
                GetPage(
                    name: RouteUnits.timeOrder + RouteUnits.hospitals,
                    page: () => const Hospitals()),
                GetPage(
                    name: RouteUnits.timeOrder +
                        RouteUnits.hospitals +
                        RouteUnits.doctors,
                    page: () => const Doctors()),
                GetPage(
                    name: RouteUnits.timeOrder +
                        RouteUnits.hospitals +
                        RouteUnits.doctors +
                        RouteUnits.timeSequence,
                    page: () => const DoctorTimeSequence()),
                //Эмнэлэгүүдийн мэдээлэл
                GetPage(
                    name: RouteUnits.hospitals, page: () => const Hospitals()),
                GetPage(
                    name: RouteUnits.hospitals + RouteUnits.hospitalProfile,
                    page: () => const HospitalProfile()),
                //Эмч нарын мsэдээлэл
                GetPage(name: RouteUnits.doctors, page: () => const Doctors()),
                GetPage(
                    name: RouteUnits.doctors + RouteUnits.doctorProfile,
                    page: () => const DoctorProfile()),
                //Судалгаанууд
                GetPage(
                    name: RouteUnits.queries, page: () => const SurveyList()),
                GetPage(
                    name: RouteUnits.queries + RouteUnits.individualQuery,
                    page: () => const SurveyUnit()),
                //Calculators
                GetPage(
                    name: RouteUnits.calculators,
                    page: () => const CalculatorHome()),
                //Setting
                GetPage(name: RouteUnits.setting, page: () => const Setting()),
                //Урьдчилан сэргийлэх үзлэг
                GetPage(
                    name: RouteUnits.preDiagnosis,
                    page: () => const PreDiagnosis()),

                //card test
                // GetPage(name: "/loginforvchat", page: ()=> LoginView()),
                // GetPage(name: "/", page: ()=> LoginView()),
                GetPage(name: "/meeting", page: () => MeetingView()),

                // GetPage(name: "/tsagavah", page: ()=> const PCRView()),
                // GetPage(name: "/login", page: ()=> LoginView()),
                GetPage(name: "/camera", page: () => (CameraApp())),
                GetPage(name: "/pcrView", page: () => const PCRView()),
              ],
            ),
            StreamBuilder<bool>(
                stream: bottomNavbarSwitcher,
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return const Align(
                      alignment: Alignment.bottomCenter,
                      child: MyBottomNavbar(),
                    );
                  } else {
                    return const SizedBox(height: 1);
                  }
                })
          ],
        ),
      ),
    );
  }
}

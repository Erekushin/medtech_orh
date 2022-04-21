import 'package:flutter/material.dart';


class UriAdresses{
// static const String tokenTestXyrinfo = "https://iam.gerege.mn/api/request/make";
// static const String tokenTestlogin = "https://iam.gerege.mn/api/public/user/login";

static const String geregeUserLoginUri = "https://cvd.gov.mn/api/public/user/login/username";
static const String covidBackEnd = "https://cvd.gov.mn/api/request/make";
}

class RouteUnits{
  static String splashScreen = "/splashScreen";
  static String login = "/login";
  static String home = "/home";

  //Profile routes
  static String profile = "/profile";
  static String profileInfo = "/profileInfo";
  static String profileDiagnosisHistory = "/profileDiagnosisHistory";
  static String profileLifeToken = "/profileLifeToken";
  static String profileDeviceLog = "/profileDeviceLog";

  //Урьдчилан сэргийлэх үзлэг
  static String preDiagnosis = "/preDiagnosis";

  static String timeOrder = "/timeOrder";
  static String doctors = "/doctors";
  static String doctorProfile = "/doctorProfile";
  static String hospitals = "/hospitals";
  static String hospitalProfile = "/hospitalProfile";
  static String timeSequence = "/doctorTimeSequence";
  static String queries = "/queries";
  static String individualQuery ="/eachQuery";
  static String basicProfileInput = "/basicProfileInput";
  static String calculators = "/calculators";
  static String questions = "/questions";
  static String setting = "/setting";


  //const
  static const String fromHospitals = 'fromHospitals';
  static const String fromTimeOrder = 'fromTimeOrder';
  static const String fromPreDiagnosis = 'fromPreDiagnosis';
}

class CommonColors{
  static Color geregeBlue = const Color(0xFF0072FE);
  static Color yellow = const Color(0xFFFEC07B);
  static Color deepPink = const Color(0xFFFF4484);
}

class GeneralMeasurements{
  static late double deviceHeight;
  static late double deviceWidth;
  static double snackbarBottomMargin = deviceHeight*.12;
}

class AllSizes {
 static const double bigHeader = 25;
 static const double queryTxtSize = 16;
 static const int pageQuestionCount = 10;
}
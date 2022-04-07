import 'package:flutter/material.dart';


class UriAdresses{
static const String medTechUri = "http://10.0.0.116:8080/ords/medical_backend/request/make";
static const String geregeUserUri = "https://iam.gerege.mn/api/public/user/login";
static const String geregeUserLoginUri = "https://iam.gerege.mn/api/public/user/login/username";//нууц үг шаарддаг Uri
static const String CovidBackEnd = "http://203.26.189.133:8080/ords/covid_backend/request/make";
}

class RouteUnits{
  static String login = "/login";
  static String home = "/home";


  //Profile routes
  static String profile = "/profile";
  static String profileInfo = "/profileInfo";
  static String profileDiagnosisHistory = "/profileDiagnosisHistory";
  static String profileLifeToken = "/profileLifeToken";
  static String profileDeviceLog = "/profileDeviceLog";

  static String timeOrder = "/timeOrder";
  static String doctors = "/doctors";
  static String doctorProfile = "/doctorProfile";
  static String hospitals = "/hospitals";
  static String hospitalProfile = "/hospitalProfile";
  static String timeSequence = "/doctorTimeSequence";
  static String lavlagaa1 = "/lavlagaa1";
  static String basicProfileInput = "/basicProfileInput";
  static String calculators = "/calculators";
  static String questions = "/questions";
  static String setting = "/setting";
}

class CommonColors{
  static Color geregeBlue = const Color(0xFF0072FE);
  static Color yellow = const Color(0xFFFEC07B);
  static Color deepPink = const Color(0xFFFF4484);
}

class GeneralMeasurements{
  static late double deviceHeight;
  static late double deviceWidth;
}

class AllSizes {
 static const double bigHeader = 25;
 static const double queryTxtSize = 16;
}
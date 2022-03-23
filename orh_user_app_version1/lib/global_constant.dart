import 'package:flutter/material.dart';

class UriAdresses{
static const String medTechUri = "http://10.0.0.116:8080/ords/medical_backend/request/make";
static const String geregeUserUri = "https://iam.gerege.mn/api/public/user/login";
static const String geregeUserLoginUri = "https://iam.gerege.mn/api/public/user/login/username";//нууц үг шаарддаг Uri
}

class RouteUnits{
  static String login = "/login";
  static String home = "/home";
  static String profile = "/profile";
  static String timeOrder = "/timeOrder";
  static String doctors = "/doctors";
  static String doctorProfile = "/doctorProfile";
  static String hospitals = "/hospitals";
  static String hospitalProfile = "/hospitalProfile";
  static String timeSequence = "/doctorTimeSequence";
  static String lavlagaa1 = "/lavlagaa1";
  static String basicProfileInput = "/basicProfileInput";
}

class CommonColors{
  static Color geregeBlue = const Color(0xFF0072FE);
}

class GeneralMeasurements{
  static late double deviceHeight;
  static late double deviceWidth;
}
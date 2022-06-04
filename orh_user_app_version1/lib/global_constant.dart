import 'package:flutter/material.dart';


class UriAdresses{
static const String medCore = "https://medtech.gerege.mn/make/request";
}

class RouteUnits{
  static String splashScreen = "/splashScreen";
  static String login = "/login";
  static String home = "/home";

  //Profile routes
  static String profile = "/profile";
  static String profileInfo = "/profileInfo";
  static String profileDiagnosisHistory = "/profileDiagnosisHistory";
  static String mySurveys = "/mySurveys";
  static String profileDeviceLog = "/profileDeviceLog";

  //Урьдчилан сэргийлэх үзлэг
  static String preDiagnosis = "/preDiagnosis";

  static String timeOrder = "/timeOrder";
  static String doctors = "/doctors";
  static String doctorProfile = "/doctorProfile";
  static String hospitals = "/hospitals";
  static String hospitalProfile = "/hospitalProfile";
  static String timeSequence = "/doctorTimeSequence";
  //survey
  static String surveyCreation = "/surveyCreation";
  static String surveyList = "/surveyList";
  static String individualSurvey ="/individualSurvey";


  static String answerform = "/answerform";
  static String calculators = "/calculators";
  static String questions = "/questions";
  static String setting = "/setting";

  static String treatmentRecipe = "/treatmentRecipe";


  //const
  static const String fromHospitals = 'fromHospitals';
  static const String fromTimeOrder = 'fromTimeOrder';
  static const String fromPreDiagnosis = 'fromPreDiagnosis';
  static const String fromDoctors = 'fromDoctors';
  static const String fromBottomnavbar = 'fromBottomnavbar';
  static const String fromHome = 'fromHome';
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
 static const int answerFormCount = 4;
}

class SqlRelated{
  static const String recipeTable = "recipeTable";
}
import 'dart:async';
import 'package:orh_user_app_version1/Helpers/request.dart';
import 'package:orh_user_app_version1/models/SurveyRelated/aimags.dart';
import 'Helpers/working_with_code.dart';
import 'Helpers/working_with_folders.dart';

class GlobalHelpers{
static PostRequestGeneral postRequestGeneral = PostRequestGeneral();
///bottom navbar iig haragdah vgvig shiidej bgaa switcher
static late StreamController<bool> bottomnavbarSwitcher;
static WorkingWithCode workingWithCode = WorkingWithCode();
static bool imageFileSwitcher = false;
static WorkingWithLocal workWithLocal = WorkingWithLocal();
static AimagList aimagList = AimagList();
static int surveyPageCount = 1;
static int answerPageCount = 1;
static String auth = '';
static String userName = '';
static String pass = '';
static bool isXyrNull = false;
static int loopCheck = 0;
}


    // try{
       
    // }
    // catch(e){
    //     Get.snackbar('Алдаа', '$e!', snackPosition: SnackPosition.BOTTOM,
    //       colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
    // }
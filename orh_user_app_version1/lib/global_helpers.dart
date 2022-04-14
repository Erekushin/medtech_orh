import 'dart:async';
import 'package:orh_user_app_version1/Helpers/request.dart';
import 'package:orh_user_app_version1/models/childHeartQueryRelated/aimags.dart';
import 'Helpers/working_with_folders.dart';

class GlobalHelpers{
static PostRequestGeneral postRequestGeneral = PostRequestGeneral();
///bottom navbar iig haragdah vgvig shiidej bgaa switcher
static late StreamController<bool> bottomnavbarSwitcher;
static bool imageFileSwitcher = false;
static WorkingWithLocal workWithLocal = WorkingWithLocal();
static AimagList aimagList = AimagList();
static int queryPageCount = 1;
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
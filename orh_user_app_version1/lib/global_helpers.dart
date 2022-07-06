import 'dart:async';
import 'package:orh_user_app_version1/Helpers/request.dart';
import 'Helpers/working_with_code.dart';
import 'Helpers/working_with_folders.dart';

class GlobalHelpers{
static PostRequestGeneral postRequestGeneral = PostRequestGeneral();
static late StreamController<bool> bottomnavbarSwitcher;
static WorkingWithCode workingWithCode = WorkingWithCode();
static bool imageFileSwitcher = false;
static WorkingWithLocal workWithLocal = WorkingWithLocal();
static int surveyPageCount = 1;
static int answerPageCount = 1;
static String auth = '';
static String userName = '';
static String pass = '';
static bool isXyrNull = false;
static int loopCheck = 0;
}
class DropSelectVal{
  DropSelectVal({this.value});
  String? value;
}
class Argu {
  String? sColor;
  String? type;
  int? count;
  int? key;
  Argu({sColor, type, count, key});
}
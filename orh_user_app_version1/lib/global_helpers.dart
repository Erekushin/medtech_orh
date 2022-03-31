import 'dart:async';
import 'package:orh_user_app_version1/Helpers/request.dart';
import 'Helpers/working_with_folders.dart';

class GlobalHelpers{
static PostRequestGeneral postRequestGeneral = PostRequestGeneral();
static late StreamController<bool> bottomnavbarSwitcher;
static bool imageFileSwitcher = false;
static WorkingWithLocal workWithLocal = WorkingWithLocal();
}
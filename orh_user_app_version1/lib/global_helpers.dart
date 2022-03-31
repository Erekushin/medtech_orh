import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:orh_user_app_version1/Helpers/request.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/file_check_ui.dart';

import 'Controllers/image_controller.dart';
import 'Controllers/login_controller.dart';
import 'Helpers/create_local_folder.dart';
import 'global_constant.dart';

class GlobalHelpers{
static PostRequestGeneral postRequestGeneral = PostRequestGeneral();
static late StreamController<bool> bottomnavbarSwitcher;
static DirectoryPath directoryPath = DirectoryPath();
}
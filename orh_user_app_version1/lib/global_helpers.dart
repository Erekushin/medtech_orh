import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orh_user_app_version1/Helpers/request.dart';
import 'package:get/get.dart';

import 'Controllers/image_controller.dart';
import 'Controllers/login_controller.dart';
import 'global_constant.dart';

class GlobalHelpers{
static PostRequestGeneral postRequestGeneral = PostRequestGeneral();
static late StreamController<bool> bottomnavbarSwitcher;
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/request.dart';
import 'Helpers/working_with_code.dart';
import 'Helpers/working_with_folders.dart';
import 'global_constant.dart';

class GlobalHelpers {
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
  static void mySnackbar(String? title, String? txt, int? duration) {
    Get.snackbar(title ?? '', txt ?? '',
        duration: Duration(seconds: duration ?? 1),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.grey[900],
        margin: EdgeInsets.only(
          bottom: GeneralMeasurements.snackbarBottomMargin,
          left: 5,
          right: 5,
        ));
  }
}

class DropSelectVal {
  DropSelectVal({this.value, this.numVal});
  String? value;
  String? numVal;
}

class Argu {
  String? sColor;
  String? type;
  int? count;
  int? key;
  int? surveylvl;
  Argu({sColor, type, count, key, surveylvl});
}

class SCargubody {
  int? initialPage;
  String? fromRoute;
}

///sudalgaanii hariultiin combination iig vvsgeh unit
class CombUnit {
  String? unit;
}

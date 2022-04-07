import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:orh_user_app_version1/global_helpers.dart';

import '../models/aimags.dart';

class DefaultData{
String? researcherID;
int? aimagCode;
String aimagName = "dfdfd";
int? sumCode;
String sumName  = "dsdsds";
String currentdate = "2022/05/01";
}
class TextControllers{
  var ovog = TextEditingController();
  var ner = TextEditingController();
  var phone = TextEditingController();
}

class ChildHeartQueryController extends GetxController{
  TextControllers textControllers = TextControllers();
  DefaultData defaultData = DefaultData();
  var chosenAimag = 0.obs; //songogdson aimagiin id g sonsoh stream
  var checkColor = Colors.grey.obs;
  DateTime currentDate = DateTime.now();
  Future<String>_loadFromAsset() async {
      return await rootBundle.loadString("assets/file/addresses.json");
  }
  Future getAimagList() async {
    String jsonString = await _loadFromAsset();
    var aimagListStr = jsonDecode(jsonString);
    GlobalHelpers.aimagList = AimagList.fromJson(aimagListStr);
  }
  checkData(){
    if(defaultData.aimagCode != null && defaultData.sumCode != null && defaultData.currentdate != null){
      checkColor.value = Colors.green;
    }
  }
}
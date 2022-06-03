

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Models/result.dart';
import '../Helpers/logging.dart';
import '../Models/LoginRelatedModels/gerege_user.dart';
import '../global_constant.dart';
import '../global_helpers.dart';
import 'package:crypto/crypto.dart';
import 'SurveyRelated/survey_controller.dart';

class AuthController extends GetxController{
  User_Info medtech_user = User_Info();
  var loginloading = false.obs;
  var username = TextEditingController();
  var pass = TextEditingController();
  //register
  var nameCont = TextEditingController();
  var passCont = TextEditingController();
  var phoneCont = TextEditingController();
  var rdCont = TextEditingController();
  //  Map<String, dynamic> loginBody(){
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['search_text'] = GlobalHelpers.userName;
  //   data['terminal_id'] = "0";
  //   data['password'] = GlobalHelpers.pass;
  //   data['app_id'] = 4400;
  //   return data;
  // }
   Map<String, dynamic> loginBody(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = username.text;
    return data;
  }
  Map<String, dynamic> geregeId(){
    final int geregeId = medtech_user.result!.userId!;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = geregeId; 
    return data;
  }
  var surveyController = Get.find<SurveyController>();
  GeneralResponse generalResponse = GeneralResponse();
  var ereklog = logger(SurveyController);
  Future geregeUserLogin(Function retryFunction) async{
    loginloading.value = true;
    GlobalHelpers.userName = username.text;
    GlobalHelpers.pass = md5.convert(utf8.encode(pass.text.toString())).toString();
    if(GlobalHelpers.userName.isNotEmpty && GlobalHelpers.pass.isNotEmpty){
      var data = await GlobalHelpers.postRequestGeneral.getdata(loginBody(), "110002", UriAdresses.medCore); //UriAdresses.geregeUserLoginUri
      print('gerege login ajillah yostoi');
      log(jsonEncode(loginBody()));
      ereklog.wtf(data);
      medtech_user = User_Info.fromJson(jsonDecode(data.toString()));
      switch(medtech_user.code){
        case 200:
          loginloading.value = false;
          // GlobalHelpers.auth =  'bearer ' + geregeUser.result!.token!.token!;
          await surveyController.surveyListGet(RouteUnits.home, '120002', medtech_user.result!.userId!, '');
          retryFunction();
          break;
        case 403:
          loginloading.value = false; 
          Get.snackbar('Хэрэглэгч бүртгэлгүй байна', 'Бүртгэл үүсгэхийн тулд Gerege App ыг суулгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          username.clear();
          pass.clear();
          break;
        case 100:
          loginloading.value = false; 
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          username.clear();
          pass.clear();
          break;
        case 101:
          loginloading.value = false; 
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          username.clear();
          pass.clear();
          break;
        case 400: 
          loginloading.value = false;
          Get.snackbar(medtech_user.message!, 'Нууц үг буруу эсвэл Тэрминал байхгүй', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          username.clear();
          pass.clear();
          break;
        default : break;  
      }
    }
    else{
      loginloading.value = false;
      Get.snackbar('Талбаруудын утга хоосон байна', "Хэрэглэгчийн нэр ихэвчлэн Регистрийн дугаараар баталгаажсан байгаа!", snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
    }
  }
  

  Map<String, dynamic> registerInfo(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = nameCont.text; 
    data['user_pass'] = passCont.text; 
    data['user_phone'] = phoneCont.text;
    data['user_rd'] = rdCont.text; 
    return data;
  }
  Future registration() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(registerInfo(), '110001', UriAdresses.medCore);
    generalResponse = GeneralResponse.fromJson(jsonDecode(data.toString()));
    if(generalResponse.code == '200'){
       Get.snackbar('Gerege Medtech family-д тавтай морил', "Хэрэглэгчийн бүртгэл амжилттай үүслээ", snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
         nameCont.clear();
         passCont.clear();
         phoneCont.clear();
         rdCont.clear();
    }
  }
}
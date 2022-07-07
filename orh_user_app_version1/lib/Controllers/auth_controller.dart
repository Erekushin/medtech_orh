

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/image_controller.dart';
import 'package:orh_user_app_version1/Models/general_response.dart';
import '../Helpers/logging.dart';
import '../Models/LoginRelatedModels/gerege_user.dart';
import '../Models/LoginRelatedModels/register_response.dart';
import '../global_constant.dart';
import '../global_helpers.dart';
import 'package:crypto/crypto.dart';
import 'SurveyRelated/survey_controller.dart';

class AuthController extends GetxController{
  User_Info user = User_Info();
  var loginloading = false.obs;
  var loginName = TextEditingController();
  var loginPass = TextEditingController();
  //register
  var nameCont = TextEditingController();
  var passCont = TextEditingController();
  var passValidCont = TextEditingController();
  var phoneCont = TextEditingController();
  var rdCont = TextEditingController();
   Map<String, dynamic> loginBody(){
    var bytes = utf8.encode(loginPass.text);
    var hash = sha256.convert(bytes);
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = loginName.text;
    data['user_pass'] = hash.toString();
    return data;
  }
  Map<String, dynamic> geregeId(){
    final int geregeId = user.result!.userId!;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = geregeId; 
    return data;
  }
  var surveyController = Get.find<SCont>();
  var ereklog = logger(SCont);
  Future geregeUserLogin(Function retryFunction) async{
    loginloading.value = true;
    GlobalHelpers.userName = loginName.text;
    GlobalHelpers.pass = md5.convert(utf8.encode(loginPass.text.toString())).toString();
    if(GlobalHelpers.userName.isNotEmpty && GlobalHelpers.pass.isNotEmpty){
      var data = await GlobalHelpers.postRequestGeneral.getdata(loginBody(), "110002", UriAdresses.medCore); //UriAdresses.geregeUserLoginUri
      print('gerege login ajillah yostoi');
      log(jsonEncode(loginBody()));
      ereklog.wtf(data);
      user = User_Info.fromJson(jsonDecode(data.toString()));
      switch(user.code){
        case 200:
          loginloading.value = false;
          // GlobalHelpers.auth =  'bearer ' + geregeUser.result!.token!.token!;
          Get.find<ImageController>().imageBytes.value = user.result!.picture!.cast<int>();
          await surveyController.listGet(RouteUnits.home, '120002', user.result!.userId!, '', user.result!.phone!);
          await surveyController.listGet('/segmented', '120009', user.result!.userId!, '', user.result!.phone!);
          retryFunction();
          break;
        case 403:
          loginloading.value = false; 
          Get.snackbar('Хэрэглэгч бүртгэлгүй байна', 'Бүртгэл үүсгэхийн тулд Gerege App ыг суулгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          loginName.clear();
          loginPass.clear();
          break;
        case 100:
          loginloading.value = false; 
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          loginName.clear();
          loginPass.clear();
          break;
        case 101:
          loginloading.value = false; 
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          loginName.clear();
          loginPass.clear();
          break;
        case 400: 
          loginloading.value = false;
          Get.snackbar(user.message!, 'Нууц үг буруу эсвэл Тэрминал байхгүй', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          loginName.clear();
          loginPass.clear();
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
  
  RegisterResponse registerResponse = RegisterResponse();
  Map<String, dynamic> registerInfo(){
    var imageCon = Get.find<ImageController>();
    var bytes = utf8.encode(passCont.text);
    var hash = sha256.convert(bytes);
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = nameCont.text; 
    data['user_pass'] = hash.toString(); 
    data['phone'] = phoneCont.text;
    data['user_rd'] = rdCont.text; 
    data['picture'] = imageCon.imageBytes.toString();
    return data;
  }
  Future registration() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(registerInfo(), '110001', UriAdresses.medCore);
    print(data);
    print(registerInfo());
    registerResponse = RegisterResponse.fromJson(jsonDecode(data.toString()));

    switch(registerResponse.code){
      case 200:
       Get.snackbar('Gerege Medtech family-д тавтай морил', "Хэрэглэгчийн бүртгэл амжилттай үүслээ", snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
          switch(registerResponse.result!.code){
            case 200:
             Get.snackbar('', "Регистрийн дугаарыг амжилттай шалгалаа", snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
            break;
            case 400:
              Get.snackbar('', "регистрийн дугаар буруу байж болзошгүй байна. Profile хэсэг дээр мэдээллийг засаж оруулна уу", snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
            break;
          }
         nameCont.clear();
         passCont.clear();
         passValidCont.clear();
         phoneCont.clear();
         rdCont.clear();
      break;
      case 400:
       Get.snackbar('Бүртгэл үүсгэж чадсангүй', registerResponse.message.toString(), snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
      break;
    }
  }


  Map<String, dynamic> updateProbody(){
    var imageCon = Get.find<ImageController>();
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user.result!.userId; 
    data['new_picture'] = imageCon.imageBytes.toString();
    return data;
  }
  EResponse GForUpdateProPic = EResponse();
  Future updateProPic() async{
     var data = await GlobalHelpers.postRequestGeneral.getdata(updateProbody(), '110003', UriAdresses.medCore);
     GForUpdateProPic = EResponse.fromJson(jsonDecode(data.toString()));
      switch(registerResponse.code){
      case 200:
      Get.snackbar('', "Зураг амжилттай солигдлоо", snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
      break;
    }
  }
}
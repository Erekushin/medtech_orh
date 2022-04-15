import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/LoginRelatedModels/gerege_user.dart';
import '../global_constant.dart';
import '../global_helpers.dart';
import 'package:crypto/crypto.dart';

class LoginController extends GetxController{
  GeregeUser geregeUser = GeregeUser();
  var loginloading = false.obs;
  var username = TextEditingController();
  var pass = TextEditingController();
   Map<String, dynamic> loginBody(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_text'] = GlobalHelpers.userName;
    data['terminal_id'] = "0";
    data['password'] = GlobalHelpers.pass;
    data['app_id'] = 4400;
    return data;
  }
  Map<String, dynamic> geregeId(){
    final String geregeId = geregeUser.result!.id!;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = geregeId; 
    return data;
  }

  Future geregeUserLogin(Function retryFunction) async{
    loginloading.value = true;
    GlobalHelpers.userName = username.text;
    GlobalHelpers.pass = md5.convert(utf8.encode(pass.text.toString())).toString();
    if(GlobalHelpers.userName.isNotEmpty && GlobalHelpers.pass.isNotEmpty){
      var data = await GlobalHelpers.postRequestGeneral.getdata(loginBody(), "", UriAdresses.geregeUserLoginUri);
      geregeUser = GeregeUser.fromJson(jsonDecode(data.toString()));
      switch(geregeUser.code){
        case 200:
          loginloading.value = false;
          GlobalHelpers.auth =  'bearer ' + geregeUser.result!.token!.token!;
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
          Get.snackbar(geregeUser.message!, 'Нууц үг буруу эсвэл Тэрминал байхгүй', snackPosition: SnackPosition.BOTTOM,
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
  // Future getGeregeUserinfoLittle() async{
  //   loginloading.value = true;
  //   var data = await GlobalHelpers.postRequestGeneral.getdata(loginBodyLitle(), "", UriAdresses.geregeUserLoginUri);
  //     log(jsonEncode(loginBodyLitle()));
  //     print(GlobalHelpers.pass + 'pass');
  //     print(GlobalHelpers.userName + 'username');
  //     print("logiin response" + data);
  //     geregeUser = GeregeUser.fromJson(jsonDecode(data.toString()));
  //     switch(geregeUser.code){
  //       case 200:
  //         loginloading.value = false;
  //         GlobalHelpers.auth = 'bearer ' + geregeUser.result!.token!.token!;
  //         Get.find<QueryController>().xyrInfoGet();
  //         print('shine auth token' + GlobalHelpers.auth);
  //         username.clear();
  //         pass.clear();
  //         break;
  //     }
  // }
  // Future getGeregeUserinfoLittlepush() async{
  //   loginloading.value = true;
  //   var data = await GlobalHelpers.postRequestGeneral.getdata(loginBodyLitle(), "", UriAdresses.geregeUserLoginUri);
  //     log(jsonEncode(loginBodyLitle()));
  //     print(GlobalHelpers.pass + 'pass');
  //     print(GlobalHelpers.userName + 'username');
  //     print("logiin response" + data);
  //     geregeUser = GeregeUser.fromJson(jsonDecode(data.toString()));
  //     switch(geregeUser.code){
  //       case 200:
  //         loginloading.value = false;
  //         GlobalHelpers.auth = 'bearer ' + geregeUser.result!.token!.token!;
  //         Get.find<QueryController>().surveyAnswersPush();
  //         print('shine auth token' + GlobalHelpers.auth);
  //         username.clear();
  //         pass.clear();
  //         break;
  //     }
  // }
}
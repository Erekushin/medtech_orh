//TODO Login controller oo getx eer oruulaad shared bolgoh bolomjtoi shaardlagatai bol tiim bolgono
//TODO shaardlagatai bol terminal avah logic nemj oruulah
//TODO sign up hiih sign in hiih logic iig bvten gargah

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global_constant.dart';
import '../global_helpers.dart';
import 'package:crypto/crypto.dart';
import '../models/gerege_user.dart';

class LoginController extends GetxController{
  LoginModel model =  LoginModel();
  var loginloading = false.obs;
  var username = TextEditingController(); //Регистэр
  var pass = TextEditingController(); //Нууц үг
  Map<String, dynamic> loginBody(){
    String? searchText = username.text.toString();
    String? hushedPass = md5.convert(utf8.encode(pass.text.toString())).toString();
    // String? terminalID = LoginController.model.terminalID;
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search_text'] = searchText;
    data['terminal_id'] = "0";
    // data['terminal_id'] = terminalID;
    data['password'] = hushedPass;
    data['app_id'] = 4402;
    return data;
  }
  Map<String, dynamic> childHeartQueryResearchertestbody(){
    String? keytxt = model.result!.id.toString();
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_user_id'] = '10200801060556657116';
    return data;
  }

  Future getdata() async{
    loginloading.value = true;
    if(username.text.isNotEmpty && pass.text.isNotEmpty){
      // var data = await getData.getdata(toJsonn(), "203801", MedTechUri);
      var data = await GlobalHelpers.postRequestGeneral.getdata(loginBody(), "", UriAdresses.geregeUserLoginUri);
      print("logiin response" + data);
      model = LoginModel.fromJson(jsonDecode(data.toString()));
      switch(model.code){
        case 200:
          loginloading.value = false;
          Get.offNamed(RouteUnits.home);
          username.clear();
          pass.clear();
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
          Get.snackbar(model.message!, 'Нууц үг буруу эсвэл Тэрминал байхгүй', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          username.clear();
          pass.clear();
          break;
        default : break;  
      }
    }
    else{
      loginloading.value = false;
      Get.toNamed('/home');
      Get.snackbar('Талбаруудын утга хоосон байна', "Хэрэглэгчийн нэр ихэвчлэн Регистрийн дугаараар баталгаажсан байгаа!", snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
    }
  }

  Future childHeartQueryResearchertest() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(childHeartQueryResearchertestbody(), "2035232", UriAdresses.CovidBackEnd);
    var response = LoginModel.fromJson(jsonDecode(data.toString()));
    if(response.code == 200){
      Get.toNamed('/localcheck', arguments: "fromHospitals");
    }
    else if(response.code == 400){
      Get.defaultDialog(title: 'Таньд судалгаа авах эрх үүсээгүй байна', content: Image.asset('assets/images/thinkingBoy.png'));
    }
  }



}
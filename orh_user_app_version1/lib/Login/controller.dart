//TODO Login controller oo getx eer oruulaad shared bolgoh bolomjtoi shaardlagatai bol tiim bolgono
//TODO shaardlagatai bol terminal avah logic nemj oruulah
//TODO sign up hiih sign in hiih logic iig bvten gargah

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Login/login.dart';
import '../Helpers/Api/post_request_general.dart';
import '../Home/home.dart';
import '../global_constant.dart';
import 'model.dart';
import 'package:crypto/crypto.dart';

class LoginController extends GetxController{
  var currentIndex = 4.obs;
  void jj(){
    currentIndex++;
  }
  var loginloading = false.obs;
  var username = TextEditingController(); //Регистэр
  var pass = TextEditingController(); //Нууц үг
  final getDataaaa = Get.put(PostRequestGeneral());
  static LoginModel model =  LoginModel();
  Map<String, dynamic> toJsonn(){
    String? searchText = username.text.toString();
    String? hushedPass = md5.convert(utf8.encode(pass.text.toString())).toString();
    // String? terminalID = LoginController.model.terminalID;
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search_text'] = searchText;
    data['terminal_id'] = "0";
    // data['terminal_id'] = terminalID;
    data['password'] = hushedPass;
    data['app_id'] = 4402;
    print(data);
    print('oorchlolt iig save deerfee haruulj bgaa eseh');
    return data;
  }
  Future<bool> getdata() async{
    loginloading.value = true;
    print(loginloading.toString());
    if(username.text.isNotEmpty && pass.text.isNotEmpty){
      // var data = await getData.getdata(toJsonn(), "203801", MedTechUri);
      var data = await getDataaaa.getdata(toJsonn(), "", UriAdresses.geregeUserLoginUri);
      print("logiin response" + data);
      model = LoginModel.fromJson(jsonDecode(data.toString()));
      switch(LoginController.model.code){
        case 200:
        loginloading.value = false;
         Get.offNamed(RouteUnits.home);
         username.clear();
          pass.clear();
         return true;
        case 403:
        loginloading.value = false; 
          Get.snackbar('Хэрэглэгч бүртгэлгүй байна', 'Бүртгэл үүсгэхийн тулд Gerege App ыг суулгана уу!', snackPosition: SnackPosition.BOTTOM,
          
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          username.clear();
          pass.clear();
          return false;
        case 400: 
        loginloading.value = false;
          Get.snackbar(model.message!, 'Нууц үг буруу эсвэл Тэрминал байхгүй', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          username.clear();
          pass.clear();
          return false;
        default : return false;  
      }
    }
    else{
      loginloading.value = false;
      Get.toNamed('/home');
      Get.snackbar('Талбаруудын утга хоосон байна', "Хэрэглэгчийн нэр ихэвчлэн Регистрийн дугаараар баталгаажсан байгаа!", snackPosition: SnackPosition.BOTTOM,
      
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
      return false;
    }
  }
}
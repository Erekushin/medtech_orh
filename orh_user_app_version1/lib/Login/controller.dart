import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Helpers/Api/post_request_general.dart';
import 'model.dart';

class LoginController{
  var rD = TextEditingController(); //Регистэр
  final getData = Get.put(PostRequestGeneral());
  static LoginModel model =  LoginModel();
  Map<String, dynamic> toJsonn() {
    String? search_text = rD.text.toString();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search_text'] = search_text;
    return data;
  }
  Future<bool> getdata() async{
    LoginModel.loginloading = true;
    print('on getdata');
    if(rD.text.isNotEmpty){
      var data = await getData.getdata(toJsonn(), "203801", LoginModel.uri);
      model = LoginModel.fromJson(jsonDecode(data.toString()));
      print(LoginController.model.code);
      if(LoginController.model.code == 200){
        Get.toNamed('/home');
        return true;
      }
      else if(LoginController.model.code == 404){
        Get.snackbar('Хэрэглэгч бүртгэлгүй байна', 'Бүртгэл үүсгэхийн тулд Gerege App ыг суулгана уу!', snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.all(5));
        rD.clear();
        return false;
      }
      else{
        return false;
      }
    }
    else{
      LoginModel.loginloading = false;
      Get.toNamed('/home');
      Get.snackbar('Талбаруудын утга хоосон байна', 'Хэрэглэгчийн нэр ихэвчлэн Регистрийн дугаараар баталгаажсан байгаа!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.all(5));
      return false;
    }
  }
}
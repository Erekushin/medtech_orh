//TODO Login controller oo getx eer oruulaad shared bolgoh bolomjtoi shaardlagatai bol tiim bolgono
//TODO shaardlagatai bol terminal avah logic nemj oruulah
//TODO sign up hiih sign in hiih logic iig bvten gargah



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Helpers/Api/post_request_general.dart';
import '../global_constant.dart';
import 'model.dart';
import 'package:crypto/crypto.dart';

class LoginController{
  var rD = TextEditingController(); //Регистэр
  var pass = TextEditingController(); //Нууц үг
  final getData = Get.put(PostRequestGeneral());
  static LoginModel model =  LoginModel();
  Map<String, dynamic> toJsonn(){
    String? searchText = rD.text.toString();
    String? hushedPass = md5.convert(utf8.encode(pass.text.toString())).toString();
    // String? terminalID = LoginController.model.terminalID;
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search_text'] = searchText;
    // data['terminal_id'] = "30200730151601884873";
    // data['terminal_id'] = terminalID;
    data['password'] = hushedPass;
    data['app_id'] = 4402;
    return data;
  }
  Future<bool> getdata() async{
    LoginModel.loginloading = true;
    if(rD.text.isNotEmpty){
      // var data = await getData.getdata(toJsonn(), "203801", MedTechUri);
      var data = await getData.getdata(toJsonn(), "", UriAdresses.geregeUserLoginUri);
      print("logiin response" + data);
      model = LoginModel.fromJson(jsonDecode(data.toString()));
      if(LoginController.model.code == 200){
        Get.toNamed(RouteUnits.home);
        return true;
      }
      else if(LoginController.model.code == 404){
        Get.snackbar('Хэрэглэгч бүртгэлгүй байна', 'Бүртгэл үүсгэхийн тулд Gerege App ыг суулгана уу!', snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
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
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
      return false;
    }
  }
}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Helpers/Api/post_request_general.dart';
import '../global_constant.dart';
import 'base_data.dart';
import 'model.dart';
import 'own_data.dart';

class form1Controller{
  static form1Model model = new form1Model();
  final postRequestGeneral = Get.find<PostRequestGeneral>();
  // final getData = Get.put(GetData());
  var profession = TextEditingController();//мэргэжил
  var office = TextEditingController();//ажлын газар
  var working_condition = TextEditingController();//ажлын нөхцөл drop
  var position = TextEditingController();//албан тушаал
  var phone = TextEditingController();//ажилын утас
  var reason_not_employment = TextEditingController(); //ажил эрхлээгүй шалтгаан drop
  var employment = TextEditingController(); //хөдөлмөр эрхлэлтийн байдал drop
  var education_situation = TextEditingController();//боловсролын байдал drop
  var blood_type = TextEditingController();//цусны бүлэг radiobtn
  var marital_status = TextEditingController();//гэр бүлийн байдал drop
  var is_disability = TextEditingController();//хөгжилийн бэрхшээлтэй эсэх radiobtn
  var number_families = TextEditingController();//гэр бүлийн тоо odoohondoo tvr zaaval avdag controller oor ashiglaj bgaa
  var nationality = TextEditingController();//Яс үндэс
  var is_alcohol = TextEditingController();//архи хэрэглэдэг эсэх radiobtn
  var is_cigarette = TextEditingController();//тамхи хэрэглэдэг эсэх radiobtn
  var is_medicine = TextEditingController();//тогтмол эм хэрэглэдэг эсэх radiobtn
  void TransferToModel(){
    model.profession = profession.text;
    model.office = office.text;
    model.position = position.text;
    model.phone = phone.text;
    model.number_families = number_families.text;
    model.nationality = nationality.text;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['user_id'] = model.userId;
    data['reason_not_employment'] = model.reason_not_employment;
    data['position'] = model.position;
    data['phone'] = model.phone;
    data['education_situation'] = model.education_situation;
    data['blood_type'] = model.blood_type;
    data['employment'] = model.employment;
    data['marital_status'] = model.marital_status;
    data['is_disability'] = model.is_disability;
    data['number_families'] = model.number_families;
    data['work_condition'] = model.working_condition;
    data['org_id'] = model.orgId;
    data['nationality'] = model.nationality;
    data['profession'] = model.profession;
    data['office'] = model.office;
    data['is_alcohol'] = model.is_alcohol;
    data['is_cigarette'] = model.is_cigarette;
    data['is_medicine'] = model.is_medicine;
    return data;
  }
  static BaseData basedata = new BaseData();
  static BaseData ehbvrtgelResponse = new BaseData();
  static BaseData ehbvrtgelZasvarResponse = new BaseData();
  static OwnData ownData = new OwnData();
  Map<String, dynamic> toJsonn() {
    String? RD = "ай01281611";
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = RD;
    return data;
  }
  Future<BaseData> getdata() async{
    var body = {};
    var ownDataString = await postRequestGeneral.getdata(toJsonn(), '203842', uri);
    ownData = OwnData.fromJson(jsonDecode(ownDataString));
    var basedataString = await postRequestGeneral.getdata(body, '203828', uri);
    basedata = BaseData.fromJson(jsonDecode(basedataString));
    return basedata;
  }
  Future<bool>SaveOnBack(BuildContext context) async {
    if(number_families.text.isNotEmpty){
      TransferToModel();
      BaseData response = await pushForm1();
      switch(response.code){
        case 200:
          return await Get.defaultDialog(title: 'амжилттай', content: const Text('амжилттай бүртгэгдлээ'),
              actions: <Widget>[TextButton(onPressed: (){Get.toNamed('/home');}, child: const Text("ok"))]);
        case 400:
          await SaveChangesOnBack();
          return
            await Get.defaultDialog(title: 'амжилттай', content: const Text('амжилттай засагдлаа'),
                actions: <Widget>[TextButton(onPressed: (){Get.toNamed('/home');}, child: const Text("ok"))]);
        default:
          return false;
      }
    }
    else{
      Get.back();
      return false;
    }
  }
  Future<BaseData> pushForm1() async{
    var pushForm1Response = await postRequestGeneral.getdata(toJson(), '203825', uri);
    ehbvrtgelResponse = BaseData.fromJson(jsonDecode(pushForm1Response));
    return ehbvrtgelResponse;
  }
  Future<BaseData>SaveChangesOnBack() async {
    var saveChangesOnBackResponse = await postRequestGeneral.getdata(toJson(), '203847', uri);
    print('abalabadv');
    print(toJson().toString());
    ehbvrtgelZasvarResponse = BaseData.fromJson(jsonDecode(saveChangesOnBackResponse));
    return ehbvrtgelZasvarResponse;
  }
}




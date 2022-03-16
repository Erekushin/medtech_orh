import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class PostRequestGeneral{
  Future<String> getdata(var jsonBody, String messageCode, String uriAdress,) async{
    try{
      var myheaders = {
        'message_code': messageCode,
      };
      Response response = await post(Uri.parse(uriAdress), body: json.encode(jsonBody), headers: myheaders );
      var data = utf8.decode(response.bodyBytes);
      return data;
    }on HttpException catch(err){
      print('Network error $err');
      return '';
    }finally{
      print('all done');
    }
  }
}
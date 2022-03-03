import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class PostRequestGeneral{
  Future<String> getdata(var JsonBody, String MessageCode, String UriAdress,) async{
    try{
      var headers = {
        'message_code': MessageCode,
      };
      Response response = await post(Uri.parse(UriAdress), body: json.encode(JsonBody), headers: headers );
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
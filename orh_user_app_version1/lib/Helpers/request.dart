import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
class PostRequestGeneral{
  var data = '';
  Future<String> getdata(var jsonBody, String messageCode, String uriAdress,) async{
    // var data;
    try{
      var myheaders = {
        'message_code': messageCode,
        'Authorization' : GlobalHelpers.auth,
      };
      Response response = await  post(Uri.parse(uriAdress), body: json.encode(jsonBody), headers: myheaders );
      print(response);
      data = utf8.decode(response.bodyBytes);
   
      return data;

      
    }on HttpException catch(err){
      data = '{"code":100,"status":"httpException","message":"$err"}';
      return data;
    }on SocketException catch(socketerr){
      data = '{"code":101,"status":"SocketException","message":"$socketerr"}';
      return data;
    }finally{
      print('all done');
    }
  }
}
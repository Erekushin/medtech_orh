import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:get/get.dart';
import '../../MyWidgets/my_button.dart';
import '../../MyWidgets/text_input.dart';

class PCRView extends StatefulWidget {
  const PCRView({ Key? key }) : super(key: key);

  @override
  State<PCRView> createState() => _PCRViewState();
}

class _PCRViewState extends State<PCRView> {
  var RDtextController = TextEditingController();
  var otrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //TODO doot taliin hoyriig ustgana
     GeneralMeasurements.deviceHeight = MediaQuery.of(context).size.height;
    GeneralMeasurements.deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(givenRadius: 20, hint: 'Регистрийн дугаар', label: 'Регистрийн дугаар',
                           controller: RDtextController, givenWidth: GeneralMeasurements.deviceWidth/100*90,
                           givenHeight: GeneralMeasurements.deviceHeight/100*8, givenMargin: 10,),
            Container(
              margin: EdgeInsets.all(GeneralMeasurements.deviceWidth/100*5),
              child: const Text(
                'Иргэн та өөрийн регистрийн дугаараа оруулан Ковид-19 аль эсвэл Урьдчилан сэргийлэх үзлэгийн үйлчилгээг авахыг сонгоно уу'
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              MyButton(givenRadius: 15, givenWidth: GeneralMeasurements.deviceWidth/100*25, 
                      givenHeight: GeneralMeasurements.deviceHeight/100*6, 
                      btncolor: CommonColors.deepPink, btntext: 'Ковид-19', givenfontSize: 25,).pressExtention((){
              Get.defaultDialog(title: 'ОТР Баталгаажуулалт', content: Container(
                child: Column(children: [
                  SizedBox(
                    width: GeneralMeasurements.deviceWidth/100*60,
                    child:  RichText(text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Таны'),
                      TextSpan(text: '*******', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'утасны дугаарт'),
                      TextSpan(text: '2022-02-12 17:56 нд 154875', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'тусгай дугаараас ирсэн ОТР кодыг оруулна уу')
                      
                    ]
                  )),
                  ),
                  SizedBox(height: 30,),
                  MyTextField(givenHeight: GeneralMeasurements.deviceHeight/100*5, 
                              givenWidth: GeneralMeasurements.deviceWidth/100*60, 
                              controller: otrController, hint: 'ОТР Код оруулна уу', label: 'ОТР Код оруулна уу', 
                              givenMargin: 0, givenRadius: 0,),
                  MyButton(givenWidth: GeneralMeasurements.deviceWidth/100*60, 
                           givenHeight: GeneralMeasurements.deviceHeight/100*5, 
                           btntext: 'Нэвтрэх', btncolor: CommonColors.geregeBlue, givenRadius: 0, givenfontSize: 25,),
                  SizedBox(height: 30,),         
                  SizedBox(
                    width: GeneralMeasurements.deviceWidth/100*60,
                    child: RichText(text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Хэрэв та ОТР кодоо мартсан бол өөрийн бүртгэлтэй утасны дугаараас'),
                        TextSpan(text: '125485', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'тусгай дугаарт'),
                        TextSpan(text: 'ОТР', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'гэж мессеж илгээн кодоо нөхөж авах боломжтой эсвэл ОТР шаардахгүй'),
                        TextSpan(text: 'гэрэгэ апп', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'ыг ашиглана уу'),
                      ],
                  )) ,
                  ),                 
                ],),
              ),);
            }),
              MyButton(givenRadius: 15, givenWidth: GeneralMeasurements.deviceWidth/100*60, 
              givenHeight: GeneralMeasurements.deviceHeight/100*6, btntext: 'Урьдчилан сэргийлэх үзлэг',
               btncolor: CommonColors.geregeBlue, givenfontSize: 25,).pressExtention((){
              
            })
            ],),
          ],
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import '../../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../../MyWidgets/my_button.dart';
import '../../../global_constant.dart';


class SurveyInfoCheck extends StatefulWidget {
  const SurveyInfoCheck({ Key? key }) : super(key: key);

  @override
  State<SurveyInfoCheck> createState() => _SurveyInfoCheckState();
}

class _SurveyInfoCheckState extends State<SurveyInfoCheck> {
  var surveyCreationController = Get.find<CreationCont>();
  var loginController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height:80,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны нэр:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 160,
                    child: myText(surveyCreationController.surveyNametxtCont.text == ''? 
                          'Нэр оруулаагүй байна':surveyCreationController.surveyNametxtCont.text, 15, 1),
                  )
                ],),
                const SizedBox(height: 30,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('огноо:  ', 15, 1, (FontWeight.bold)),
                  myText(surveyCreationController.surveyCreationbody.surveyCreatedDate, 15, 1),
                ],),
                const SizedBox(height: 30,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны төрөл:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 150,
                    child: myText(surveyCreationController.torolStr?? 'Нэрийг оруулаагүй байна.', 15, 1))
                ],),
                const SizedBox(height: 30,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Privacy level:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 200,
                    child: myText(surveyCreationController.levelStr?? 'Нууцлалын түвшинг сонгоогүй байна', 15, 1))
                ],),
                const SizedBox(height: 30,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Асуултын тоо:  ', 15, 1, (FontWeight.bold)),
                  myText(surveyCreationController.newQuestionList.length.toString(), 15, 1),
                ],),
                const SizedBox(height: 30,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('Тусгай асуултын тоо:  ', 15, 1, (FontWeight.bold)),
                  myText(surveyCreationController.toolQuestionCount.value.toString(), 15, 1),
                ],),
                 const SizedBox(height: 30,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('судалгааны арын өнгө:  ', 15, 1, (FontWeight.bold)),
                  Container(
                       margin: const EdgeInsets.all(5),
                       width: 30,
                       height: 30,
                       decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                       color: Color(int.parse(surveyCreationController.surveyCreationbody.surveyClr?? '0xFFFFFFFF')),
                       shape: BoxShape.circle
                         ),
                       ),
                ],)
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: InkWell(
                onTap: (){
                  surveyCreationController.surveyCreationbody.surveyName = surveyCreationController.surveyNametxtCont.text;
                  if( surveyCreationController.surveyCreationbody.surveyName != null && 
                      surveyCreationController.surveyCreationbody.surveyPrivacyLevel != null &&
                      surveyCreationController.surveyCreationbody.surveyType != null){
                    //level, type, color, date 4 songogdoh vydee yavchihaj bgaa 
                  surveyCreationController.surveyCreationbody.userId = loginController.user.result!.userId!;
                  surveyCreationController.surveyCreationbody.questions = surveyCreationController.newQuestionList; 
                  surveyCreationController.surveyCreationbody.researchers = surveyCreationController.researcherPhoneList;
                  Get.offAllNamed(RouteUnits.home);
                  surveyCreationController.surveyCreate();
                  }   
                  else{
                     Get.snackbar('Талбарууд дутуу байна', '', snackPosition: SnackPosition.BOTTOM,
                     colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
                  }
                },
                child: myBtn(CommonColors.yellow, 200, 50, CommonColors.yellow, Colors.white, 'Судалгааг хадаглах'),
              ),)
              ],
            );
  }
}
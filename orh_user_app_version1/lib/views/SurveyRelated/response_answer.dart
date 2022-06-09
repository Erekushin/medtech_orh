import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';


class ResponseAnswers extends StatefulWidget {
  const ResponseAnswers({ Key? key }) : super(key: key);

  @override
  State<ResponseAnswers> createState() => _ResponseAnswersState();
}

class _ResponseAnswersState extends State<ResponseAnswers> {
  var surveyCont = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white
          ),
        child: Column(
          children: [
            const SizedBox(height: 100,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: surveyCont.responseAnswers.result!.answers!.length,
              itemBuilder: (c,i){
                var item = surveyCont.responseAnswers.result!.answers![i];
                String answer;
                if(item.textAnswer != null){
                  answer = item.textAnswer!;
                }
                else if(item.optionAnswer != null){
                  answer = item.optionAnswer!;
                }
                else{
                  answer = '';
                }
                return Column(
                  children: [
                    myText('Асуулт: ' + item.question.toString(), 15, 1),
                    myText('хариулт: ' + answer , 15, 1)
                    ],
                );
              }
              ),
            const SizedBox( height: 100,)
          ],
        ),
      ),
    );
  }
}
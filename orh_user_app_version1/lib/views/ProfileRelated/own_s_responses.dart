import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import '../../MyWidgets/survey_related/survey_unit/attached.dart';

class MyResponds extends StatefulWidget {
  const MyResponds({Key? key}) : super(key: key);

  @override
  State<MyResponds> createState() => _MyRespondsState();
}

class _MyRespondsState extends State<MyResponds> {
  var sCont = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<SurveyController>(builder: (sCont){
        return Stack(
        children: [
          SafeArea(
        child: ListView.builder(
          itemCount: sCont.attachedList.value.result?.length?? 0,
          itemBuilder: (c, i){
          var item = sCont.attachedList.value.result![i];
          return AttachedsUnit(surveyName: item.name!, surveyId: item.id!, itemindx : i);
        }),
      ),
       Visibility(
                visible: sCont.attachedList.value.result == null? true : false,
                child: Image.asset('assets/images/empty_box.jpg')
                )
        ],
      );
      },),
    );
  }
}
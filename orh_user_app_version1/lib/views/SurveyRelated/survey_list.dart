import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/views/home/infoflow_survey_unit.dart';
import '../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../Controllers/SurveyRelated/survey_controller.dart';
import '../../Models/SurveyRelated/survey_list.dart';
import '../../global_constant.dart';
import '../../global_helpers.dart';

class SurveyList extends StatefulWidget {
  const SurveyList({ Key? key }) : super(key: key);
  @override
  State<SurveyList> createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  final argu = Get.arguments;
  final surveyController = Get.find<SurveyController>();
  final loginController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    GlobalHelpers.bottomnavbarSwitcher.add(false);
  }
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: surveyController.listGet(RouteUnits.home, '120006', loginController.user.result!.userId!, ''),
          builder: (context, snapshot){
            if(snapshot.hasData){
              SurveyListBody surveyList = snapshot.data as SurveyListBody;
              return ListView.builder(
          itemCount: surveyList.result!.length,
          itemBuilder: (context, index){
            var item = surveyController.surveyList.value.result![index];
            return SurveyListItem(surveyName: item.name?? "", surveyId: item.id!, itemindx: index, fromRoute: "knowWhere");
          } 
          );
            }
            return SizedBox();
          }
          )
      ),
    );
  }
}
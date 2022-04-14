import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import '../../Controllers/query_controller.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';
import '../../global_helpers.dart';

class QueryList extends StatefulWidget {
  const QueryList({ Key? key }) : super(key: key);

  @override
  State<QueryList> createState() => _QueryListState();
}

class _QueryListState extends State<QueryList> {
  final queryController = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          physics:
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
             GetX<SurveyController>(builder: (queryController){
                  return Container( //child heart query btn
                  margin: EdgeInsets.all(GeneralMeasurements.deviceWidth*.05),
                  height: GeneralMeasurements.deviceHeight*.1,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff040039).withOpacity(.15),
                      blurRadius: 99,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
                  child:Row(children: [
                  const SizedBox(width: 10,),
                  Container(
                    height: GeneralMeasurements.deviceWidth / 8,
                    width: GeneralMeasurements.deviceWidth / 8,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: queryController.childHeartQuerybtnloading.value? const CircularProgressIndicator() 
                    : const Icon(
                      Icons.assessment,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: GeneralMeasurements.deviceWidth*.7,
                    child: myText('Судалгааны нэр мэдэгдэхгүй байна', 17, 1, FontWeight.w700), //queryController.childHeartQuery.result!.title??
                  )
              ],)
            ).pressExtention((){
              try{
                queryController.isResearcherAuth();
              }
              catch(e){
                Get.snackbar('Алдаа', '$e', snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(left: 5, right: 5, bottom: GeneralMeasurements.snackbarBottomMargin));
              }
              
            });
                  }),
          ],
        ),
      ),
    );
  }
}
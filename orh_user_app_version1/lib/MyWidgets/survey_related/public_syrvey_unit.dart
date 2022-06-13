import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/SurveyRelated/survey_controller.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';
class PublicSurveyUnit extends StatefulWidget {
  const PublicSurveyUnit({ Key? key,required this.surveyName, required this.surveyId, 
                         required this.itemindx, required this.fromRoute, required this.surveyColor}) : super(key: key);
  final String fromRoute;
  final String surveyName;
  final int surveyId;
  final int itemindx;
  final String surveyColor;
  @override
  State<PublicSurveyUnit> createState() => _PublicSurveyUnitState();
}
class _PublicSurveyUnitState extends State<PublicSurveyUnit> {
  @override
  Widget build(BuildContext context) {
    return GetX<SurveyController>(builder: (surveyController){
                  return GestureDetector(
                    onTap: (){
                       try{
                          surveyController.chosenSurveyId = widget.surveyId;
                           surveyController.publicSurveyList.value.result![widget.itemindx].loading.value = true;
                           surveyController.surveyGet(widget.itemindx, widget.surveyColor, RouteUnits.home);
                       }
                       catch(e){
                        Get.snackbar('Алдаа', '$e', snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(left: 5, right: 5, bottom: GeneralMeasurements.snackbarBottomMargin));
                       }
                    },
                    child: Container(
                  margin: EdgeInsets.all(GeneralMeasurements.deviceWidth*.05),
                  height: GeneralMeasurements.deviceHeight*.15,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: surveyController.publicSurveyList.value.result![widget.itemindx].borderColor.value),
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
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  SizedBox(
                    width: GeneralMeasurements.deviceWidth*.7,
                    child: myText(widget.surveyName, 17, 1, FontWeight.w700), //queryController.childHeartQuery.result!.title??
                  ),
                  surveyController.publicSurveyList.value.result![widget.itemindx].loading.value? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 3,)) 
                    : const Icon(
                      Icons.article,
                      color: Colors.blue,
                    ),
              ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                  Row(children:[
                    CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                            backgroundImage: const AssetImage('assets/images/user_default.png'),  
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90.0),
                              child: const SizedBox())
                              // AspectRatio( 
                              //   aspectRatio: 1/1,
                              //   child: Image.memory(Uint8List.fromList(surveyController.surveyList.value.result![widget.itemindx].creatorPicture!)))
                         ),
                          const SizedBox(width: 10,),
                    Text(surveyController.publicSurveyList.value.result![widget.itemindx].creatorName!, style: TextStyle(fontWeight: FontWeight.bold),)      
                  ],),
                  Row(
                    children: [
                      IconButton(
                  icon: Image.asset('assets/icon/coin.png'),
                  onPressed: (){},
                  ),
                  const Text('50 tug')
                    ],
                  )
                ],
              )
                    ],
                  )
            )
                  );
                  });
  }
}
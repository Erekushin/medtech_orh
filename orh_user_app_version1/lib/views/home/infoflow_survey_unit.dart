import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/SurveyRelated/survey_controller.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';
class SurveyListItem extends StatefulWidget {
  const SurveyListItem({ Key? key,required this.surveyName, required this.surveyId, 
                         required this.itemindx, required this.fromRoute }) : super(key: key);
  final String fromRoute;
  final String surveyName;
  final int surveyId;
  final int itemindx;
  @override
  State<SurveyListItem> createState() => _SurveyListItemState();
}
class _SurveyListItemState extends State<SurveyListItem> {
  @override
  Widget build(BuildContext context) {
    return GetX<SurveyController>(builder: (surveyController){
                  return GestureDetector(
                    onLongPress: (){
                      switch(widget.fromRoute){
                        case "home":

                        break;
                        case "profile":
                          surveyController.surveyDeleteIcon.value = true;
                          surveyController.surveyList.value.result!.items![widget.itemindx].borderColor.value = Colors.red;
                          surveyController.chosenSurveyIndx = widget.itemindx;
                          surveyController.chosenSurveyId = widget.surveyId;
                        break;
                      }
                      },
                    onTap: (){
                       try{
                         switch(widget.fromRoute){
                           case "home" :
                           surveyController.chosenSurveyId = widget.surveyId;
                           surveyController.surveyList.value.result!.items![widget.itemindx].loading.value = true;
                           surveyController.surveyGet(widget.itemindx);
                           break;
                           case "profile" :
                           surveyController.chosenSurveyId = widget.surveyId;
                           surveyController.responsesListGet();
                           break;
                         }
                         
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
                    border: Border.all(color: surveyController.surveyList.value.result!.items![widget.itemindx].borderColor.value),
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
                  surveyController.surveyList.value.result!.items![widget.itemindx].loading.value? const SizedBox(
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
                  Row(children: const [
                    CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                            backgroundImage: AssetImage('assets/images/Avatar.jpg'),
                          ),
                          SizedBox(width: 10,),
                    Text('Буян-хишиг', style: TextStyle(fontWeight: FontWeight.bold),)      
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
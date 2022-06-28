import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/SurveyRelated/survey_controller.dart';
import '../../../global_constant.dart';
import '../../my_text.dart';
class AttachedsUnit extends StatefulWidget {
  const AttachedsUnit({ Key? key,required this.surveyName, required this.surveyId, 
                         required this.itemindx}) : super(key: key);
  final String surveyName;
  final int surveyId;
  final int itemindx;
  @override
  State<AttachedsUnit> createState() => _AttachedsUnitUnitState();
}
class _AttachedsUnitUnitState extends State<AttachedsUnit> {
  @override
  Widget build(BuildContext context) {
    return GetX<SurveyController>(builder: (surveyController){
                  return GestureDetector(
                    onTap: (){
                       try{
                           surveyController.chosenSurveyId = widget.surveyId;
                           surveyController.attachedList.value.result![widget.itemindx].loading.value = true;
                           surveyController.respondResearchersListGet(widget.itemindx);
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
                      color: surveyController.attachedList.value.result![widget.itemindx].borderColor.value),
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
                    child: myText(widget.surveyName, 17, 1, FontWeight.w700),
                  ),
                  surveyController.attachedList.value.result![widget.itemindx].loading.value? const SizedBox(
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
                              //   child: Image.memory(Uint8List.fromList(surveyController.attachedList.value.result![widget.itemindx].creatorPicture!)))
                         ),
                          const SizedBox(width: 10,),
                    Text(surveyController.attachedList.value.result![widget.itemindx].creatorName!, style: TextStyle(fontWeight: FontWeight.bold),)      
                  ],),
                  // Row(
                  //   children: [
                  //     IconButton(
                  // icon: Image.asset('assets/icon/coin.png'),
                  // onPressed: (){},
                  // ),
                  // const Text('50 tug')
                  //   ],
                  // )
                ],
              )
                    ],
                  )
            )
                  );
                  });
  }
}
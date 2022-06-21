import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/scroll_behavior.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../../Models/SurveyRelated/survey_creation_body.dart';
import '../../../Models/SurveyRelated/survey_creation_types.dart';

class SurveyCreationGeneral extends StatefulWidget {
  const SurveyCreationGeneral({ Key? key }) : super(key: key);
  @override
  State<SurveyCreationGeneral> createState() => _SurveyCreationGeneralState();
}

class _SurveyCreationGeneralState extends State<SurveyCreationGeneral> {
  var sCCont = Get.find<CreationCont>();
  bool red = false;
  bool orange = false;
  bool blue = false;
  bool purple = false;
  bool white = false;
  List<DropdownMenuItem<String>> dropitems(List<TypeInfo> itemlist, String key){
      return itemlist.map((item){
           return DropdownMenuItem(
             value: item.typeName.toString(),
             child: Text(item.typeName!),
             onTap: (){
               switch(key){
                 case 'surveyType':
                 sCCont.surveyCreationbody.surveyType = item.typeId;
                 break;
                 case 'surveyLevel':
                 sCCont.surveyCreationbody.surveyPrivacyLevel = item.typeId;
                 break;
               }
             },
             );
           }).toList();
    }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 120, bottom: 10),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const Text('Судалгаа үүсгэх', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  TextField(// ner oruulah
                      controller: sCCont.surveyNametxtCont,
                      decoration: const InputDecoration(
                        hintText: 'Судалгааны нэрийг оруулах'
                      ),
                    ),
                  const SizedBox(height: 20,),
                  Column(// torol songoh
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText('Судалгааны төрөл', 11, 1, FontWeight.bold),
                    DropdownButton<String>(
                  hint: myText('Судалгааны төрөл', 16, 1),
                  value: sCCont.torolStr,
                  onChanged: (String? newValue) {
                    setState(() {
                      sCCont.torolStr = newValue.toString();
                    });
                    switch(newValue){
                      case 'хязгаартай':
                       sCCont.limitCountVis.value = true;
                      break;
                      case 'хязгааргүй':
                       sCCont.limitCountVis.value = false;
                      break;

                    }
                  },
                  underline: const SizedBox(),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: dropitems(sCCont.surveyCreationTypes.result!.surveyType !, 'surveyType')
                ),
                    Visibility(
                      visible: sCCont.limitCountVis.value,
                      child: TextField(
                    keyboardType: TextInputType.number,
                    controller: sCCont.surveyInputLimitation,
                    decoration: const InputDecoration(
                      hintText: 'Судалгааг хэдэн удаа бөглөх боломтой вэ?'
                    ),
                  ))
                  ],
                ),
                const SizedBox(height: 20,),
                  Column(// level songoh
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText('Нууцлалын түвшин', 11, 1, FontWeight.bold),
                    DropdownButton<String>(
                  hint: myText('Нууцлалын түвшин', 16, 1),
                  value: sCCont.levelStr,
                  onChanged: (String? newValue) {
                    setState(() {
                      print(newValue);
                      sCCont.levelStr = newValue.toString();
                      switch(newValue){
                      case 'public':
                       sCCont.researchetTextController.clear();
                       sCCont.researcherPhoneList.clear();
                      break;
                      case 'segmented':
                       sCCont.researchetTextController.add(TextEditingController());
                       sCCont.researcherPhoneList.add(Researchers());
                      break;
                    }
                    });
                  },
                  underline: const SizedBox(),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: dropitems(sCCont.surveyCreationTypes.result!.privacyLevel!, 'surveyLevel')
                ),
                Container(//option container
                  margin: const EdgeInsets.only(left: 50),
                  child: Expanded(
                    child: GetX<CreationCont>(
                      builder: (surveyControllermini){
                        return ListView.builder(
                    shrinkWrap: true,
                    itemCount: surveyControllermini.researchetTextController.length,
                    itemBuilder: (context, index){
                      return Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: TextField(
                              onChanged: (string){
                                surveyControllermini.researcherPhoneList[index].researcherPhone = string;
                              },
                              controller: sCCont.researchetTextController[index],
                              decoration: const InputDecoration(
                                   disabledBorder: InputBorder.none,
                                   hintText: 'судлаач нэмэх',
                                   enabledBorder: InputBorder.none,
                                   focusedBorder: InputBorder.none
                                 ),
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                surveyControllermini.researchetTextController.add(TextEditingController());
                                surveyControllermini.researcherPhoneList.add(Researchers());
                              });
                            }, 
                            icon: const Icon(Icons.add)
                            )
                        ],
                      );
                    }
                    );
                      }
                      ),
                  ),
                )
                  ],
                ),
                const SizedBox(height: 20,),
                  Column(// ongo songoh
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Судалгаанд өнгө нэмэх'),
                      Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [ 
                                     InkWell(
                                      onTap: (){
                                        setState((){
                                        sCCont.surveyCreationbody.surveyClr = '0xFF88C9B1';  
                                        blue = true;
                                        red = false;
                                        white = false;
                                        purple = false;
                                        orange = false;
                                        });
                                      },
                                      child: Container(
                                         margin: const EdgeInsets.all(5),
                                         width: 30,
                                         height: 30,
                                         decoration: const BoxDecoration(
                                         color: Colors.blue,
                                         shape: BoxShape.circle
                                         ),
                                         child:  Visibility(
                                          visible: blue,
                                          child: Icon(
                                            Icons.check,
                                            size: GeneralMeasurements.deviceHeight/100*4,
                                            color: Colors.green,
                                          ),
                                         )
                                       ),
                                    ),
                                     InkWell(
                                      onTap: (){
                                        setState((){
                                        sCCont.surveyCreationbody.surveyClr = '0xFF9375B0'; 
                                        purple = true;
                                        red = false;
                                        white = false;
                                        blue = false;
                                        orange = false;});
                                      },
                                      child: Container(
                                         margin: const EdgeInsets.all(5),
                                         width: 30,
                                         height: 30,
                                         decoration: const BoxDecoration(
                                         color: Colors.purple,
                                         shape: BoxShape.circle
                                         ),
                                         child:  Visibility(
                                          visible: purple,
                                          child: Icon(
                                            Icons.check,
                                            size: GeneralMeasurements.deviceHeight/100*4,
                                            color: Colors.green,
                                          ),
                                         )
                                       ),
                                    ),
                                     InkWell(
                                      onTap: (){
                                        setState((){
                                        sCCont.surveyCreationbody.surveyClr = '0xFFC35C74';
                                        red = true;
                                        purple = false;
                                        white = false;
                                        blue = false;
                                        orange = false;});
                                      },
                                      child: Container(
                                         margin: const EdgeInsets.all(5),
                                         width: 30,
                                         height: 30,
                                         decoration: const BoxDecoration(
                                         color: Colors.red,
                                         shape: BoxShape.circle
                                         ),
                                         child:  Visibility(
                                          visible: red,
                                          child: Icon(
                                            Icons.check,
                                            size: GeneralMeasurements.deviceHeight/100*4,
                                            color: Colors.green,
                                          ),
                                         )
                                       ),
                                    ),
                                     InkWell(
                                      onTap: (){
                                        setState((){
                                        sCCont.surveyCreationbody.surveyClr = '0xFFFFAB40'; 
                                        orange = true;
                                        red = false;
                                        white = false;
                                        blue = false;
                                        purple = false;});
                                      },
                                      child: Container(
                                         margin: const EdgeInsets.all(5),
                                         width: 30,
                                         height: 30,
                                         decoration: const BoxDecoration(
                                         color: Colors.orange,
                                         shape: BoxShape.circle
                                         ),
                                         child:  Visibility(
                                          visible: orange,
                                          child: Icon(
                                            Icons.check,
                                            size: GeneralMeasurements.deviceHeight/100*4,
                                            color: Colors.green,
                                          ),
                                         )
                                       ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState((){
                                        sCCont.surveyCreationbody.surveyClr = '0xFFFFFFFF';
                                        white = true;
                                        red = false;
                                        blue = false;
                                        purple = false;
                                        orange = false;});
                                      },
                                      child: Container(
                                         margin: const EdgeInsets.all(5),
                                         width: 30,
                                         height: 30,
                                         decoration: BoxDecoration(
                                           border: Border.all(color: Colors.grey.shade300),
                                         color: Colors.white,
                                         shape: BoxShape.circle
                                         ),
                                         child:  Visibility(
                                          visible: white,
                                          child: Icon(
                                            Icons.check,
                                            size: GeneralMeasurements.deviceHeight/100*4,
                                            color: Colors.green,
                                          ),
                                         )
                                       ),
                                    ),
                                  ],
                                )
                    ],
                  ),
                  ],
                ),
          ),
        ),
      )
      );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Controllers/child_heart_query_controller.dart';
import '../../MyWidgets/my_button.dart';
import '../../MyWidgets/my_dropdown.dart';
import '../../MyWidgets/my_radiobtn.dart';
import '../../MyWidgets/my_text.dart';
import '../../MyWidgets/my_textfield.dart';
import '../../global_constant.dart';
import '../../models/aimags.dart';

class ChildHeartQuery extends StatefulWidget {
  const ChildHeartQuery({ Key? key }) : super(key: key);
  @override
  State<ChildHeartQuery> createState() => _ChildHeartQueryState();
}
class _ChildHeartQueryState extends State<ChildHeartQuery> {
  @override
  void initState() {
    super.initState();
  }
  String? aimagSelectVal;
  String? sumSelectVal;
  bool infoContainerAnimation = false;
  List<DropdownMenuItem<String>> aimagItems(List<Aimags> aimagList){
    return aimagList.map((item){
            return DropdownMenuItem(
                onTap: (){
                  Get.find<ChildHeartQueryController>().defaultData.aimagCode = int.parse(item.aimagCode!);
                  Get.find<ChildHeartQueryController>().chosenAimag.value = aimagList.indexOf(item);
                },
                value: item.aimagName,
                child: Text(item.aimagName!)
            );
          }).toList();
  }
  List<DropdownMenuItem<String>> sumItems(List<Sums> sumList){
    return sumList.map((item){
            return DropdownMenuItem(
                onTap: (){
                  Get.find<ChildHeartQueryController>().defaultData.sumCode = int.parse(item.sumCode!);
                },
                value: item.sumName,
                child: Text(item.sumName!)
            );
          }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<ChildHeartQueryController>(builder: (childheartQueryController){
          return  Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myText('Хүүхдийн зүрхний эмгэг илрүүлэх судалгаа', 25, 1),
              const SizedBox(height: 20,),
              
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey.withOpacity(.2)
                ),
                child: Stack(
                  children: [
                    Visibility(
                      visible: infoContainerAnimation? false : true,
                      child: Row(
                        children: [
                          Text(childheartQueryController.defaultData.currentdate + " " + 
                               childheartQueryController.defaultData.aimagName + " " +
                               childheartQueryController.defaultData.sumName )
                        ],
                      ).pressExtention((){
                        setState(() {
                          infoContainerAnimation = true;
                        });
                      }),
                    ),
                    Visibility(
                      visible: infoContainerAnimation? true : false,
                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             myText('Судалгаа хийсэн огноо:', 16, 1.5),
                             Icon(
                               Icons.check_circle,
                               color: childheartQueryController.checkColor.value,
                               ).pressExtention((){
                               setState(() {
                                 infoContainerAnimation = false;
                               });
                             })
                          ],
                        ),                
                       
                        myText(childheartQueryController.currentDate.toString().substring(0,10), 16, 1.5),
                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
                          child: DropdownButton<String>(
                            hint: myText('Аймаг, хотын нэр?', 16, 2),
                            value: aimagSelectVal,
                            onChanged: (String? newValue){
                              setState(() {
                                aimagSelectVal = newValue.toString();
                                sumSelectVal = null;
                              });
                            },
                            underline: const SizedBox(),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(5),
                            items: aimagItems(GlobalHelpers.aimagList.aimags!)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
                          child: DropdownButton<String>(
                            hint: myText('Сум, дүүргийн нэр?', 16, 2),
                            value: sumSelectVal,
                            onChanged: (String? newValue){
                              childheartQueryController.checkData();
                              setState(() {
                                sumSelectVal = newValue.toString();
                              });
                            },
                            underline: const SizedBox(),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(5),
                            items: sumItems(GlobalHelpers.aimagList.aimags![childheartQueryController.chosenAimag.value].sums!)
                          ),
                        )
                                      ],
                                    ),
                    )
                  ],
                ),
              ),
              myTextField('Оролцогчийн овог', childheartQueryController.textControllers.ovog, 10, 10, 10, 10),
              myTextField('Оролцогчийн нэр', childheartQueryController.textControllers.ner, 10, 10, 10, 10),
              myTextField('Утасны дугаар', childheartQueryController.textControllers.phone, 10, 10, 10, 10),
              MyDropdown(dropDownHint: 'Сургуульд суралцдаг эсэх', listitems: [], 
                         currentValue: 5, mark: 'mark', givenModelType: String, marginb: 10, marginl: 10, marginr: 10, margint: 10,),
              MyYesNoRadioBtn(w: 15, name: 'Зүрхний цахилгаан бичлэг хийлгэсэн эсэх', listitems: ['fgf', 'fgfgf']),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(givenWidth: GeneralMeasurements.deviceWidth*.5, givenHeight: 
                  GeneralMeasurements.deviceHeight*.05, btntext: 'Судалгааг дуусгах',
                       btncolor: CommonColors.geregeBlue, givenRadius: 10, givenfontSize: 15,),
                ],
              ),
            ],
          ),
        );
        }),
      ),
    );
  }
}
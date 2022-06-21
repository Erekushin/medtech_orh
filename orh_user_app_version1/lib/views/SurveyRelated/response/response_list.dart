import 'package:flutter/material.dart';
import '../../../Controllers/SurveyRelated/survey_controller.dart';
import '../../../MyWidgets/my_text.dart';
import '../../../global_constant.dart';
import 'package:get/get.dart';

class ResList extends StatefulWidget {
  const ResList({Key? key}) : super(key: key);

  @override
  State<ResList> createState() => _ResListState();
}

class _ResListState extends State<ResList> {
  var surveyCont = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Stack(
        children: [
          ListView.builder(
      itemCount: surveyCont.surveyResponses.result?.length?? 0,
      itemBuilder: (c, i){
        var item = surveyCont.surveyResponses.result![i];
        String? c = item.createdDate;
        String? n =item.researcherName;
        return   InkWell(onTap: (){surveyCont.responseAnswersGet(c!);},
                         child: Container(
                  margin: EdgeInsets.all(GeneralMeasurements.deviceWidth*.02),
                  height: GeneralMeasurements.deviceHeight*.08,
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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: GeneralMeasurements.deviceWidth*.7,
                               child: myText('$c $n', 17, 1, FontWeight.w700),),
                    ],
                  )
                 )
               ); 
      },
    ),
     Visibility(visible: surveyCont.surveyResponses.result == null? true : false,
                child: Image.asset('assets/images/empty_box.jpg'))
        ],
      )
    );
  }
}

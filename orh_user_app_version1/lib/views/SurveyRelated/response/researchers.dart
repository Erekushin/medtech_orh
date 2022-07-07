import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/SurveyRelated/response.dart';
import '../../../MyWidgets/my_text.dart';
import '../../../global_constant.dart';


class ResponseResearchers extends StatefulWidget {
  const ResponseResearchers({ Key? key }) : super(key: key);

  @override
  State<ResponseResearchers> createState() => _ResponseResearcherssesState();
}

class _ResponseResearcherssesState extends State<ResponseResearchers> {
  var resCont = Get.find<ResCont>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
      Stack(
        children: [
          ListView.builder(
      itemCount: resCont.surveyRLst.result?.length?? 0,
      itemBuilder: (c, i){
        var item = resCont.surveyRLst.result![i];
        String? name = item.name;
        return  InkWell(
                        onTap: (){
                          resCont.responses(name!);
                        },
                        child:  Container(
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
                      SizedBox(
                                          width: GeneralMeasurements.deviceWidth*.7,
                                          child: myText('$name', 17, 1, FontWeight.w700),
                                        ),
                    ],
                  )
            )
                      )
       ; 
      },
    ),
     Visibility(
                visible: resCont.surveyRLst.result == null? true : false,
                child: Image.asset('assets/images/empty_box.jpg')
                )
        ],
      ));
  }
}
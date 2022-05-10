import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/calculator_controller.dart';

import '../../Controllers/survey_controller.dart';
import '../../MyWidgets/my_reciever_unit.dart';
import '../../global_constant.dart';


class ButtonStructure {  
  const ButtonStructure({required this.title, required this.route, required this.imgUrl});  
  final String title;  
  final String route;
  final String imgUrl;
}  
  
List<ButtonStructure> bigButtons = const <ButtonStructure>[  //60/(174*174)*10000 jin/(ondor*ondor)*10000
  ButtonStructure(title: 'BMI', route: "/bmi", imgUrl: 'https://res.cloudinary.com/grohealth/image/upload/f_auto,fl_lossy,q_auto/v1583505191/DCUK/Content/iStock-528072248-1000x600.jpg'  ),  
  ButtonStructure(title: 'BMR', route: "", imgUrl: 'https://nabtahealth.com/wp-content/uploads/2020/01/what-is-basal-metabolic-rate-bmr-8-2-2-3.png'),  
];

Widget profileBigButton(ButtonStructure structureInfo){
  var calculatorController = Get.find<CalculatorController>();
  var surveyControllerOut = Get.find<SurveyController>(); 
  return InkWell(
    onTap: (){
      Get.defaultDialog(title: 'Body Mass Index', content: SizedBox(
        child: SingleChildScrollView(
          child: ListView.builder(
          shrinkWrap: true,  
          itemCount: calculatorController.indicatorQuestions.result!.questions!.length,
          itemBuilder: (context, index){
            surveyControllerOut.textEditingControllers.add(TextEditingController());
            surveyControllerOut.dropvalueList.add(DropSelectVal());
            var item = calculatorController.indicatorQuestions.result!.questions![index];
            return RecieverUnit(questionID: item.id!, type: item.type, questionText: item.questionText, 
                                        questionIndex: index, options: []);
          }
          ),
        )
      ),
    actions: <Widget>[TextButton(onPressed: (){
      var bmi = calculatorController.bodyMassCalculate();
    }, child: const Text("Бодох", style: TextStyle(fontSize: 20),)), 
    ]);
    },
    child: Container(
      margin: const EdgeInsets.all(5),
      height: GeneralMeasurements.deviceHeight/100*30,
      decoration: BoxDecoration(
                     border: Border.all(color: Colors.blueAccent),
                     borderRadius: const BorderRadius.all(Radius.circular(15)),
                     boxShadow: [
                       BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 0.1,
                        blurRadius: 10, offset: const Offset(0, 7))
                     ]
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
                        Radius.circular(15)),
            child:  FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.jpg',
                      image: structureInfo.imgUrl,fit: BoxFit.fill,),
          ),
          Column(  
            crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,  
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(structureInfo.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  ),  
                  Container(
                    height: GeneralMeasurements.deviceHeight/100*8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      color: Colors.blueAccent
                    ),
                  )
                ]  
            )
        ],
      ),
    ),
  );
}

class CalculatorsHome extends StatefulWidget {
  const CalculatorsHome({ Key? key }) : super(key: key);

  @override
  State<CalculatorsHome> createState() => _CalculatorsHomeState();
}

class _CalculatorsHomeState extends State<CalculatorsHome> {
  var calculatorController = Get.find<CalculatorController>();
  @override
  void initState() {
    super.initState();
    calculatorController.getIndicatorQuestionList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView.builder(
          itemCount: bigButtons.length,
          itemBuilder: (context, index){
            return profileBigButton(bigButtons[index]);
          }
          ),
      ),
    );
  }
}
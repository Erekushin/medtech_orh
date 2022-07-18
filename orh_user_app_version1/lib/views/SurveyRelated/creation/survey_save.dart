import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../../MyWidgets/my_button.dart';
import '../../../global_constant.dart';
import 'dart:math';
import 'package:graphview/GraphView.dart';


class SurveyInfoCheck extends StatefulWidget {
  const SurveyInfoCheck({ Key? key }) : super(key: key);

  @override
  State<SurveyInfoCheck> createState() => _SurveyInfoCheckState();
}

class _SurveyInfoCheckState extends State<SurveyInfoCheck> {
  var sCCont = getx.Get.find<CreationCont>();
  var loginController = getx.Get.find<AuthController>();
  int _iterations = 600;
  Argu arg = Argu();
  @override
  Widget build(BuildContext context) {
      final Graph graph = Graph();
    // ! Create nodes
    final nodes = <Node>[];
    for (int i = 0; i < sCCont.surveys.length; ++i){
      nodes.add(Node.Id(sCCont.surveys.elementAt(i).connectedid));
    }
    for(int w = 0; w < sCCont.surveys.length; w++){
      for(int q = w+1; q < sCCont.surveys.length; q++){
        if(sCCont.surveys[w].connectedid== sCCont.surveys[q].preconnected){
          Node node1 = nodes.firstWhere((element) => element.key!.value == sCCont.surveys[w].connectedid!);
          Node node2 = nodes.firstWhere((element) => element.key!.value == sCCont.surveys[q].connectedid!);
          graph.addEdge(node1, node2);
        }
      }
    }
    final algo = FruchtermanReingoldAlgorithm(iterations: _iterations)
          ..rand = Random(/*seed=*/ 10) // For deterministic rendering
        ;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                const SizedBox(height:40,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны нэр:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 160,
                    child: myText(sCCont.surveyNametxtCont.text == ''? 
                          'Нэр оруулаагүй байна':sCCont.surveyNametxtCont.text, 15, 1),
                  )
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('огноо:  ', 15, 1, (FontWeight.bold)),
                  myText(sCCont.surveyCreationbody.surveyCreatedDate, 15, 1),
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны тоо:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 150,
                    child: myText(sCCont.counttypeStr?? 'тооны төрлийг сонгоогүй байна.', 15, 1))
                ],),
                 const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны төрөл:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 150,
                    child: myText(sCCont.torolStr?? 'төрлийг сонгоогүй байна.', 15, 1))
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Privacy level:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 200,
                    child: myText(sCCont.levelStr?? 'Нууцлалын түвшинг сонгоогүй байна', 15, 1))
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Асуултын тоо:  ', 15, 1, (FontWeight.bold)),
                  myText(sCCont.newQuestionList.length.toString(), 15, 1),
                ],),
                const SizedBox(height: 20,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('Тусгай асуултын тоо:  ', 15, 1, (FontWeight.bold)),
                  myText(sCCont.toolQuestionCount.value.toString(), 15, 1),
                ],),
                 const SizedBox(height: 20,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('судалгааны арын өнгө:  ', 15, 1, (FontWeight.bold)),
                  Container(
                       margin: const EdgeInsets.all(5),
                       width: 30,
                       height: 30,
                       decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                       color: Color(int.parse(sCCont.surveyCreationbody.surveyClr?? '0xFFFFFFFF')),
                       shape: BoxShape.circle
                         ),
                       ),
                ],),
                 const SizedBox(height: 20,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('Зураглал харах: ', 15, 1, (FontWeight.bold)),
                  TextButton(
                        onPressed: (){
                         showDialog(context: context, builder: (context) => SingleChildScrollView(
                          child: StatefulBuilder(
                            builder: (contextt, setState) => AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
		                            borderRadius: BorderRadius.circular(30),
	                            ),
                              title: const Text('Зураглал'),
                              content: Container(
                                   color: Colors.white,
                                   width: GeneralMeasurements.deviceWidth*.8,
                                   height: GeneralMeasurements.deviceHeight*.6,
                                   child: InteractiveViewer(
                                       constrained: false,
                                       // scaleEnabled: false,
                                       minScale: 0.35,
                                       maxScale: 5,
                                       boundaryMargin: const EdgeInsets.all(100),
                                       child: GraphView(
                                           graph: graph,
                                           builder: (node) {
                                             // Render the node as any widget
                                             final connectedId = node.key!.value as int;
                                             return Chip(
                                               label: InkWell(
                                                 onTap: (){
                                                  print('dfdffd');
                                                   int idx = sCCont.surveys.indexOf(sCCont.surveys.firstWhere((element) => element.connectedid == connectedId));
                                                   sCCont.surveyCreate("levelupOnChosen", idx);
                                                 },
                                                 
                                                 child: Text('асуумж $connectedId')),
                                               backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)][100],
                                             );
                                           },
                                           algorithm: algo,
                                         ),
                                     ),
                                   )
                            ),
                          ),
                         ));
                        },
                        child: const Text('харах'),
                      ),
                ],)
                  ],
                ),
                Column(
                  children: [
              InkWell(
                onTap: (){
                  sCCont.surveyCreate("variationup", 0);
                },
                child: myBtn(CommonColors.deepPink, 200, 50, CommonColors.deepPink, Colors.white, 'Хувилбар нэмэх'),
              ),
              InkWell(
                onTap: (){
                  sCCont.surveyCreate("levelup", 0);
                },
                child: myBtn(CommonColors.geregeBlue, 200, 50, CommonColors.geregeBlue, Colors.white, 'Дараагийн шат'),
              ),
              InkWell(
                onTap: (){
                  sCCont.surveyCreate("save", 0);
                },
                child: myBtn(CommonColors.yellow, 200, 50, CommonColors.yellow, Colors.white, 'Судалгааг хадаглах'),
              ),
              const SizedBox(height: 20,)
                  ],
                ),
              ],
            );
  }
}








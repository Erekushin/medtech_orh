import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import '../../Controllers/survey_controller.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';
import '../../global_helpers.dart';

class SurveyList extends StatefulWidget {
  const SurveyList({ Key? key }) : super(key: key);

  @override
  State<SurveyList> createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  final surveyController = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
        ListView.builder(
          itemCount: surveyController.surveyListbody.result!.items!.length,
          itemBuilder: (context, index){
            var item = surveyController.surveyListbody.result!.items![index];
            return SurveyListItem(surveyName: item.name?? "", surveyId: item.id!,);
          } 
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(bottom: 80, right: 20),
            child: InkWell(
              onTap: (){
                Get.toNamed(RouteUnits.surveyCreation);
              },
              child: myBtn(CommonColors.geregeBlue, 150, 50, CommonColors.geregeBlue, Colors.white, 'Судалгаа нэмэх'),
            ),
          ),
        )
          ],  
        ),
      ),
    );
  }
}

class SurveyListItem extends StatefulWidget {
  const SurveyListItem({ Key? key,required this.surveyName, required this.surveyId }) : super(key: key);
  final String surveyName;
  final int surveyId;
  @override
  State<SurveyListItem> createState() => _SurveyListItemState();
}

class _SurveyListItemState extends State<SurveyListItem> {
  @override
  Widget build(BuildContext context) {
    return GetX<SurveyController>(builder: (surveyController){
                  return InkWell(
                    onTap: (){
                       try{
                         surveyController.chosenSurvey = widget.surveyId;
                         surveyController.surveyQuestionsGet();
                       }
                       catch(e){
                        Get.snackbar('Алдаа', '$e', snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(left: 5, right: 5, bottom: GeneralMeasurements.snackbarBottomMargin));
                       }
                    },
                    child: Container( //child heart query btn
                  margin: EdgeInsets.all(GeneralMeasurements.deviceWidth*.05),
                  height: GeneralMeasurements.deviceHeight*.15,
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
                  surveyController.childHeartQuerybtnloading.value? const CircularProgressIndicator() 
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
                  Text('50 tug')
                    ],
                  )
                ],
              )
                    ],
                  )
            ),
                  );
                  });
  }
}
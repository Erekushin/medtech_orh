import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_list.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import 'package:orh_user_app_version1/views/home/infoflow_survey_unit.dart';

import '../../Controllers/SurveyRelated/survey_controller.dart';
import '../../Controllers/image_controller.dart';
import '../../Controllers/profile_controller.dart';

class ButtonStructure {  
  const ButtonStructure({required this.title, required this.icon, required this.route, this.argument});  
  final String title;  
  final IconData icon;
  final String route; 
  final dynamic argument;
}  
  
List<ButtonStructure> bigButtons = <ButtonStructure>[  
  ButtonStructure(title: 'Mэдээлэл', icon: Icons.person, route: RouteUnits.profileInfo),  
  ButtonStructure(title: 'Онош Түүх', icon: Icons.history, route: RouteUnits.profileDiagnosisHistory),  
  ButtonStructure(title: 'Миний Судалгаа', icon: Icons.token, route: RouteUnits.mySurveys, 
  argument: {'user_id':'1'}),  
  ButtonStructure(title: 'Device Log', icon: Icons.book, route: RouteUnits.profileDeviceLog)  
]; 

Widget profileBigButtons(ButtonStructure structureInfo){
  return InkWell(
    onTap: (){Get.toNamed(structureInfo.route, arguments: structureInfo.argument);},
    child: Container(
      margin: EdgeInsets.all(10),
    width: GeneralMeasurements.deviceWidth/10*6,
    height: GeneralMeasurements.deviceHeight/100*10,
    decoration: BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(15)),
                   color: Colors.white,
                   boxShadow: [
                     BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 0.1,
                      blurRadius: 10, offset: const Offset(0, 7))
                   ]
    ),
    child: Row(  
              mainAxisAlignment: MainAxisAlignment.center,  
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: CommonColors.geregeBlue.withOpacity(0.1),
                  child: Icon(structureInfo.icon, size:30.0, color: CommonColors.geregeBlue),
                ),  
                const SizedBox(width: 1, height: 10,),
                Text(structureInfo.title, style: const TextStyle(fontWeight: FontWeight.bold),),
              ]  
          ),
  ),
  );
}



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var surveyController = Get.find<SurveyController>();
  var loginController = Get.find<AuthController>();
  var scrollController = ScrollController();
  GlobalKey<ScaffoldState> sidePageKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(viewportFraction: 0.85);
  final argu = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(argu == RouteUnits.profile){
          GlobalHelpers.bottomnavbarSwitcher.add(false);
        }
        else{
          
        }
        return true;
      },
      child: Scaffold(
        key: sidePageKey,
        endDrawer: const ProfileSidebar(),
        body: Stack(
          children: [ 
            Container(//navbar aas dooshoo zalgasan tsenher backround
                   height: GeneralMeasurements.deviceHeight/100*25,
                   decoration: BoxDecoration(
                     color: CommonColors.geregeBlue,
                     borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), 
                     bottomRight: Radius.circular(40))
                   ),
            ),
            Center(
             child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: GeneralMeasurements.deviceHeight/100*12,
                  child: Row(//navbar deer bgaa row
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                         Icons.arrow_back,
                        color: Colors.white,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: (){
                            GlobalHelpers.bottomnavbarSwitcher.add(false);
                            Get.find<AuthController>().loginName.clear();
                            Get.find<AuthController>().loginPass.clear();
                            Get.offAllNamed(RouteUnits.login);
                            }, 
                          child: const Text('change account', style: TextStyle(color: Colors.white),)),
                          InkWell( // menu btn
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    sidePageKey.currentState?.openEndDrawer();
                  },
                  child: Icon(
                            Icons.menu,
                            size: GeneralMeasurements.deviceWidth / 17,
                            color: Colors.white,
                          ),
                ),
                const SizedBox(width: 20,)
                        ],
                      )
                    ],
                  ),
                ),
                GetBuilder<AuthController>(
                  builder: (loginController){
                    return  Container(//Profile picture container............................................................!
                   width: GeneralMeasurements.deviceWidth/7*6,
                   height: GeneralMeasurements.deviceHeight/100*24,
                   decoration: BoxDecoration(
                     borderRadius: const BorderRadius.all(Radius.circular(15)),
                     color: Colors.white,
                     boxShadow: [
                       BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 0.1, blurRadius: 10, offset: const Offset(0, 7))
                     ]
                   ),
                   child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            InkWell(
                              onTap: (){
                                GlobalHelpers.imageFileSwitcher = true;
                                // imageController.cameraAndGallery();
                              },
                              child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 60,
                            backgroundImage: const AssetImage('assets/images/user_default.png'),  
                            child: Image.memory(Uint8List.fromList(loginController.user.result!.picture!)) ,
                         ),
                            ),
                            const SizedBox(width: 1, height: 1,),



                            // GlobalHelpers.imageFileSwitcher? ClipRRect(
                            // child: AspectRatio(aspectRatio: 1 / 1, child: Image.file(imageController.imageFile.value, fit: BoxFit.fill,)),
                            // borderRadius: BorderRadius.circular(90.0),
                            // ) : Container(width: 5, height: 5, color: Colors.blue, child: Text(imageController.imageFile.value.toString()),)



                            // Text(loginController.geregeUser.result!.firstName?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                            // Text(loginController.geregeUser.result!.phoneNo?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                         ],
                                        ),
                 );
                    }),
                const SizedBox(width: 1, height: 10,),
          GetX<ProfileController>(builder: (profileController){
            return SizedBox(
                height: GeneralMeasurements.deviceHeight/100*55 ,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                          itemCount: profileController.ownSurveyListbody.value.result!.items!.length,
                          itemBuilder: (context, index){
                            var item = profileController.ownSurveyListbody.value.result!.items![index];
                            return SurveyListItem(surveyName: item.name?? "", surveyId: item.id!, itemindx: index,);
                          } 
                          ),
                ),
              );
          })
              ],
            ),
           ),
           GetX<SurveyController>(
             builder: (surveyControllermini){
               return Visibility(
             visible: surveyControllermini.surveyDeleteIcon.value,
             child: InkWell(
               onTap: (){
                 surveyControllermini.surveyDeleteIcon.value = false;
                 surveyController.surveyListbody.value.result!.items![surveyControllermini.chosenSurveyIndx].borderColor.value = Colors.white;
               },
               child: Container(
                 color: Colors.grey.withOpacity(0.1),
                 child: Container(
                   margin: const EdgeInsets.only(bottom: 80),
                   child: Align(
                     alignment: Alignment.bottomCenter,
                     child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    surveyControllermini.deleteSurvey();
                    surveyControllermini.surveyDeleteIcon.value = false;
                    surveyController.surveyListGet(RouteUnits.profile, '120006', loginController.user.result!.userId!, '');
                  },
                  child: const Icon(
                            Icons.delete,
                            size: 50,
                            color: Colors.red,
                          ),
                ),
                   ),
                 ),
               ),
             ),
           );
             }
             )
          ],
        )
      ),
    );
  }
}




class ProfileSidebar extends StatefulWidget {
  const ProfileSidebar({ Key? key }) : super(key: key);

  @override
  State<ProfileSidebar> createState() => _ProfileSidebarState();
}

class _ProfileSidebarState extends State<ProfileSidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 5),
      child: Column(
        children: [
          profileBigButtons(bigButtons[0]),
          profileBigButtons(bigButtons[1]),
          profileBigButtons(bigButtons[2]),
          profileBigButtons(bigButtons[3]),
        ],
      ),
    );
  }
}







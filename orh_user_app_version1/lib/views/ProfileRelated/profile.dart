import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/login_controller.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';

import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';

import '../../Controllers/image_controller.dart';

class ButtonStructure {  
  const ButtonStructure({required this.title, required this.icon, required this.route});  
  final String title;  
  final IconData icon;
  final String route; 
}  
  
List<ButtonStructure> bigButtons = <ButtonStructure>[  
  ButtonStructure(title: 'Mэдээлэл', icon: Icons.person, route: RouteUnits.profileInfo),  
  ButtonStructure(title: 'Онош Түүх', icon: Icons.history, route: RouteUnits.profileDiagnosisHistory),  
  ButtonStructure(title: 'Life Token', icon: Icons.token, route: RouteUnits.profileLifeToken),  
  ButtonStructure(title: 'Device Log', icon: Icons.book, route: RouteUnits.profileDeviceLog)  
]; 

Widget profileBigButtons(ButtonStructure structureInfo){
  return InkWell(
    onTap: (){Get.toNamed(structureInfo.route);},
    child: Container(
    width: GeneralMeasurements.deviceWidth/10*4,
    height: GeneralMeasurements.deviceHeight/24*4,
    decoration: BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(15)),
                   color: Colors.white,
                   boxShadow: [
                     BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 0.1,
                      blurRadius: 10, offset: const Offset(0, 7))
                   ]
    ),
    child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,  
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: CommonColors.geregeBlue.withOpacity(0.1),
                  child: Icon(structureInfo.icon, size:50.0, color: CommonColors.geregeBlue),
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
  PageController pageController = PageController(viewportFraction: 0.85);
  var argu = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(argu == RouteUnits.home){
          GlobalHelpers.bottomnavbarSwitcher.add(false);
        }
        else{
          print('buruu yavlaa');
        }
        
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
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
                  child: Row(
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
                            Get.find<LoginController>().username.clear();
                            Get.find<LoginController>().pass.clear();
                            Get.offAllNamed(RouteUnits.login);
                            }, 
                          child: const Text('change account', style: TextStyle(color: Colors.white),))
                        ],
                      )
                    ],
                  ),
                ),
                GetBuilder<LoginController>(
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
                            GetX<ImageController>(builder: (imageController){
                            return   CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 60,
                            backgroundImage: const AssetImage('assets/images/user_default.png'),  
                            child: GlobalHelpers.imageFileSwitcher? ClipRRect(
                            child: AspectRatio(aspectRatio: 1 / 1, child: Image.file(imageController.imageFile.value, fit: BoxFit.fill,)),
                            borderRadius: BorderRadius.circular(90.0),
                            ) : Container(width: 5, height: 5, color: Colors.blue, child: Text(imageController.imageFile.value.toString()),),
                         ).pressExtention((){
                           GlobalHelpers.imageFileSwitcher = true;
                           imageController.cameraAndGallery();
                         });
                            }),
                            const SizedBox(width: 1, height: 1,),
                            Text(loginController.geregeUser.result!.firstName?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                            Text(loginController.geregeUser.result!.phoneNo?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                         ],
                                        ),
                 );
                    }),
                 const SizedBox(width: 1, height: 40,),
                 SizedBox(
                   width: GeneralMeasurements.deviceWidth/7*6,
                   height: GeneralMeasurements.deviceHeight/24*10,
                   child:  GridView.count(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 0.0,  
                  mainAxisSpacing: 0.0,   
                  children: List.generate(bigButtons.length, (index) {  
                    return Center(  
                      child: profileBigButtons(bigButtons[index]),  
                    );  
                  }  
                  )  
                  ),
                 ),
              ],
            ),
           )
          ],
        )
      ),
    );
  }
}







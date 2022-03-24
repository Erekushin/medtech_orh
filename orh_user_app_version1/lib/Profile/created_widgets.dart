import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/global_constant.dart';


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
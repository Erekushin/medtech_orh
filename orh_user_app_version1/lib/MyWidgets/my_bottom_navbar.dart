import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../Controllers/image_controller.dart';
import '../Controllers/login_controller.dart';
class MyBottomNavbar extends StatefulWidget {
  const MyBottomNavbar({ Key? key }) : super(key: key);

  @override
  State<MyBottomNavbar> createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {
   final List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];
  int _currentIndex = 4;
  int get currentIndex => _currentIndex;
  routing(int index){
    switch(index){
      case 0 :
        print('index0');
        GlobalHelpers.bottomnavbarSwitcher.add(false);
        Get.offAllNamed(RouteUnits.home);
        Get.put(LoginController());
       
        break;
      case 1 :
        Get.toNamed('/');
        break;
      case 2 :
        Get.toNamed('/');
        break;
      case 3 :
        Get.offNamedUntil(RouteUnits.profile, ModalRoute.withName(RouteUnits.home));
        break;
    }
    _currentIndex = index; 
  }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        child: Container(
        margin: const EdgeInsets.all(20),
        height: GeneralMeasurements.deviceHeight/100*7,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: GeneralMeasurements.deviceWidth * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              print('something');
              setState((){
                routing(index);
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == _currentIndex ? 0 : GeneralMeasurements.deviceWidth * .029,
                    right: GeneralMeasurements.deviceWidth * .0422,
                    left: GeneralMeasurements.deviceWidth * .0422,
                  ),
                  width: GeneralMeasurements.deviceWidth * .128,
                  height: index ==  _currentIndex ? GeneralMeasurements.deviceWidth * .014 : 0,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listOfIcons[index],
                  size: GeneralMeasurements.deviceWidth * .076,
                  color: index == _currentIndex
                      ?  CommonColors.geregeBlue
                      : Colors.black38,
                ),
                SizedBox(height: GeneralMeasurements.deviceWidth * .03),
              ],
            ),
            
          ),
        ),
      ),
      );
  }
}




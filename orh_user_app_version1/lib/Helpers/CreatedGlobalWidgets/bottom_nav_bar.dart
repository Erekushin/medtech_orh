import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Profile/profile.dart';
import 'package:orh_user_app_version1/VideoCall/login_test.dart';
import 'package:orh_user_app_version1/global_constant.dart';

import '../../Home/home.dart';
import '../../Login/login.dart';

class MyBottomNavBarController extends GetxController{
  int _currentIndex = 4;
  // Route<Profile> profile = const Profile() as Route<Profile>;
  int get currentIndex => _currentIndex;
  routing(int index){
    switch(index){
      case 0 :
        Get.offAllNamed(RouteUnits.home);
        break;
      case 1 :
        Get.toNamed('/');
        break;
      case 2 :
        Get.toNamed('/');
        break;
      case 3 :
        Get.offNamedUntil(RouteUnits.profile, ModalRoute.withName(RouteUnits.home));
        
        // Get.offUntil(profile, (route) => (route as GetPageRoute).routeName == '/home');
        break;
    }
    _currentIndex = index; 
  }
}

class MyBottomNavbar extends StatelessWidget {
  MyBottomNavbar({ Key? key }) : super(key: key);

  final List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: GetBuilder<MyBottomNavBarController>(builder: (bottomNavBar){
       return Container(
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
              Get.find<MyBottomNavBarController>().routing(index);
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
                    bottom: index == bottomNavBar.currentIndex ? 0 : GeneralMeasurements.deviceWidth * .029,
                    right: GeneralMeasurements.deviceWidth * .0422,
                    left: GeneralMeasurements.deviceWidth * .0422,
                  ),
                  width: GeneralMeasurements.deviceWidth * .128,
                  height: index == bottomNavBar.currentIndex ? GeneralMeasurements.deviceWidth * .014 : 0,
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
                  color: index == bottomNavBar.currentIndex
                      ?  CommonColors.geregeBlue
                      : Colors.black38,
                ),
                SizedBox(height: GeneralMeasurements.deviceWidth * .03),
              ],
            ),
            
          ),
        ),
      );
      }),
      );
  }
}


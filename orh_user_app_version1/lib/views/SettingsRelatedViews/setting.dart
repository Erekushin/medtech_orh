import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';

import '../../MyWidgets/my_switcher.dart';
import '../../global_helpers.dart';

class Setting extends StatelessWidget {
  Setting({ Key? key }) : super(key: key);
  final argu = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        log(argu);
        if(argu == RouteUnits.fromHome){
          GlobalHelpers.bottomnavbarSwitcher.add(false);
        }
        return true;
      },
      child: GetBuilder<SettingController>(builder: (settingController){
        return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
              'Setting',
              style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black.withOpacity(.4),
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText('Иргэний мэдээллийн сан', 15, 1, FontWeight.bold),
                   MySwitcher(keyDirection: 'xyrServiceSwitcher', switcherValue: settingController.xyrServiceSwitcher.value,),
                ],
              ),
            )
          ],
        )
      );
      }),
    );
  }
}
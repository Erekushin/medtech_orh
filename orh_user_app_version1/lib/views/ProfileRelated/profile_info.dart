import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/global_constant.dart';
class ProfileInfo extends StatefulWidget {
  const ProfileInfo({ Key? key }) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 30, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Нэр: Энхмандах', style: TextStyle(fontSize: 15),),
            Text('Нас: 22', style: TextStyle(fontSize: 15)),
            TextButton(onPressed: (){
              Get.toNamed(RouteUnits.calculators);
            }, child: const Text('Мэдээлэл нэмэх'))
          ],
        ),
      ),
    );
  }
}
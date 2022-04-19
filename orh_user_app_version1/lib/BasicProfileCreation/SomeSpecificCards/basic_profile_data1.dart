import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import 'package:orh_user_app_version1/global_helpers.dart';

import '../../Controllers/image_controller.dart';

class BasicProfileData1 extends StatelessWidget {
  const BasicProfileData1({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalHelpers.imageFileSwitcher = false;
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20,),
                GetX<ImageController>(builder: (imageController){
                  return CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 40,
                  backgroundImage: const AssetImage('assets/images/user_default.png'),
                  child:  GlobalHelpers.imageFileSwitcher? ClipRRect(
                               child: AspectRatio(aspectRatio: 1 / 1, child: Image.file(imageController.imageFile.value, fit: BoxFit.fill,)),
                               borderRadius: BorderRadius.circular(90.0)
                               ): Container(color: Colors.blue, width: 1, height: 1, child: Text(imageController.imageFile.value.toString()),)
                  ).pressExtention((){
                    GlobalHelpers.imageFileSwitcher = true;
                    imageController.cameraAndGallery();
                  });
                })
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Өндөр',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Жин',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Нүдний хараа',
                ),
              ),
            ),

            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){}, child: Text('skip'))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  color: Color(0xFFFF4484)
              ),
              width: 200,
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
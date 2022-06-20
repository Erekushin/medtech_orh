import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';

import '../MyWidgets/my_button.dart';
import '../global_constant.dart';

class ImageController extends GetxController{

 var randomImageList = [].obs;
 var imageFile = File('').obs;
 var imageBytes = Pics.profilePic.obs;
 final _picker = ImagePicker();
 Future<void> pickImageFromGallery(String route, BuildContext context ) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 5);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageBytes.value = await imageFile.value.readAsBytes();

      if(route == RouteUnits.profile){
        showDialog(
                  context: context,
                  builder: (context)=> AlertDialog(
                          backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
		                  borderRadius: BorderRadius.circular(30),
	                  ),
                    content: SizedBox(
                    height: GeneralMeasurements.deviceHeight*.46,
                    child: Column(
                    children: [
                      myText('Нүүр зургаа солихуу?', 20, 1),
                     Image.asset('assets/images/thinkingBoy.png'),
                     const SizedBox(height: 50,),
                     Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context, true);
                            Get.find<AuthController>().updateProPic();
                          },
                          child: myBtn(CommonColors.geregeBlue, 100, 30, CommonColors.geregeBlue, Colors.white, 'update pro',)),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context, true);
                          },
                          child: myBtn(CommonColors.geregeBlue, 100, 30, CommonColors.geregeBlue, Colors.white, 'quit',))
                      ],
                     )
                  
                      ],
                  ),
                  ),
                  
                  )
                );
      }

    }
  }
  Future<void> pickImageFromCamera(String route, BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 5);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageBytes.value = await imageFile.value.readAsBytes();
      if(route == RouteUnits.profile){
            showDialog(
                  context: context,
                  builder: (context)=> AlertDialog(
                          backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
		                  borderRadius: BorderRadius.circular(30),
	                  ),
                    content: SizedBox(
                    height: GeneralMeasurements.deviceHeight*.46,
                    child: Column(
                    children: [
                      myText('Нүүр зургаа солихуу?', 20, 1),
                     Image.asset('assets/images/thinkingBoy.png'),
                     const SizedBox(height: 50,),
                     Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context, true);
                            Get.find<AuthController>().updateProPic();
                          },
                          child: myBtn(CommonColors.geregeBlue, 100, 30, CommonColors.geregeBlue, Colors.white, 'update pro',)),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context, true);
                          },
                          child: myBtn(CommonColors.geregeBlue, 100, 30, CommonColors.geregeBlue, Colors.white, 'quit',))
                      ],
                     )
                  
                      ],
                  ),
                  ),
                  
                  )
                );
      }
    }
  }
  Future<void> cameraAndGallery(String route, BuildContext context) async{
    return await Get.defaultDialog(title: 'Нүүр зураг солих', content: const SizedBox(height: 1,),
                         actions: <Widget>[ IconButton(
                                           icon: const Icon(Icons.photo_camera, color: Color(0xFFFF4484), size: 40,),
                                           onPressed: () async => pickImageFromCamera(route, context),
                                           tooltip: 'Shoot picture',
                                           ),
                                           IconButton(
                                           icon: const Icon(Icons.photo ,color: Color(0xFFFEC07B), size: 40,),
                                           onPressed: () async => pickImageFromGallery(route, context),
                                           tooltip: 'Pick from gallery',
                                          ),]);
  }
}
  
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class ImageController extends GetxController{
 var randomImageList = [].obs;
 var imageFile = File('').obs;
 var imageBytes;
 final _picker = ImagePicker();
 Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageBytes = await imageFile.value.readAsBytes();
    }
  }
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageBytes = await imageFile.value.readAsBytes();
    }
  }
  Future<void> cameraAndGallery() async{
    return await Get.defaultDialog(title: 'Нүүр зураг солих', content: const SizedBox(height: 1,),
                         actions: <Widget>[ IconButton(
                                           icon: const Icon(Icons.photo_camera, color: Color(0xFFFF4484), size: 40,),
                                           onPressed: () async => pickImageFromCamera(),
                                           tooltip: 'Shoot picture',
                                           ),
                                           IconButton(
                                           icon: const Icon(Icons.photo ,color: Color(0xFFFEC07B), size: 40,),
                                           onPressed: () async => pickImageFromGallery(),
                                           tooltip: 'Pick from gallery',
                                          ),]);
  }
}
  
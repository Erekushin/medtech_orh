import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../Controllers/image_controller.dart';
import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';
import 'created_widgets.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    Get.find<MyBottomNavBarController>();
    return Scaffold(
      
      bottomNavigationBar: MyBottomNavbar(),
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
                        TextButton(onPressed: (){Get.offAllNamed(RouteUnits.login);}, 
                        child: Text('change account', style: TextStyle(color: Colors.white),))
                      ],
                    )
                  ],
                ),
              ),
               Container(//Profile picture container............................................................!
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
                             child: ClipRRect(
                               child: AspectRatio(aspectRatio: 1 / 1, child: Image.file(imageController.imageFile.value, fit: BoxFit.fill,)),
                               borderRadius: BorderRadius.circular(90.0),
                               ),  
                       ).pressExtention((){
                         imageController.cameraAndGallery();
                       });
                          }),
                          const SizedBox(width: 1, height: 1,),
                          const Text('Mandah', style: TextStyle(fontWeight: FontWeight.bold),),
                          const Text('95258154', style: TextStyle(fontWeight: FontWeight.bold),),
                       ],
                                      ),
               ),
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
    );
  }
}







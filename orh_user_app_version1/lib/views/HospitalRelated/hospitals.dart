import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import 'package:orh_user_app_version1/views/HospitalRelated/side_search_address.dart';
import 'package:orh_user_app_version1/views/HospitalRelated/side_search_name.dart';
import '../../global_constant.dart';
import 'created_widgets.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);
  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
 


  bool sideBarToggler = false;
  GlobalKey<ScaffoldState> sidePageKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 120;
  bool isTapped = true;
  bool isExpanded = false;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }
  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(false);
        return true;
      },
      child: Scaffold(
          key: sidePageKey,
          endDrawer : sideBarToggler? const SidePageForName() : const SidePageForAddress(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            shadowColor: Colors.black.withOpacity(.5),
            title: Text(
              'Эмнэлэгүүд',
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
          body:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            child: const Text(
                              'Таний бүртгэлтэй  эмнэлэгүүд:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 220,
                            child: PageView.builder(
                                controller: pageController,
                                itemCount: 4,
                                itemBuilder: (context, position){
                                  return _buildPageItem(position);
                                }
                            ),
                          ),
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          searchBtn('Хаягаар\nхайх', const Color(0xFFFEC07B)).pressExtention((){
                            setState(() {
                              sideBarToggler = true;
                            });
                            sidePageKey.currentState?.openEndDrawer();
                          }),
                          searchBtn('Нэрээр \n хайх', const Color(0xFFFF4484)).pressExtention((){
                            setState(() {
                              sideBarToggler = false;
                            });
                            sidePageKey.currentState?.openEndDrawer();
                          }),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
  Widget _buildPageItem(int index){
    String? imagePath;
    if(index == 0){
      imagePath = "assets/images/hospital1.jpg";
    }
    else if(index == 1){
      imagePath = "assets/images/hospital2.jpg";
    }
    else if(index == 2){
      imagePath = "assets/images/hospital3.jpg";
    }
    else if(index == 3){
      imagePath = "assets/images/hospital4.jpg";
    }
    Matrix4 matrix = Matrix4.identity();
    if(index == _currentPageValue.floor()){
      var currScale = 1 - (_currentPageValue - index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currentPageValue.floor() + 1){
      var currScale = _scaleFactor + (_currentPageValue - index + 1 )*(1 - _scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currentPageValue.floor() - 1){
      var currScale = 1 - (_currentPageValue - index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imagePath!), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(30),
            color: index.isEven? const Color(0xFFC9DAED): const Color(0xFFE6CF9B)
        ),
      ).pressExtention((){
        final description = Get.arguments as String;
        switch(description){
          case "fromHospitals":
            Get.toNamed(RouteUnits.hospitals + RouteUnits.hospitalProfile, arguments: '');
            break;
          case "fromTimeOrder":
            Get.toNamed(RouteUnits.timeOrder + RouteUnits.hospitals + RouteUnits.doctors, arguments: 'fromTimeOrder');
        }
      }),
    );
  }
}






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';
import '../Helpers/CreatedGlobalWidgets/scroll_behavior.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  _HospitalsState createState() => _HospitalsState();
}
class _HospitalsState extends State<Hospitals> {
  bool SideBarToggler = false;
  GlobalKey<ScaffoldState> SidePageKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 120;
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
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: MyBottomNavBar(),
        key: SidePageKey,
        endDrawer : SideBarToggler? SidePageForName() : SidePageForAddress(),
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
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            'Таний бүртгэлтэй  эмнэлэгүүд:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
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
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 180,
                            width: _w/2 - 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFFEC07B),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFFEC07B).withOpacity(0.6), spreadRadius: 0.1, blurRadius: 10, offset: Offset(0, 7))
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Center(
                              child: Text(
                                'Хаягаар\nхайх'
                                ,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            )
                        ).PressExtention((){
                          print('press on haygaar haih');
                          setState(() {
                            SideBarToggler = true;
                          });
                          SidePageKey.currentState?.openEndDrawer();
                        }),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 180,
                            width: _w/2 - 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFFF4484),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFF4484).withOpacity(0.6), spreadRadius: 0.1, blurRadius: 10, offset: Offset(0, 7))
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Center(
                              child: Text('Нэрээр \n хайх',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),),
                            )
                        ).PressExtention((){
                          print('press on nereer haih');
                          setState(() {
                            SideBarToggler = false;
                          });

                          SidePageKey.currentState?.openEndDrawer();
                        }),
                      ],
                    ),
                    SizedBox(height: 80,),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  Widget _buildPageItem(int index){
    String? ImagePath;
    if(index == 0){
      ImagePath = "assets/images/hospital1.jpg";
    }
    else if(index == 1){
      ImagePath = "assets/images/hospital2.jpg";
    }
    else if(index == 2){
      ImagePath = "assets/images/hospital3.jpg";
    }
    else if(index == 3){
      ImagePath = "assets/images/hospital4.jpg";
    }
    Matrix4 matrix = new Matrix4.identity();
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
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(ImagePath!), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(30),
            color: index.isEven? Color(0xFFC9DAED): Color(0xFFE6CF9B)
        ),
      ).PressExtention((){
        final Discription = Get.arguments as String;
        switch(Discription){
          case "hospitals":
            Get.toNamed('/Doctors');
        }
      }),
    );
  }
}



class SidePageForName extends StatefulWidget {
  SidePageForName({Key? key}) : super(key: key);
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  _SidePageForName createState() => _SidePageForName();
}

class _SidePageForName extends State<SidePageForName> {
  String? selectvalCity;
  String? selectvalDistrict;
  String? selectvalCommity;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFEAE9ED),
      child: Container(
        margin: EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: DropdownButton<String>(
                  hint: Text("Аймаг сонгох (Хот)"),
                  value: selectvalCity,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectvalCity = newValue.toString();
                    });
                  },
                  underline: SizedBox(),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: <String>[
                    'Дархан','Өмнө-Говь','Ховд'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: DropdownButton<String>(
                  hint: Text("Сум сонгох (Дүүрэг)"),
                  value: selectvalDistrict,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectvalDistrict = newValue.toString();
                    });
                  },
                  underline: SizedBox(),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: <String>[
                    'Баянзүрх','Хан-уул','Сонгино хайрхан'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: DropdownButton<String>(
                  hint: Text("Хороо сонгох"),
                  value: selectvalCommity,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectvalCommity = newValue.toString();
                    });
                  },
                  underline: SizedBox(),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: <String>[
                    '8-р хороо','24-р хороо','5-р хороо'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),

              Container(
                height: 400,
                child: new ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index){
                      return EachHospital();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EachHospital extends StatelessWidget {
  const EachHospital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: Text('эмнэлэг',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),),
      ),
    );
  }
}




class SidePageForAddress extends StatefulWidget {
  SidePageForAddress({Key? key}) : super(key: key);
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  _SidePageForAddress createState() => _SidePageForAddress();
}

class _SidePageForAddress extends State<SidePageForAddress> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFEAE9ED),
      child: Container(
        margin: EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.white),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Эмнэлэгийн нэр',
                    labelText: 'Эмнэлэгийн нэр',
                  ),
                ),
              ),

              Container(
                height: 400,
                child: new ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index){
                      return EachHospital();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}


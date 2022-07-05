import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/sql_controller.dart';
import 'dart:ui';
import '../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../Controllers/SurveyRelated/survey_controller.dart';
import '../../Controllers/auth_controller.dart';
import '../../MyWidgets/home_page_card.dart';
import '../../MyWidgets/my_button.dart';
import '../../MyWidgets/survey_related/survey_unit/public.dart';
import '../../MyWidgets/survey_related/survey_unit/seg.dart';
import '../../global_constant.dart';
import '../../global_helpers.dart';
import 'dart:math';


class HomeInfoFlow extends StatefulWidget {
  const HomeInfoFlow({Key? key}) : super(key: key);
  @override
  _HomeInfoFlowState createState() => _HomeInfoFlowState();
}
class _HomeInfoFlowState extends State<HomeInfoFlow> with SingleTickerProviderStateMixin{
  var searchController = TextEditingController();
  final argu = Get.arguments;
  
  var loginController = Get.find<AuthController>();
  GlobalKey<ScaffoldState> sidePageKey = GlobalKey<ScaffoldState>();
  var sqlController = Get.find<SqlController>();
  var surveyController = Get.find<SCont>();
  Future<bool>cloaseTheApp(BuildContext context) async {
    return await Get.defaultDialog(title: 'Эрүүл Gerege ийг хаах уу?', content: Image.asset('assets/images/thinkingBoy.png'),
    actions: <Widget>[TextButton(onPressed: (){SystemNavigator.pop();}, child: const Text("exit", style: TextStyle(fontSize: 20),)), 
    ]);
  }
  var homePageCont = PageController();
   int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  List<String> pageNames = ['public','work space'];
  routing(int index){
    switch(index){
      case 0 :
      homePageCont.jumpToPage(0);
        break;
      case 1 :
      homePageCont.jumpToPage(1);
        break;
    }
    _currentIndex = index; 
  }
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;  
  }
  String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      key: sidePageKey,
      endDrawer : const HomeSidebar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: [
               Padding(//title section
                padding: EdgeInsets.fromLTRB(GeneralMeasurements.deviceHeight/100*2, GeneralMeasurements.deviceHeight/100*2, 0, GeneralMeasurements.deviceHeight/100*1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Эрүүл Gerege',
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: GeneralMeasurements.deviceWidth / 35),
                    Text(
                      'Таны эрүүл мэндийн дижитал туслах.',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              Row(//search container row
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 0),
                    padding: const EdgeInsets.all(10),
                    width: GeneralMeasurements.deviceWidth/10*6,
                    height: GeneralMeasurements.deviceHeight/100*5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:  const BorderRadius.all(Radius.circular(15))
                    ),
                  child: TextField(
                        onChanged: (value){
                           if(homePageCont.page == 0){
                             surveyController.listGet(RouteUnits.home, '120002', loginController.user.result!.userId!, value, loginController.user.result!.phone!);
                           } 
                           else if(homePageCont.page == 1){
                             surveyController.listGet('/segmented', '120009', loginController.user.result!.userId!, value, loginController.user.result!.phone!);
                           }
                       },
                        controller: searchController,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          border: InputBorder.none,
                        contentPadding: EdgeInsets.all(4),
                        labelText: 'search',  
                        hintText: 'search',
                        ),
                      ),
                  ),
                  IconButton(onPressed: (){
                      if(homePageCont.page == 0){
                             surveyController.listGet(RouteUnits.home, '120002', loginController.user.result!.userId!, searchController.text, loginController.user.result!.phone!);
                           } 
                           else if(homePageCont.page == 1){
                             surveyController.listGet('/segmented', '120009', loginController.user.result!.userId!, searchController.text, loginController.user.result!.phone!);
                           }
                  }, 
                  icon: const Icon(Icons.search, color: Colors.grey,))
                ],
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row( // vvsgeh button uudiin row
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(//survey
                      onTap: () async{
                         var surveyCreationController = Get.find<CreationCont>();
                         surveyCreationController.randomString = generateRandomString(5) + DateTime.now().toString();
                         await surveyCreationController.getSurveyCreationTypes();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CommonColors.geregeBlue,
                          borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                                margin: const EdgeInsets.only(bottom: 5, left: 10),
                                child: Row(children: [
                                  Container(
                      height: GeneralMeasurements.deviceWidth / 10,
                      width: GeneralMeasurements.deviceWidth / 10,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.article,
                        color: Colors.red.withOpacity(.6),
                      ),
                                    ),
                                  myBtn(CommonColors.geregeBlue, 80, 30, CommonColors.geregeBlue, Colors.white, 'Судалгаа')
                                ],)
                              ),
                    ),
                    InkWell(//post
                      onTap: () async{
                        
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CommonColors.geregeBlue,
                          borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                                margin: const EdgeInsets.only(bottom: 5, left: 10),
                                child: Row(children: [
                                  Container(
                      height: GeneralMeasurements.deviceWidth/100*10,
                      width: GeneralMeasurements.deviceWidth/100*10,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.ac_unit_sharp,
                        color: Colors.blue.withOpacity(.6),
                      ),
                                    ),
                                  myBtn(CommonColors.geregeBlue, 50, 30, CommonColors.geregeBlue, Colors.white, 'post')
                                ],)
                              ),
                    ),
                     InkWell(//
                      onTap: () async{
                         var surveyCreationController = Get.find<CreationCont>();
                         await surveyCreationController.getSurveyCreationTypes();
                         Get.toNamed(RouteUnits.surveyCreation);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CommonColors.geregeBlue,
                          borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                                margin: const EdgeInsets.only(bottom: 5, left: 10),
                                child: Row(children: [
                                  Container(
                      height: GeneralMeasurements.deviceWidth / 10,
                      width: GeneralMeasurements.deviceWidth / 10,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(15/360),
                        child: Icon(
                          Icons.question_mark_rounded,
                          color: Colors.pinkAccent.withOpacity(.6),
                        ),
                      ),
                                    ),
                                  myBtn(CommonColors.geregeBlue, 80, 30, CommonColors.geregeBlue, Colors.white, 'Асуулга')
                                ],)
                              ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                width: GeneralMeasurements.deviceWidth/100*65,
                height: GeneralMeasurements.deviceHeight/100*3,
                child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            print('something');
                            setState((){
                              routing(index);
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child:  AnimatedContainer(
                              margin: EdgeInsets.all(1),
                              child: Center(child: Text(
                              pageNames[index],
                              style: TextStyle(
                                 color: index == _currentIndex ?Colors.white : CommonColors.geregeBlue,
                              ),
                            )),
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: GeneralMeasurements.deviceWidth/100*30,
                          height: 50,
                          decoration: BoxDecoration(
                          color: index == _currentIndex ? CommonColors.geregeBlue : Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                       ),
                     )
                        ),
                      ),
              )
                ],
              ),
              SizedBox(
                width: GeneralMeasurements.deviceWidth,
                height: GeneralMeasurements.deviceHeight/100*70 ,
                child: PageView(
                  onPageChanged: (index){
                    switch(index){
                      case 0 :
                      setState(() {
                         _currentIndex = 0; 
                      });
                      break;
                      case 1 :
                      setState(() {
                         _currentIndex = 1; 
                      });
                      break;
                    }
                  },
                controller: homePageCont,  
                children: const [
                  HomePagePublic(),
                  HomePageWorkSpace()
                 ],
                ),
              )
            ],
          ),
          Padding(// upper navigation btn
            padding: EdgeInsets.fromLTRB(0, GeneralMeasurements.deviceWidth / 9.5, GeneralMeasurements.deviceWidth / 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // InkWell(
                //   highlightColor: Colors.transparent,
                //   splashColor: Colors.transparent,
                //   onTap: () {
                //     Get.toNamed(RouteUnits.setting, arguments: RouteUnits.fromHome);
                //     GlobalHelpers.bottomnavbarSwitcher.add(true);

                //   },
                //   child: ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(99)),
                //     child: BackdropFilter(
                //       filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                //       child: Container(
                //         height: GeneralMeasurements.deviceWidth / 8.5,
                //         width: GeneralMeasurements.deviceWidth / 8.5,
                //         decoration: BoxDecoration(
                //           color: Colors.black.withOpacity(.05),
                //           shape: BoxShape.circle,
                //         ),
                //         child: Center(
                //           child: Icon(
                //             Icons.settings,
                //             size: GeneralMeasurements.deviceWidth / 17,
                //             color: Colors.black.withOpacity(.6),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 10),
                InkWell( // menu btn
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    sidePageKey.currentState?.openEndDrawer();
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(99)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        height: GeneralMeasurements.deviceWidth / 8.5,
                        width: GeneralMeasurements.deviceWidth / 8.5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.menu,
                            size: GeneralMeasurements.deviceWidth / 17,
                            color: Colors.black.withOpacity(.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ), 
      onWillPop: (){
        return cloaseTheApp(context);
      });
  }
}

class HomeSidebar extends StatefulWidget {
  const HomeSidebar({ Key? key }) : super(key: key);

  @override
  State<HomeSidebar> createState() => _HomeSidebarState();
}
class _HomeSidebarState extends State<HomeSidebar> {
  var sqlController = Get.find<SqlController>();
  var surveyController = Get.find<SCont>();
  var loginController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: GeneralMeasurements.deviceWidth/100*60,
      child: ListView(
        children: [
          homePageCard(
                const Color(0xFF12C0A1),
                Icons.person,
                'Профайл',
                ()async {
                  await surveyController.listGet(RouteUnits.profile, '120006', loginController.user.result!.userId!, '', loginController.user.result!.phone!);
                  Get.toNamed('/profile', arguments: RouteUnits.profile);
                   GlobalHelpers.bottomnavbarSwitcher.add(true);},
              ),
              homePageCard(
                  const Color(0xffffa700),
                  Icons.article,
                  'Эмнэлэгүүд',
                  (){
                    Get.toNamed(RouteUnits.hospitals, arguments: RouteUnits.fromHospitals);
                    GlobalHelpers.bottomnavbarSwitcher.add(true);},
                  ),
              homePageCard(
                const Color(0xfff37736),
                  Icons.article_sharp,
                  'Эмч нар',
                  (){
                    Get.toNamed(RouteUnits.doctors, arguments: RouteUnits.fromDoctors);
                    GlobalHelpers.bottomnavbarSwitcher.add(true);},
              ),
              homePageCard(
                  const Color(0xffffa700),
                  Icons.text_fields,
                  'Урьдчилан сэргийлэх үзлэг',
                 
                  (){
                    Get.toNamed(RouteUnits.preDiagnosis, arguments: RouteUnits.home);
                    GlobalHelpers.bottomnavbarSwitcher.add(true);},
                  ),
              homePageCard(
                   const Color(0xffFF6D6D),
                   Icons.analytics_outlined,
                   'Жорын бичиг',
                   () async{
                     await sqlController.readAllNotes();
                      Get.toNamed(RouteUnits.treatmentRecipe, arguments: "firstPage");
                     },
              )
        ],
      )
    );
  }
}

class HomePagePublic extends StatefulWidget {
  const HomePagePublic({ Key? key }) : super(key: key);

  @override
  State<HomePagePublic> createState() => _HomePagePublicState();
}
class _HomePagePublicState extends State<HomePagePublic> {
  var scrollController = ScrollController();
  var loginController = Get.find<AuthController>();
  var surveyController = Get.find<SCont>();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }
  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print('reach the bottom');
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {//reach the top
      surveyController.listGet(RouteUnits.home, '120002', loginController.user.result!.userId!, '', loginController.user.result!.phone!);
    }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<SCont>(builder: (surveyControllerList){
            return Stack(
              children: [
                SizedBox(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                          itemCount: surveyControllerList.publicSurveyList.value.result?.length?? 0,
                          itemBuilder: (context, index){
                            var item = surveyControllerList.publicSurveyList.value.result![index];
                            return PublicsUnit(surveyName: item.name?? "", surveyId: item.id!, 
                                                    itemindx: index, fromRoute: "home", surveyColor: item.color?? '0xFFFFFFFF',);
                          } 
                          ),
                ),
              ),
              Visibility(
                visible: surveyControllerList.publicSurveyList.value.result == null? true : false,
                child: Image.asset('assets/images/empty_box.jpg')
                )
              ],
            );
          })
    );
  }
}

class HomePageWorkSpace extends StatefulWidget {
  const HomePageWorkSpace({ Key? key }) : super(key: key);

  @override
  State<HomePageWorkSpace> createState() => _HomePageWorkSpaceState();
}
class _HomePageWorkSpaceState extends State<HomePageWorkSpace> {
   var scrollController = ScrollController();
  var loginController = Get.find<AuthController>();
  var surveyController = Get.find<SCont>();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }
  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print('reach the bottom');
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {//reach the top
      surveyController.listGet('/segmented', '120009', loginController.user.result!.userId!, '', loginController.user.result!.phone!);
    }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<SCont>(builder: (surveyControllerList){
            return Stack(
              children: [
                SizedBox(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                          itemCount: surveyControllerList.wrkSpaceSurveyList.value.result?.length?? 0,
                          itemBuilder: (context, index){
                            var item = surveyControllerList.wrkSpaceSurveyList.value.result![index];
                            return SegsUnit(surveyName: item.name?? "", surveyId: item.id!, 
                                                       itemindx: index, surveyColor: item.color?? '0xFFFFFFFF',);
                          } 
                          ),
                ),
              ),
                 Visibility(
                visible: surveyControllerList.wrkSpaceSurveyList.value.result == null? true : false,
                child: Image.asset('assets/images/empty_box.jpg')
                )
              ],
            );
          })
    );
  }
}

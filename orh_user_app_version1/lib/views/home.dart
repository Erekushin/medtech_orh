
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import 'dart:ui';
import '../Controllers/login_controller.dart';
import '../Controllers/query_controller.dart';
import '../MyWidgets/my_text.dart';
import '../global_constant.dart';
import '../global_helpers.dart';


 Widget homePageCardsGroup(
     
      Color color,
      IconData icon,
      String title,
      BuildContext context,
      Function func,
      Color color2,
      IconData icon2,
      String title2,
      Function func2,) {
    return Padding(
      padding: EdgeInsets.only(bottom: GeneralMeasurements.deviceWidth / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(color, icon, title, context, func),
          homePageCard(color2, icon2, title2, context, func2),
        ],
      ),
    );
  }
  Widget homePageCard(Color color, IconData icon, String title,
      BuildContext context, Function func) {
    double _w = MediaQuery.of(context).size.width;
    return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            func();
            GlobalHelpers.bottomnavbarSwitcher.add(true);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            height: _w / 2,
            width: _w / 2.4,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff040039).withOpacity(.15),
                  blurRadius: 99,
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                Container(
                  height: _w / 8,
                  width: _w / 8,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color.withOpacity(.6),
                  ),
                ),
                Text(
                  title,
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(),
              ],
            ),
          ),
        );
  }
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  Future<bool>cloaseTheApp(BuildContext context) async {
    return await Get.defaultDialog(title: 'Эрүүл Gerege ийг хаах уу?', content: Image.asset('assets/images/thinkingBoy.png'),
    actions: <Widget>[TextButton(onPressed: (){SystemNavigator.pop();}, child: const Text("exit", style: TextStyle(fontSize: 20),)), 
    ]);
  }
  
  @override
  void initState() {
    super.initState();
    final childHeartQueryController = Get.find<SurveyController>();
    childHeartQueryController.getAimagList();
  }
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Get.put(MyBottomNavBarController());
    return WillPopScope(
      child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            physics:
            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(GeneralMeasurements.deviceWidth / 17, GeneralMeasurements.deviceWidth / 20, 0, GeneralMeasurements.deviceWidth / 10),
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
              homePageCardsGroup(
                const Color(0xFF12C0A1),
                Icons.person,
                'Профайл',
                context,
                (){Get.toNamed(RouteUnits.profile, arguments: RouteUnits.home);},
                const Color(0xffFF6D6D),
                Icons.analytics_outlined,
                'Calculators',
                (){Get.toNamed(RouteUnits.calculators, arguments: "firstPage");}
              ),
              homePageCardsGroup(
                  Colors.lightGreen,
                  Icons.calendar_today_sharp,
                  'Цаг авах',
                  context,
                  (){Get.toNamed(RouteUnits.timeOrder + RouteUnits.hospitals, arguments: "fromTimeOrder");},
                  const Color(0xffffa700),
                  Icons.article,
                  'Эмнэлэгүүд',
                  (){Get.toNamed(RouteUnits.hospitals, arguments: RouteUnits.home);},),
              homePageCardsGroup(
                  const Color(0xff63ace5),
                  Icons.ad_units_outlined,
                  'Судалгаа',
                  context,
                  (){Get.toNamed(RouteUnits.queries, arguments: "");},
                  const Color(0xfff37736),
                  Icons.article_sharp,
                  'Эмч нар',
                  (){Get.toNamed(RouteUnits.doctors, arguments: "fromDoctors");},),
              homePageCardsGroup(
                  const Color(0xffFF6D6D),
                  Icons.android,
                  'Урьдчилан сэргийлэх үзлэг ',
                  context,
                  (){Get.toNamed(RouteUnits.preDiagnosis, arguments: RouteUnits.home);},
                  Colors.lightGreen,
                  Icons.text_format, 
                  'ionDemo',
                  (){Get.toNamed('/login', arguments: "fromHospitals");},),
              homePageCardsGroup(
                  const Color(0xffffa700),
                  Icons.text_fields,
                  'tsag avah',
                  context,
                  (){Get.toNamed('/tsagavah', arguments: "fromHospitals");},
                  const Color(0xff63ace5),
                  Icons.gamepad_outlined,
                    'local check',
                    (){
                      print('object');
                    },),
              SizedBox(height:  GeneralMeasurements.deviceWidth/ 20),
            ],
          ),
          Padding(// SETTING button
            padding: EdgeInsets.fromLTRB(0, GeneralMeasurements.deviceWidth / 9.5, GeneralMeasurements.deviceWidth / 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // GetBuilder<LoginController>(builder: (something){
                //   print('home dotor loading check');
                //   print(something.loginloading.toString());
                //   return
                //   something.loginloading? const SizedBox() : const CircularProgressIndicator();
                // }),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.toNamed(RouteUnits.setting);
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
                            Icons.settings,
                            size: GeneralMeasurements.deviceWidth / 17,
                            color: Colors.black.withOpacity(.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
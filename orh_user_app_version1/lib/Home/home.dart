import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';
import '../global_constant.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.put(MyBottomNavBarController());
    return Scaffold(
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
                      'Таний эрүүл мэндийн дэжитал туслах.',
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
                'profile',
                '/profile',
                const Color(0xFF12C0A1),
                Icons.person,
                'Профайл',
                context,
                'firstPage',
                RouteUnits.calculators,
                const Color(0xffFF6D6D),
                Icons.analytics_outlined,
                'Calculators',
              ),
              homePageCardsGroup(
                  'fromTimeOrder',
                  RouteUnits.timeOrder + RouteUnits.hospitals,
                  Colors.lightGreen,
                  Icons.calendar_today_sharp,
                  'Цаг авах',
                  context,
                  'fromHospitals',
                  RouteUnits.hospitals,
                  const Color(0xffffa700),
                  Icons.article,
                  'Эмнэлэгүүд',),
              homePageCardsGroup(
                  'fromlavlagaa1',
                  RouteUnits.lavlagaa1,
                  const Color(0xff63ace5),
                  Icons.ad_units_outlined,
                  'Лавлагаа 1',
                  context,
                  'fromDoctors',
                  RouteUnits.doctors,
                  const Color(0xfff37736),
                  Icons.article_sharp,
                  'Эмч нар',),
              homePageCardsGroup(
                  'fromHospitals',
                  '/camera',
                  const Color(0xffFF6D6D),
                  Icons.android,
                  'camera',
                  context,
                  'fromHospitals',
                  '/login',
                  Colors.lightGreen,
                  Icons.text_format,
                  'ionDemo',),
              homePageCardsGroup(
                  'fromHospitals',
                  RouteUnits.questions,
                  const Color(0xffffa700),
                  Icons.text_fields,
                  'Асуумжууд',
                  context,
                  'fromHospitals',
                  '/stun',
                  const Color(0xff63ace5),
                  Icons.gamepad_outlined,
                    'stun check',),
              SizedBox(height:  GeneralMeasurements.deviceWidth/ 20),
            ],
          ),
          Padding(// SETTING button
            padding: EdgeInsets.fromLTRB(0, GeneralMeasurements.deviceWidth / 9.5, GeneralMeasurements.deviceWidth / 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
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
    );
  }
  Widget homePageCardsGroup(
      String data,
      String route,
      Color color,
      IconData icon,
      String title,
      BuildContext context,
      String data2,
      String route2,
      Color color2,
      IconData icon2,
      String title2,) {
    double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: _w / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(data, route, color, icon, title, context),
          homePageCard(data2, route2, color2, icon2, title2, context),
        ],
      ),
    );
  }
  Widget homePageCard(String data, String route, Color color, IconData icon, String title,
      BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Get.toNamed(route, arguments: data);
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
}









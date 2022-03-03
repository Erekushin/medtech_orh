import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
// import '../Lavlagaa1/form.dart';
// import '../Results/firstPage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
    _animation2 = Tween<double>(begin: -5, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(_w / 17, _w / 20, 0, _w / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gerege Өрх MN',
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: _w / 35),
                    Text(
                      'Өрхийн эрүүл мэндийн үйлчилгээг цахимаар авах боломжтой боллоо.',
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
                Color(0xFF12C0A1),
                Icons.person,
                'Профайл',
                context,
                '/profile',
                'answers',
                Color(0xffFF6D6D),
                Icons.analytics_outlined,
                'Хариунууд',
                '/firstPage',
              ),
              homePageCardsGroup(
                  'timeOrder',
                  Colors.lightGreen,
                  Icons.calendar_today_sharp,
                  'Цаг авах',
                  context,
                  '/hospitals',
                  'hospitals',
                  Color(0xffffa700),
                  Icons.article,
                  'Эмнэлэгүүд',
                  '/hospitals'),
              homePageCardsGroup(
                  'Хариунууд',
                  Color(0xff63ace5),
                  Icons.ad_units_outlined,
                  'Лавлагаа 1',
                  context,
                  '/form1',
                  'Хариунууд',
                  Color(0xfff37736),
                  Icons.article_sharp,
                  'Эмч нар',
                  '/doctors'),
              homePageCardsGroup(
                  'Хариунууд',
                  Color(0xffFF6D6D),
                  Icons.android,
                  'Example example',
                  context,
                  '/form1',
                  'Хариунууд',
                  Colors.lightGreen,
                  Icons.text_format,
                  'Example',
                  '/form1'),
              homePageCardsGroup(
                  'Хариунууд',
                  Color(0xffffa700),
                  Icons.text_fields,
                  'Example',
                  context,
                  '/form1',
                  'Хариунууд',
                  Color(0xff63ace5),
                  Icons.gamepad_outlined,
                  'Example example',
                  '/form1'),
              SizedBox(height: _w / 20),
            ],
          ),
          /// SETTING ICON
          Padding(
            padding: EdgeInsets.fromLTRB(0, _w / 9.5, _w / 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // Get.to(() => form1());
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(99)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        height: _w / 8.5,
                        width: _w / 8.5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.settings,
                            size: _w / 17,
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
      String description,
      Color color,
      IconData icon,
      String title,
      BuildContext context,
      String route,
      String description2,
      Color color2,
      IconData icon2,
      String title2,
      String route2) {
    double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: _w / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(description, color, icon, title, context, route),
          homePageCard(description2, color2, icon2, title2, context, route2),
        ],
      ),
    );
  }
  Widget homePageCard(description, Color color, IconData icon, String title,
      BuildContext context, String route) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            HapticFeedback.lightImpact();
            print('something good gonna happen');
            Get.toNamed(route, arguments: description);
          },
          child: Container(
            padding: EdgeInsets.all(15),
            height: _w / 2,
            width: _w / 2.4,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff040039).withOpacity(.15),
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
        ),
      ),
    );
  }
}









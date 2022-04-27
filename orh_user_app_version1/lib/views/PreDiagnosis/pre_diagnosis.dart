import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../MyWidgets/my_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../global_constant.dart';

class PreDiagnosis extends StatefulWidget {
  const PreDiagnosis({ Key? key }) : super(key: key);

  @override
  State<PreDiagnosis> createState() => _PreDiagnosis();
}

class _PreDiagnosis extends State<PreDiagnosis> {
  var otrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              shadowColor: Colors.black.withOpacity(.5),
              title: Text(
                'Хариу',
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
            body: Stack(
              children: [
                SingleChildScrollView(
            child: SizedBox(
              height: GeneralMeasurements.deviceHeight*.8,
              child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index){              
                return Container(
                  decoration: BoxDecoration(
                    color: index.isEven? Color(0xFFA1D4A5) : Color(0xFFCDD74E),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight:Radius.circular(30)),
                  ),
                  margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(children: [
                          SizedBox(width: 200, child: myText('Зүрхний цахилгаан бичлэг', 14, 1, FontWeight.bold),), 
                          const SizedBox(width: 5,), 
                          Text(
                             index.isEven? '(хэвийн)' : '(өөрчлөлттэй)',
                            maxLines: 4,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(height: 1, fontWeight: FontWeight.bold, fontSize: 12,
                            color:const Color.fromARGB(255, 7, 110, 11).withOpacity(.5)),
                            )],),
                      Row(
                          children: [
                            SizedBox(
                              width: GeneralMeasurements.deviceWidth*.8,
                              child: myText('Зүрхний цахилгаан бичлэг нь ихэнхдээ зүрхний хэм, дамжуулах тогтолцооны эмгэг, болон зүрхний булчингийн шигдээсийг үнэлэхэд чухал шинжилгээ билээ. Мөн зүрхний эмгэгүүдийн бусад хэлбэрүүдийг үнэлэхэд томоохон үүрэгтэй үүнд: зүрхний хавхлагын эмгэг, кардиомиопати, перикардит, болон гипертензийн эмгэгүүд багтана. Эцэст нь ЗЦБ-ийг эмийн эмчилгээг (ялангуяа хэм алдагдлын эсрэг эмчилгээ) болон бодисын солилцооны алдагдлыг хянахад хэрэглэх боломжтой байдаг.', 14, 1)
                              ),
                              const Icon( 
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                                )
                            ],
                        ),
                    ],
                  ),
                );
              }
              ),
            )
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80, right: 15),
              child: InkWell(
                onTap: (){
                  Get.toNamed(RouteUnits.timeOrder + RouteUnits.hospitals, arguments: RouteUnits.fromTimeOrder );
                },
                child: myBtn(CommonColors.geregeBlue, 100, 30, CommonColors.geregeBlue, Colors.white, 'Цаг авах'),
              )
              ))
              ],
            ),
      ),
    );
  }
}
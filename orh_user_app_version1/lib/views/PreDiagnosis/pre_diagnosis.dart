import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:get/get.dart';
import '../../MyWidgets/my_button.dart';
import '../../MyWidgets/text_input.dart';
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
    return Scaffold(
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight:Radius.circular(15)),
                  border: Border.all(color: const Color.fromARGB(255, 34, 136, 38), width: 2)
                ),
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: Column(
                  children: [
                    Row(children: [
                        myText('Зүрхний цахилгаан бичлэг', 14, 1), 
                        const SizedBox(width: 20,), 
                        Text(
                           'хэвийн',
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(height: 1, fontWeight: FontWeight.bold, fontSize: 12,
                          color: const Color.fromARGB(255, 7, 110, 11).withOpacity(.5)),)],),
                    Row(
                        children: [
                          SizedBox(
                            width: GeneralMeasurements.deviceWidth*.8,
                            child: myText('Зүрхний цахилгаан бичлэг нь ихэнхдээ зүрхний хэм, дамжуулах тогтолцооны эмгэг, болон зүрхний булчингийн шигдээсийг үнэлэхэд чухал шинжилгээ билээ. Мөн зүрхний эмгэгүүдийн бусад хэлбэрүүдийг үнэлэхэд томоохон үүрэгтэй үүнд: зүрхний хавхлагын эмгэг, кардиомиопати, перикардит, болон гипертензийн эмгэгүүд багтана. Эцэст нь ЗЦБ-ийг эмийн эмчилгээг (ялангуяа хэм алдагдлын эсрэг эмчилгээ) болон бодисын солилцооны алдагдлыг хянахад хэрэглэх боломжтой байдаг.', 14, 1)
                            ),
                            const Icon( 
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
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
            child: myBtn(CommonColors.geregeBlue, 100, 30, CommonColors.geregeBlue, Colors.white, 'Цаг авах').pressExtention((){
              Get.toNamed(RouteUnits.timeOrder + RouteUnits.hospitals, arguments: RouteUnits.preDiagnosis );
            })
            ))
            ],
          ),
    );
  }
}
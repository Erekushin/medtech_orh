import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';
import 'CreatedWidgets/DoctorCard.dart';

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomNavBar(),
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          shadowColor: Colors.black.withOpacity(.5),
          title: Text(
            'Эмч нар',
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
        body:  Container(
          margin: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                DoctorCard(Name: "Буян-Хишиг", Phone: "98987845", Mail: "buynaa@yahoo.com", Profesion: "Дотор", AvatarPhoto: "assets/images/Avatar.jpg", SocialStatus: 1,),
                DoctorCard(Name: "Түвшээ", Phone: "88745487", Mail: "Tuvshee@Gmail.com", Profesion: "Шүд", AvatarPhoto: "assets/images/avatar2.jpg", SocialStatus: 0,),
                DoctorCard(Name: "Төгсжаргал", Phone: "94777658", Mail: "world@gmail.com", Profesion: "Мэдрэл", AvatarPhoto: "assets/images/avatar3.jpg", SocialStatus: 0,),
                DoctorCard(Name: "Солонгоо", Phone: "95894444", Mail: "sookoo_kk44@yahoo.com", Profesion: "БЗДХ", AvatarPhoto: "assets/images/avatar4.jpg", SocialStatus: 1,),
                DoctorCard(Name: "Наранзул", Phone: "99992222", Mail: "bossyCountry@gmail.com", Profesion: "Эрхлэгч", AvatarPhoto: "assets/images/avatar5.jpg", SocialStatus: 0,),
                DoctorCard(Name: "Сувдэрдэнэ", Phone: "88958748", Mail: "daamAmidray@gmail.com", Profesion: "Фицик", AvatarPhoto: "assets/images/avatar6.jpg", SocialStatus: 1,),
              ],
            ),
          ),
        )
    );
  }
}












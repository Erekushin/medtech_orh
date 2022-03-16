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
                DoctorCard(name: "Буян-Хишиг", phone: "98987845", mail: "buynaa@yahoo.com", profesion: "Дотор", avatarPhoto: "assets/images/Avatar.jpg", socialStatus: 1,),
                DoctorCard(name: "Түвшээ", phone: "88745487", mail: "Tuvshee@Gmail.com", profesion: "Шүд", avatarPhoto: "assets/images/avatar2.jpg", socialStatus: 0,),
                DoctorCard(name: "Төгсжаргал", phone: "94777658", mail: "world@gmail.com", profesion: "Мэдрэл", avatarPhoto: "assets/images/avatar3.jpg", socialStatus: 0,),
                DoctorCard(name: "Солонгоо", phone: "95894444", mail: "sookoo_kk44@yahoo.com", profesion: "БЗДХ", avatarPhoto: "assets/images/avatar4.jpg", socialStatus: 1,),
                DoctorCard(name: "Наранзул", phone: "99992222", mail: "bossyCountry@gmail.com", profesion: "Эрхлэгч", avatarPhoto: "assets/images/avatar5.jpg", socialStatus: 0,),
                DoctorCard(name: "Сувдэрдэнэ", phone: "88958748", mail: "daamAmidray@gmail.com", profesion: "Фицик", avatarPhoto: "assets/images/avatar6.jpg", socialStatus: 1,),
              ],
            ),
          ),
        )
    );
  }
}












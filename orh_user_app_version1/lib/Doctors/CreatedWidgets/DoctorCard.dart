import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Helpers/CreatedGlobalWidgets/on_press_extention.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({Key? key,required this.Name,required this.Phone,required this.Mail,required
  this.AvatarPhoto,required this.Profesion, required this.SocialStatus}) : super(key: key);
  final String Name;
  final String Phone;
  final String Mail;
  final String AvatarPhoto;
  final String Profesion;
  final int SocialStatus;
  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 150,
        height: 250,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFE6E7E8),
        ),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 40,
                            backgroundImage: AssetImage(widget.AvatarPhoto),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: widget.SocialStatus == 1? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(widget.Name, style: TextStyle(color: Color(0xFF8BA3B8),
                        fontWeight: FontWeight.bold),),
                    Text(widget.Phone, style: TextStyle(color: Color(0xFF8BA3B8),
                        fontWeight: FontWeight.bold),),
                    Text(widget.Mail, style: TextStyle(color: Color(0xFF8BA3B8),
                        fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
              Container(width: 200, height: 200, child: ClipPath(
                clipper: MyClipper(),
                child: Container(color: Colors.blue,),
              ),),
              Container(
                margin: EdgeInsets.all(10),
                child:  Text(widget.Profesion, style: TextStyle(
                    fontSize: 20, color: Colors.white,
                    fontWeight: FontWeight.bold),),
              )
            ],
          ),
        )
    ).PressExtention((){
      print('Click from doctor card ');
      Get.toNamed('/doctorTimeSequence');
    });
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    Path path0 = Path();
    path0.moveTo(size.width*0.1257917,size.height);
    path0.cubicTo(size.width*0.1657083,size.height*0.8774143,size.width*0.1563833,size.height*0.8604286,size.width*0.2086167,size.height*0.8194714);
    path0.cubicTo(size.width*0.3747917,size.height*0.7721429,size.width*0.6249000,size.height*0.7735714,size.width*0.7920083,size.height*0.8185857);
    path0.cubicTo(size.width*0.8448500,size.height*0.8585000,size.width*0.8342750,size.height*0.8775143,size.width*0.8736333,size.height);
    path0.cubicTo(size.width*0.6543333,size.height*1.0152000,size.width*0.7833583,size.height*1.0067000,size.width*0.1257917,size.height);
    path0.close();
    return path0;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_constant.dart';
class DoctorCard extends StatefulWidget {
  const DoctorCard({Key? key,required this.name,required this.phone,required this.mail,required
  this.avatarPhoto,required this.profesion, required this.socialStatus}) : super(key: key);
  final String name;
  final String phone;
  final String mail;
  final String avatarPhoto;
  final String profesion;
  final int socialStatus;
  @override
  _DoctorCardState createState() => _DoctorCardState();
}
class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
         final description = Get.arguments as String;
      switch(description){
        case RouteUnits.fromDoctors:
          Get.toNamed(RouteUnits.doctors + RouteUnits.doctorProfile, arguments: RouteUnits.fromDoctors);
          break;
        case RouteUnits.fromTimeOrder:
          Get.toNamed(RouteUnits.timeOrder + RouteUnits.hospitals + RouteUnits.doctors + RouteUnits.timeSequence, arguments: RouteUnits.fromTimeOrder);
      }

      },
      child: Container(
        width: 150,
        height: 250,
        margin: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all( Radius.circular(10)),
          color:Color(0xFFE6E7E8),
        ),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 40,
                            backgroundImage: AssetImage(widget.avatarPhoto),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: widget.socialStatus == 1? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(widget.name, style: const TextStyle(color: Color(0xFF8BA3B8),
                        fontWeight: FontWeight.bold),),
                    Text(widget.phone, style: const TextStyle(color: Color(0xFF8BA3B8),
                        fontWeight: FontWeight.bold),),
                    Text(widget.mail, style: const TextStyle(color: Color(0xFF8BA3B8),
                        fontWeight: FontWeight.bold),),
                    const SizedBox(
                       height: 50,
                    )
                  ],
                ),
              SizedBox(width: 200, height: 200, child: ClipPath(
                clipper: DoctorCartBottomShape(),
                child: Container(color: Colors.blue,),
              ),),
              Container(
                margin: const EdgeInsets.all(10),
                child:  Text(widget.profesion, style: const TextStyle(
                    fontSize: 20, color: Colors.white,
                    fontWeight: FontWeight.bold),),
              )
            ],
          ),
        )
    ),
    );
  }
}
class DoctorCartBottomShape extends CustomClipper<Path>{
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

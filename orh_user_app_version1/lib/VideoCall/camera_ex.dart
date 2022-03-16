import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
List<CameraDescription>? cameras;

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras![1], ResolutionPreset.low);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: _h,
            width: _w,
            child: CameraPreview(controller!),
          ),
          Column(
            children: [
              SizedBox(height: _h/20*1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      print('fgf');
                      Get.toNamed('home');
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      Text('Calling', style: TextStyle(color: Colors.white),),
                      Text('Дөлгөөн', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  SizedBox(width: _w/4*1,),
                  TextButton(onPressed: (){}, child: Text('Setting'))
                ],
              ),
              SizedBox(height: _h/20*1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    width: _w/6*2,
                    height: _h/4*1,
                    child: CameraPreview(controller!)
                  ),
                ],
              ),
              SizedBox(height: _h/4*1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: Animator<double>(
                      duration: Duration(milliseconds: 1500),
                      cycles: 1,
                      curve: Curves.easeInOut,
                      tween: Tween<double>(begin: 0.0, end: 15.0),
                      builder: (context, animatorState, child) => Container(
                        margin: EdgeInsets.all(animatorState.value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF5757),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFF5757).withOpacity(0.5),
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: _h/20*1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OnScreenBtn(Icons.camera),
                  OnScreenBtn(Icons.message),
                  OnScreenBtn(Icons.mic),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget OnScreenBtn(IconData icon) {
  return Opacity(
    opacity: 0.5,
    child: Transform.translate(
      offset: Offset(0, 0.3),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          print('tap on btn from camera');
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

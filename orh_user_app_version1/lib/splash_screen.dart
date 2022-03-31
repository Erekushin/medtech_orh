import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'global_constant.dart';

class MyCustomSplashScreen extends StatefulWidget {
  const MyCustomSplashScreen({Key? key}) : super(key: key);
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  // String? _identifier = 'UnknownUngaBanga';
  String uniqueId = "Unknown";
  Future<void> initUniqueIdentifierState() async {
    // String? identifier;

    //  try {
    //   String platformVersion = await DeviceInformation.platformVersion;
    //   String imeiNo = await DeviceInformation.deviceIMEINumber;
    //   String modelName = await DeviceInformation.deviceModel;
    //   String manufacturer = await DeviceInformation.deviceManufacturer;
    //   String apiLevel =  await DeviceInformation.apiLevel;
    //   String deviceName = await DeviceInformation.deviceName;
    //   String productName = await DeviceInformation.productName;
    //   String cpuType = await DeviceInformation.cpuName;
    //   String hardware = await DeviceInformation.hardware;
    // } on PlatformException {
    //   String ee = 'Failed to get platform version.';
    // }
    // try {
    //   identifier = await UniqueIdentifier.serial;
    // } on PlatformException {
    //   identifier = 'Failed to get Unique Identifier';
    // }
    // if (!mounted) return;
    // setState(() {
    //   _identifier = identifier;
    // });
    // Get.find<LoginController>().model.terminalID = _identifier;  
  }



  late AnimationController _controller;
  late Animation<double> animation1;
 
  @override
  void initState(){
    initUniqueIdentifierState();
    super.initState();
    //file uudaa vvsgeh
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 4), () {
      setState(() {
        Get.toNamed(RouteUnits.login);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GeneralMeasurements.deviceHeight = MediaQuery.of(context).size.height;
    GeneralMeasurements.deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CommonColors.geregeBlue,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: GeneralMeasurements.deviceHeight / _fontSize
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'Gerege Systems',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: GeneralMeasurements.deviceWidth / _containerSize,
                  width: GeneralMeasurements.deviceWidth / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset('assets/images/gerege-black.png')
              ),
            ),
          ),
        ],
      ),
    );
  }
}




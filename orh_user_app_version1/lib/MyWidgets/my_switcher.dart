
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';

class MySwitcher extends StatefulWidget {
  MySwitcher({Key? key, required this.keyDirection, required this.switcherValue}) : super(key: key);
  String keyDirection;
  bool switcherValue;
  @override
  _MySwitcher createState() => _MySwitcher();
}

class _MySwitcher extends State<MySwitcher>
    with TickerProviderStateMixin {
  final _duration = const Duration(milliseconds: 1);
  late Animation<Alignment> _animation;
  late AnimationController _animationController;
  var settingController =  Get.find<SettingController>();
  late bool switcherValue;
  @override
  void initState() {
    super.initState();
    switcherValue = widget.switcherValue;
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _animation =
        AlignmentTween(begin: switcherValue? Alignment.centerRight : Alignment.centerLeft, 
                       end: switcherValue? Alignment.centerLeft : Alignment.centerRight)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Center(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(
                    () {
                      if (settingController.xyrServiceSwitcher.value) {
                        print('untraah daralt');
                         switch(widget.keyDirection){
                          case 'xyrServiceSwitcher':
                          settingController.xyrServiceSwitcher.value = false;
                          switcherValue = false;
                          print('xyr server untraah daralt');
                          print(settingController.xyrServiceSwitcher.value);
                        }
                        _animationController.reverse();
                        
                      } else {
                        print('idvehjvvleh daralt');
                        switch(widget.keyDirection){
                          case 'xyrServiceSwitcher':
                            settingController.xyrServiceSwitcher.value = true;
                            switcherValue = true;
                            print('xyr server asaah daralt');
                            print(settingController.xyrServiceSwitcher.value);
                        }
                        _animationController.forward();
                      }
                    },
                  );
                },
                child: Container(
                  width: 50,
                  height: 25,
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                  decoration: BoxDecoration(
                    color:switcherValue ? Colors.green : Colors.red,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(99),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: switcherValue
                            ? Colors.green.withOpacity(0.5)
                            : Colors.red.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child:  Align(
                        alignment: switcherValue? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                      ),
                ),
              ),
            );
          },
        );
  }
}



      
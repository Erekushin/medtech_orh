import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/GlobalControllers/image_controller.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../Helpers/CreatedGlobalWidgets/scroll_behavior.dart';
import 'controller.dart';
import 'model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login>with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  GlobalKey<FormState> loginValidatorKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Get.put(LoginController());
    Get.put(ImageController());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
      setState(() {});
    });
    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    _controller.forward();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (logincontroller){
      return Scaffold(
      extendBodyBehindAppBar: true,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: GeneralMeasurements.deviceHeight,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffFEC37B),
                    Color(0xffFF4184),
                  ],
                ),
              ),
              child: Opacity(
                opacity: _opacity.value,
                child: Transform.scale(
                  scale: _transform.value,
                  child: Container(
                      width: GeneralMeasurements.deviceWidth * .9,
                      height: GeneralMeasurements.deviceWidth * 1.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 90,
                          ),
                        ],
                      ),
                      child: Form(
                        key: loginValidatorKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(),
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(.7),
                              ),
                            ),
                            const SizedBox(),
                            component1(Icons.account_circle_outlined,
                                'User name...', false, false, logincontroller.username),
                            component1(
                                Icons.lock_outline, 'Password...', true, false, logincontroller.pass),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: (){
                                    loginValidatorKey.currentState?.validate();
                                    Get.find<LoginController>().getdata();
                                    print('sddfdf');
                                  },
                                  child: Container(
                                    height: GeneralMeasurements.deviceWidth / 8,
                                    width: GeneralMeasurements.deviceWidth / 2.6,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4796ff),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "LOGIN",
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(width: GeneralMeasurements.deviceWidth / 25),
                                Container(
                                  width: GeneralMeasurements.deviceWidth / 2.6,
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Forgotten password!',
                                      style: const TextStyle(color: Colors.blueAccent),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                        },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(),
                            RichText(
                              text: TextSpan(
                                text: 'Create a new Account',
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  Get.toNamed(RouteUnits.basicProfileInput);
                                  },
                              ),
                            ),
                            const SizedBox(),
                            // Obx((){
                            //   if(Get.find<LoginController>().loginloading as bool){} const CircularProgressIndicator() : const SizedBox();
                            // })
                            GetX<LoginController>(builder: (builder){
                              return builder.loginloading.isTrue? const CircularProgressIndicator() : const SizedBox();
                            })
                          ],
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    });
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, TextEditingController controller) {
    return Container(
      height: GeneralMeasurements.deviceWidth / 8,
      width: GeneralMeasurements.deviceWidth / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: GeneralMeasurements.deviceWidth / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: (val){
          if(val!.isEmpty){
            return "Required";
          }
        },
        controller: controller,
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
          TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }
}
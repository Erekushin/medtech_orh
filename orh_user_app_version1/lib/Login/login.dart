import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../Helpers/CreatedGlobalWidgets/scroll_behavior.dart';
import 'controller.dart';
import 'model.dart';
import 'package:unique_identifier/unique_identifier.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login>with SingleTickerProviderStateMixin {
  LoginController logincontroller = new LoginController();
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  GlobalKey<FormState> LoginValidatorKey = GlobalKey<FormState>();

  String? _identifier = 'UnknownUngaBanga';
  Future<void> initUniqueIdentifierState() async {
    print('future ajillaj bna');
    String? identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }
    print("serial aa avsan bj magadgvi");
    print(identifier);
    if (!mounted) return;
    setState(() {
      _identifier = identifier;
    });
  }
  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
    print(_identifier);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
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
                      width: size.width * .9,
                      height: size.width * 1.1,
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
                        key: LoginValidatorKey,
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
                                'User name...', false, false, logincontroller.rD),
                            component1(
                                Icons.lock_outline, 'Password...', true, false, logincontroller.pass),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                component2(
                                    'LOGIN',
                                    2.6,
                                        () => logincontroller.getdata()
                                ),
                                SizedBox(width: size.width / 25),
                                Container(
                                  width: size.width / 2.6,
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
                            LoginModel.loginloading? CircularProgressIndicator() : SizedBox()
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
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
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
  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => setState(() {
        LoginValidatorKey.currentState?.validate();
        voidCallback();
      }) ,
      child: Container(
        height: size.width / 8,
        width: size.width / width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff4796ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          string,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

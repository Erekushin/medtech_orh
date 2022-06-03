import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../Controllers/image_controller.dart';
import '../../Controllers/SurveyRelated/survey_controller.dart';
import '../../global_constant.dart';
import '../../global_helpers.dart';
import '../splash_screen.dart';

class AnswerForm extends StatefulWidget {
  const AnswerForm({ Key? key }) : super(key: key);
  @override
  State<AnswerForm> createState() => _AnswerFormState();
}
class _AnswerFormState extends State<AnswerForm> {
  var authController = Get.find<AuthController>();

  MatchEngine? _matchEngine;
  List<SwipeItem> answercards = <SwipeItem>[];
  @override
  void initState() {
    answercards.add(SwipeItem(
           content: BasicProfileData1(nameController: authController.nameCont, passConroller: authController.passCont,
                       phoneController: authController.phoneCont, rdController: authController.rdCont,),
           onSlideUpdate: (SlideRegion? region) async {
          }));
    answercards.add(SwipeItem(
           content: BasicProfileData2(phoneController: authController.phoneCont, rdController: authController.rdCont,),
           onSlideUpdate: (SlideRegion? region) async {
          }));
    _matchEngine = MatchEngine(swipeItems: answercards);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: Container(///background container
            color: CommonColors.geregeBlue,
            child: Center(
              child: SizedBox(///Картуудыг агуулах Container
                width: GeneralMeasurements.deviceWidth/100*90,
                height: GeneralMeasurements.deviceHeight/100*60,
                child: SwipeCards(///Картууд
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: GeneralMeasurements.deviceWidth/100*90,
                        height: GeneralMeasurements.deviceHeight/100*60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child:  answercards[index].content);
                  },
                  onStackFinished: () {
                    if(authController.phoneCont.text.isEmpty || authController.rdCont.text.isEmpty){
                      Get.snackbar('талбарууд бөглөгдөөгүй байна', "", snackPosition: SnackPosition.BOTTOM,
                         colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
                         Get.toNamed(RouteUnits.login);
                    }
                    else{
                      authController.registration();
                    Get.to(const MyCustomSplashScreen());
                    }
                  },
                  itemChanged: (SwipeItem item, int index) {
                    print("item: ${item.content}, index: $index");
                    print('item transform it self');
                    if(index == 1){
                      if(authController.nameCont.text.isEmpty || authController.passCont.text.isEmpty){
                         Get.snackbar('талбарууд бөглөгдөөгүй байна', "", snackPosition: SnackPosition.BOTTOM,
                         colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
                         Get.toNamed(RouteUnits.login);
                      }
                    }
                  },
                  upSwipeAllowed: false,
                  fillSpace: false,
                ),
              ),
            )));
  }
}

class BasicProfileData2 extends StatefulWidget {
  BasicProfileData2({Key? key, required this.phoneController,required  this.rdController}) : super(key: key);
  final TextEditingController phoneController;
  final TextEditingController rdController;
  @override
  _BasicProfileData2 createState() => _BasicProfileData2();
}
class _BasicProfileData2 extends State<BasicProfileData2> {
  final registerFormKey = GlobalKey<FormState>();
  var surveyController = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){}, child: const Text('swipe'))
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                            color: Color(0xFFFF4484)
                        ),
                        width: 200,
                        height: 5,
                      )
                    ],
                  ),
              Form(
                key: registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                          Container(//phone
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                  child: TextFormField(
                    onChanged: (string){
                       final isvalid = registerFormKey.currentState!.validate();
                    },
                     validator: (val){
                        RegExp exp = RegExp(
                     r"^\d{8}$",
                     caseSensitive: false);
                      if(val!.length != 8){
                        return "орны тоо зөрүүтэй байна.";
                      }
                      else if(!exp.hasMatch(val)){
                        return "дугаарыг заавал тоогоор оруулна.";
                      }
                    },
                        controller: widget.phoneController,
                        style: TextStyle(color: Colors.black.withOpacity(.8)),
                        decoration: InputDecoration(
                          hintMaxLines: 1,
                          hintText: 'Утас',
                          hintStyle:
                          TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
                        ),
                ),
                ),
                 Container(//rd
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                  child: TextFormField(
                    onChanged: (string){
                       final isvalid = registerFormKey.currentState!.validate();
                    },
                     validator: (val){
                        RegExp exp = RegExp(
                     r"^[а-я]{2}\d{8}$",
                     caseSensitive: false);
                      if(val!.length != 10){
                        return "орны тоо зөрүүтэй байна.";
                      }
                      else if(!exp.hasMatch(val)){
                        return "Регистрийн бүтэц буруу байна.";
                      }
                    },
                        controller: widget.rdController,
                        style: TextStyle(color: Colors.black.withOpacity(.8)),
                        decoration: InputDecoration(
                          hintMaxLines: 1,
                          hintText: 'Регистрийн дугаар',
                          hintStyle:
                          TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
                        ),
                ),
                )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
} 

class BasicProfileData1 extends StatefulWidget {
  const BasicProfileData1({ Key? key, required this.nameController, required this.passConroller,
                                required this.phoneController, required this.rdController }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController passConroller;
  final TextEditingController phoneController;
  final TextEditingController rdController;
  @override
  State<BasicProfileData1> createState() => _BasicProfileData1State();
}
class _BasicProfileData1State extends State<BasicProfileData1> {
  final registerFormKey = GlobalKey<FormState>();
  bool passHide = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Form(
          key: registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20,),
                  GetX<ImageController>(builder: (imageController){
                    return InkWell(
                      onTap: (){
                          GlobalHelpers.imageFileSwitcher = true;
                          imageController.cameraAndGallery();
                      },
                      child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 40,
                    backgroundImage: const AssetImage('assets/images/user_default.png'),
                    child:  GlobalHelpers.imageFileSwitcher? ClipRRect(
                                 child: AspectRatio(aspectRatio: 1 / 1, child: Image.file(imageController.imageFile.value, fit: BoxFit.fill,)),
                                 borderRadius: BorderRadius.circular(90.0)
                                 ): Container(color: Colors.blue, width: 1, height: 1, child: Text(imageController.imageFile.value.toString()),)
                    ),
                    );
                  })
                ],
              ),
             Container(//ner
                padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                child: TextFormField(
                  onChanged: (string){
                     final isvalid = registerFormKey.currentState!.validate();
                  },
                   validator: (val){
                     if(val!.isEmpty){
                      return "Required";
                     }
                  },
          controller: widget.nameController,
          style: TextStyle(color: Colors.black.withOpacity(.8)),
          decoration: InputDecoration(
            hintMaxLines: 1,
            hintText: 'Нэр',
            hintStyle:
            TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
          ),
              ),
              ),
               Container(//pass
                padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                child: TextFormField(
                  onChanged: (string){
                     final isvalid = registerFormKey.currentState!.validate();
                  },
                   validator: (val){
                     RegExp exp = RegExp(
                     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[*.@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
                     caseSensitive: false);
                     if(val!.length < 8){
                      return "тэмдэгтийн тоо 8 аас дээш байх хэрэгтэй";
                     }
                     else if(!exp.hasMatch(val)){
                       return "үсэг, тоо, тэмдэгт байх хэрэгтэй ";
                     }
                  },
          controller: widget.passConroller,
          style: TextStyle(color: Colors.black.withOpacity(.8)),
          obscureText: passHide,
          decoration: InputDecoration(
            suffixIcon: passHide? InkWell(
              onTap: (){setState(() {
                passHide = false;
              });},
              child: const Icon(Icons.visibility_off)) : InkWell(
                onTap: (){setState(() {
                  passHide = true;
                });},
                child: const Icon(Icons.visibility)),
            hintMaxLines: 1,
            hintText: 'Нууц үг',
            hintStyle:
            TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
          ),
              ),
              ),
              Container(//pass davtah
                padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                child: TextFormField(
                  onChanged: (string){
                     final isvalid = registerFormKey.currentState!.validate();
                  },
                   validator: (val){
                     if(val! != widget.passConroller.text){
                      return "Нууц үг таарахгүй байна";
                     }
                  },
          style: TextStyle(color: Colors.black.withOpacity(.8)),
          obscureText: passHide,
          decoration: InputDecoration(
            hintMaxLines: 1,
            hintText: 'Нууц үг давтах',
            hintStyle:
            TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
          ),
              ),
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){}, child: const Text('swipe'))
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    color: Color(0xFFFF4484)
                ),
                width: 200,
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
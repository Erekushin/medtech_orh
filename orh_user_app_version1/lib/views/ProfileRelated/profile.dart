import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/Controllers/image_controller.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Controllers/SurveyRelated/survey_controller.dart';
import '../../MyWidgets/my_button.dart';
import '../../MyWidgets/my_text.dart';
import '../../Controllers/SurveyRelated/survey_creation_controller.dart';

class ButtonStructure {
  const ButtonStructure(
      {required this.title,
      required this.icon,
      required this.route,
      this.argument});
  final String title;
  final IconData icon;
  final String route;
  final dynamic argument;
}

List<ButtonStructure> bigButtons = <ButtonStructure>[
  ButtonStructure(
      title: 'Mэдээлэл', icon: Icons.person, route: RouteUnits.profileInfo),
  ButtonStructure(
      title: 'Онош Түүх',
      icon: Icons.history,
      route: RouteUnits.profileDiagnosisHistory),
  ButtonStructure(
      title: 'my responds',
      icon: Icons.token,
      route: RouteUnits.myResponds,
      argument: {'user_id': '1'}),
  ButtonStructure(
      title: 'Device Log', icon: Icons.book, route: RouteUnits.profileDeviceLog)
];

Widget profileBigButtons(ButtonStructure structureInfo) {
  var surveyController = Get.find<SCont>();
  var loginController = Get.find<AuthController>();
  return InkWell(
    onTap: () async {
      switch (structureInfo.title) {
        case 'my responds':
          await surveyController.listGet(
              RouteUnits.attached,
              '120012',
              loginController.user.result!.userId!,
              '',
              loginController.user.result!.phone!,
              GlobalHelpers.profileSurveyLstth);
          break;
      }
      Get.toNamed(structureInfo.route, arguments: structureInfo.argument);
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      width: GeneralMeasurements.deviceWidth / 10 * 6,
      height: GeneralMeasurements.deviceHeight / 100 * 10,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0.1,
                blurRadius: 10,
                offset: const Offset(0, 7))
          ]),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: CommonColors.geregeBlue.withOpacity(0.1),
          child: Icon(structureInfo.icon,
              size: 30.0, color: CommonColors.geregeBlue),
        ),
        const SizedBox(
          width: 1,
          height: 10,
        ),
        Text(
          structureInfo.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ]),
    ),
  );
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ImageController imageController = ImageController();
  var surveyController = Get.find<SCont>();
  var loginController = Get.find<AuthController>();
  var scrollController = ScrollController();
  var surveyCreationController = Get.find<CreationCont>();
  var proPic = Get.find<AuthController>().user.result!.picture?.cast<int>();
  GlobalKey<ScaffoldState> sidePageKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(viewportFraction: 0.85);
  final argu = Get.arguments as String;
  @override
  Widget build(BuildContext profilecontext) {
    return WillPopScope(
      onWillPop: () async {
        if (argu == RouteUnits.profile) {
          GlobalHelpers.bottomnavbarSwitcher.add(false);
        } else {}
        return true;
      },
      child: Scaffold(
          key: sidePageKey,
          endDrawer: const ProfileSidebar(),
          body: Stack(
            children: [
              Container(
                //navbar aas dooshoo zalgasan tsenher backround
                height: GeneralMeasurements.deviceHeight / 100 * 25,
                decoration: BoxDecoration(
                    color: CommonColors.geregeBlue,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: GeneralMeasurements.deviceHeight / 100 * 12,
                      child: Row(
                        //navbar deer bgaa row
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.maybePop(context),
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    GlobalHelpers.bottomnavbarSwitcher
                                        .add(false);
                                    Get.find<AuthController>()
                                        .loginName
                                        .clear();
                                    Get.find<AuthController>()
                                        .loginPass
                                        .clear();
                                    Get.offAllNamed(RouteUnits.login);
                                  },
                                  child: const Text(
                                    'change account',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              InkWell(
                                // menu btn
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  sidePageKey.currentState?.openEndDrawer();
                                },
                                child: Icon(
                                  Icons.menu,
                                  size: GeneralMeasurements.deviceWidth / 17,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    GetBuilder<AuthController>(builder: (loginController) {
                      return Container(
                        //Profile picture container............................................................!
                        width: GeneralMeasurements.deviceWidth / 7 * 6,
                        height: GeneralMeasurements.deviceHeight / 100 * 24,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 7))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GetX<ImageController>(builder: (imageController) {
                              return InkWell(
                                onTap: () {
                                  GlobalHelpers.imageFileSwitcher = true;
                                  imageController.cameraAndGallery(
                                      RouteUnits.profile, profilecontext);
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 60,
                                    backgroundImage: const AssetImage(
                                        'assets/images/user_default.png'),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90.0),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Image.memory(Uint8List.fromList(
                                            imageController.imageBytes)),
                                      ),
                                    )),
                              );
                            }),
                            const SizedBox(
                              width: 1,
                              height: 1,
                            ),

                            // Text(loginController.geregeUser.result!.firstName?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                            // Text(loginController.geregeUser.result!.phoneNo?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      );
                    }),

                    Column(
                      children: [
                        Image.asset('assets/images/empty_box.jpg'),
                        const Text(
                          'Таньд идвэхжүүлсэн үзүүлэлт алга байна',
                          style: TextStyle(),
                        ),
                        TextButton(
                            onPressed: () {
                              log('df');
                              Get.defaultDialog(
                                  title: 'үзүүлэлтүүд',
                                  content: Container(
                                    width: GeneralMeasurements.deviceWidth * .8,
                                    height:
                                        GeneralMeasurements.deviceHeight * .6,
                                    child: GridView.count(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 2,
                                      children: <Widget>[
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          padding: const EdgeInsets.all(5),
                                          child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Жингээ оруулах',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          padding: const EdgeInsets.all(5),
                                          child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Даралт оруулах',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          padding: const EdgeInsets.all(5),
                                          child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Цусан дахь сахрын хэмжээгээ оруулах',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          padding: const EdgeInsets.all(5),
                                          child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Шөнө хэдэн цаг унтсан',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text('болсон'))
                                  ]);
                            },
                            child: const Text('идвэхжүүлэх'))
                      ],
                    ),
                    const SizedBox(
                      width: 1,
                      height: 10,
                    ),

                    // SingleChildScrollView(
                    //   child: GridView.count(
                    //     crossAxisCount: 3,
                    //     children: <Widget>[
                    //       Container(
                    //         child: Text(''),
                    //       )
                    //     ],
                    //     ),
                    // )

                    // GetX<SCont>(builder: (profileController) {
                    //   return Stack(
                    //     children: [
                    //       SizedBox(
                    //         height: GeneralMeasurements.deviceHeight / 100 * 55,
                    //         child: SingleChildScrollView(
                    //           controller: scrollController,
                    //           physics: const BouncingScrollPhysics(
                    //               parent: AlwaysScrollableScrollPhysics()),
                    //           child: ListView.builder(
                    //               physics: const NeverScrollableScrollPhysics(),
                    //               shrinkWrap: true,
                    //               itemCount: profileController.ownSurveyListbody
                    //                       .value.result?.length ??
                    //                   0,
                    //               itemBuilder: (context, index) {
                    //                 var item = profileController
                    //                     .ownSurveyListbody.value.result![index];
                    //                 return OwnsUnit(
                    //                     surveyName: item.name ?? "",
                    //                     surveyId: item.id!,
                    //                     itemindx: index);
                    //               }),
                    //         ),
                    //       ),
                    //       Visibility(
                    //           visible: profileController
                    //                   .ownSurveyListbody.value.result!.isEmpty
                    //               ? true
                    //               : false,
                    //           child: Image.asset('assets/images/empty_box.jpg'))
                    //     ],
                    //   );
                    // })
                  ],
                ),
              ),
              GetX<SCont>(builder: (surveyControllermini) {
                return Visibility(
                  visible: surveyControllermini.surveyDeleteIcon.value,
                  child: InkWell(
                    onTap: () {
                      surveyControllermini.surveyDeleteIcon.value = false;
                      surveyController
                          .ownSurveyListbody
                          .value
                          .result![surveyControllermini.chosenSurveyIndx]
                          .borderColor
                          .value = Colors.white;
                    },
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 80),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              content: SizedBox(
                                                height: GeneralMeasurements
                                                        .deviceHeight *
                                                    .46,
                                                child: Column(
                                                  children: [
                                                    myText('Усгах уу?', 20, 1),
                                                    Image.asset(
                                                        'assets/images/thinkingBoy.png'),
                                                    const SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                              await surveyControllermini
                                                                  .delete();
                                                              setState(() {
                                                                surveyControllermini
                                                                    .surveyDeleteIcon
                                                                    .value = false;
                                                              });
                                                            },
                                                            child: myBtn(
                                                              CommonColors
                                                                  .geregeBlue,
                                                              100,
                                                              30,
                                                              CommonColors
                                                                  .geregeBlue,
                                                              Colors.white,
                                                              'delete',
                                                            )),
                                                        InkWell(
                                                            onTap: () {
                                                              surveyControllermini
                                                                  .surveyDeleteIcon
                                                                  .value = false;
                                                              surveyController
                                                                  .ownSurveyListbody
                                                                  .value
                                                                  .result![
                                                                      surveyController
                                                                          .chosenSurveyIndx]
                                                                  .borderColor
                                                                  .value = Colors.transparent;
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                            },
                                                            child: myBtn(
                                                              CommonColors
                                                                  .geregeBlue,
                                                              100,
                                                              30,
                                                              CommonColors
                                                                  .geregeBlue,
                                                              Colors.white,
                                                              'quit',
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    GlobalHelpers.bottomnavbarSwitcher
                                        .add(false);
                                    await surveyCreationController
                                        .getSurveyCreationTypes(
                                            RouteUnits.profile);
                                  },
                                  child: const Icon(
                                    Icons.settings,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                );
              })
            ],
          )),
    );
  }
}

class ProfileSidebar extends StatefulWidget {
  const ProfileSidebar({Key? key}) : super(key: key);

  @override
  State<ProfileSidebar> createState() => _ProfileSidebarState();
}

class _ProfileSidebarState extends State<ProfileSidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 5),
      child: Column(
        children: [
          profileBigButtons(bigButtons[0]),
          profileBigButtons(bigButtons[1]),
          profileBigButtons(bigButtons[2]),
          profileBigButtons(bigButtons[3]),
        ],
      ),
    );
  }
}

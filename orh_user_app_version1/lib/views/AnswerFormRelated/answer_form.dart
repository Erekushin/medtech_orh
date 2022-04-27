import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../Controllers/image_controller.dart';
import '../../Controllers/survey_controller.dart';
import '../../global_constant.dart';
import '../../global_helpers.dart';
import '../splash_screen.dart';

class AnswerForm extends StatefulWidget {
  const AnswerForm({ Key? key }) : super(key: key);

  @override
  State<AnswerForm> createState() => _AnswerFormState();
}

class _AnswerFormState extends State<AnswerForm> {
  final queryController = Get.find<SurveyController>();
   List<SwipeItem> answercards = <SwipeItem>[];/// Асуултууд бүхий картын List
   MatchEngine? _matchEngine;/// Swipe Card ыг тааруулагч тохиргоо
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
   List<dynamic> MyData = [///Нэмэлт хөгжүүлэлт хийх боломжтой байх үүднээс давхар List ээр дамжуулж байгаа
    new BasicProfileData1(),
    new BasicProfileData2(),
  ];
  @override
  void initState() {
    for (int i = 0; i < MyData.length; i++) {
      print(i.toString());
      answercards.add(SwipeItem(
          content: MyData[i],
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }
    // answercards = List<SwipeItem>.generate(a, ((index) => SwipeItem()));
    // print(answercards.length.toString());
    _matchEngine = MatchEngine(swipeItems: answercards);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        key: _scaffoldKey,
        body: Container(///background container
            color: CommonColors.geregeBlue,
            child: Center(
              child: SizedBox(///Картуудыг агуулах Container
                width: GeneralMeasurements.deviceWidth/100*90,
                height: GeneralMeasurements.deviceHeight/100*60,
                child: SwipeCards(///Картууд
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    print(index.toString() + "page index");
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
                    Get.to(const MyCustomSplashScreen());
                    Get.snackbar('Баяр хүргэе', 'Бүртгэл үүслээ', snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.all(5));
                  },
                  itemChanged: (SwipeItem item, int index) {
                    print("item: ${item.content}, index: $index");
                    print('item transform it self');
                  },
                  upSwipeAllowed: false,
                  fillSpace: false,
                ),
              ),
            )));
  }
}
class BasicProfileData2 extends StatefulWidget {
  const BasicProfileData2({Key? key}) : super(key: key);

  @override
  _BasicProfileData2 createState() => _BasicProfileData2();
}

class _BasicProfileData2 extends State<BasicProfileData2> {
  List<DropdownMenuItem<String>> h = [new DropdownMenuItem(child: Text('fdfd'))];

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
                          TextButton(onPressed: (){}, child: const Text('skip'))
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Үсний өнгө',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Дуртай хоол',
                      ),
                    ),
                  ),
                  // MyDropdown(dropDownHint: "үсний өнгө", w: 5, listitems: [], currentValue: 5, mark: "",),
                  SizedBox(height: 40,),
                ],
              ),
            ],
          )
      ),
    );
  }
}

class BasicProfileData1 extends StatelessWidget {
  const BasicProfileData1({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalHelpers.imageFileSwitcher = false;
    return SizedBox(
      child: Center(
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
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Өндөр',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Жин',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Нүдний хараа',
                ),
              ),
            ),

            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){}, child: Text('skip'))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  color: Color(0xFFFF4484)
              ),
              width: 200,
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
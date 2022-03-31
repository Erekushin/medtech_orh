import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../global_constant.dart';
import 'SomeSpecificCards/basic_profile_data1.dart';
import 'SomeSpecificCards/basic_profile_data2.dart';

class BasicPrifileDataCard extends StatefulWidget {
  const BasicPrifileDataCard({Key? key}) : super(key: key);
  @override
  _BasicPrifileDataCardState createState() => _BasicPrifileDataCardState();
}

class _BasicPrifileDataCardState extends State<BasicPrifileDataCard> {
  List<SwipeItem> answercards = <SwipeItem>[];/// Асуултууд бүхий картын List
  MatchEngine? _matchEngine;/// Swipe Card ыг тааруулагч тохиргоо
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<dynamic> MyData = [///Нэмэлт хөгжүүлэлт хийх боломжтой байх үүднээс давхар List ээр дамжуулж байгаа
    new BasicProfileData1(),
    new BasicProfileData2(),
  ];
  @override
  void initState() {
    for (int i = 0; i < MyData.length; i++) {
      answercards.add(SwipeItem(
          content: MyData[i],
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }
    _matchEngine = MatchEngine(swipeItems: answercards);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(///background container
            color: CommonColors.geregeBlue,
            child: Center(
              child: Container(///Картуудыг агуулах Container
                width: size.width * .9,
                height: size.width * 1.1,
                child: SwipeCards(///Картууд
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: size.width * .9,
                        height: size.width * 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: answercards[index].content
                    );
                  },
                  onStackFinished: () {
                    Get.toNamed('/splashScreen ');
                    Get.snackbar('Баяр хүргэе', 'Бүртгэл үүслээ', snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.all(5));
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





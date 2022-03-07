import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';


class MyAppll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Cards Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class AnswerCardInfo{
  AnswerCardInfo({this.shape});
  Widget? shape;
}





class _MyHomePageState extends State<MyHomePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<AnswerCardInfo> MyData = [
    new AnswerCardInfo(shape: TextField()),
    new AnswerCardInfo(shape: Text('dfdf'),),
    new AnswerCardInfo(shape: new Container(width: 100, height: 100, color: Colors.blue,),),
    new AnswerCardInfo(shape: new Container(width: 100, height: 100, color: Colors.blue,),),
  ];
  @override
  void initState() {
    for (int i = 0; i < MyData.length; i++) {
      _swipeItems.add(SwipeItem(
          content: AnswerCardInfo(shape: MyData[i].shape),
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 0.01, //extend the shadow
                      offset: Offset(
                        2.0, // Move to right 10  horizontally
                        2.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ]
                ),
                height: 400,
                width: 300,
                child: SwipeCards(
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: _swipeItems[index].content.shape
                    );
                  },
                  onStackFinished: () {
                    _scaffoldKey.currentState!.showSnackBar(SnackBar(
                      content: Text("Stack Finished"),
                      duration: Duration(milliseconds: 500),
                    ));
                  },
                  itemChanged: (SwipeItem item, int index) {
                    print("item: ${item.content.text}, index: $index");
                    print('item transform it self');
                  },
                  upSwipeAllowed: false,
                  fillSpace: false,
                ),
              ),
            )));
  }
}



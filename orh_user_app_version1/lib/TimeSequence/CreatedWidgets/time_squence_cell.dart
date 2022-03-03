import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../time_sequence.dart';

class TimeSequenceCell extends StatefulWidget {
  TimeSequenceCell({Key? key, required this.CellData}) : super(key: key);
  CellClass? CellData;
  @override
  _TimeSequenceCell createState() => _TimeSequenceCell();
}

class _TimeSequenceCell extends State<TimeSequenceCell> {
  Color CellColor = Color(0xFFE6E7E8);
  @override
  void initState() {
    print('initees');
    if(widget.CellData?.Status == 0){
      CellColor = Color(0xFFE6E7E8);
    }
    else if(widget.CellData?.Status == 1){
      CellColor = Colors.pinkAccent;
    }
    else if(widget.CellData?.Status == 2){
      CellColor = Colors.yellow;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('buildees');
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: CellColor
      ),
    ).ripple((){
      if(widget.CellData?.Status == 0){
        Get.snackbar('Захиалагдсан цаг', 'Энэ цаг дээр эмч өөр өвчтөн дээр цаг товлосон байна!', snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.all(5));
      }
      else if(widget.CellData?.Status == 1){
        Get.snackbar('Цаг захиалах хүсэлт илгээгдлээ', 'Эмч уг хүсэлтийг зөвшөөрөх хүртэл түр хүлээнүү!', snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.all(5));
        setState(() {
          widget.CellData?.Status = 2;
          CellColor = Colors.yellow;
        });
      }
      else if(widget.CellData?.Status == 2){
        Get.snackbar('Таны сонгосон цагийг цуцаллаа', 'Эмчид илгээсэн хүсэлтийг цуцаллаа!', snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.all(5));
        setState(() {
          widget.CellData?.Status = 1;
          CellColor = Colors.pinkAccent;
        });
      }
    });
  }
}
extension OnPressed on Widget {
  Widget ripple(Function onPressed,
      {BorderRadiusGeometry borderRadius =
      const BorderRadius.all(Radius.circular(5))}) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: borderRadius),
                    )),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed();
                  }
                },
                child: Container()),
          )
        ],
      );
}

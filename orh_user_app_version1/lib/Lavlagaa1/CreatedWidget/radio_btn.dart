import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../base_data.dart';


class RadioBtn extends StatelessWidget {
  const RadioBtn({Key? key, required this.w, required this.listitems, this.name}) : super(key: key);
  final double w;
  final List<Views>? listitems;
  final name;
  @override

  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: w / 40, left: 10, right: 10, top: w/40),
        height: listitems!.length * 35 + 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, top: 30, bottom: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(name)),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: listitems!.length * 35 ,
              // color: Colors.red,
              child: ListView.builder(
                  itemCount: listitems?.length,
                  itemBuilder: (BuildContext context, int position){
                    return RadioBtnEach(position);
                  }),
            )
          ],
        )
    );
  }
  Widget RadioBtnEach(int index){
    int Value = 0;
    return Row(

      children: <Widget>[
        Radio(value: Value, groupValue: 1, onChanged: (int? value){
          setState(){
            Value = value!;
          }
        }),
        Text(listitems![index].name!)
      ],
    );
  }
}
// listitems![index].id!;


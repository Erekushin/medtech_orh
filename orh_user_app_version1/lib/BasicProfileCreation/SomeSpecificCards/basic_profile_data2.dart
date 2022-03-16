import 'package:flutter/material.dart';


class BasicProfileData2 extends StatefulWidget {
  const BasicProfileData2({Key? key}) : super(key: key);

  @override
  _BasicProfileData2 createState() => _BasicProfileData2();
}

class _BasicProfileData2 extends State<BasicProfileData2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Column(
                    children: [
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
                  Container(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Naruto ын Fan эсэх',
                      ),
                    ),
                  ),

                  SizedBox(height: 40,),

                ],
              ),

            ],
          )
      ),
    );
  }
}
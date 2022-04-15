import 'package:flutter/material.dart';

import '../../MyWidgets/my_dropdown.dart';


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
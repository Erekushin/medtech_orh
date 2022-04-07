import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
enum SingingCharacter { yes, no }
class MyYesNoRadioBtn extends StatefulWidget {
  const MyYesNoRadioBtn({ Key? key,required this.w, this.listitems, required this.name }) : super(key: key);
  final double w;
  final List? listitems;
  final String name;
  @override
  State<MyYesNoRadioBtn> createState() => _MyYesNoRadioBtnState();
}

class _MyYesNoRadioBtnState extends State<MyYesNoRadioBtn> {
  SingingCharacter? _character;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        height: widget.listitems!.length * 35 + 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myText(widget.name, AllSizes.queryTxtSize, 1),
            ListTile(
          title: myText(SingingCharacter.yes.name.toString(), AllSizes.queryTxtSize, 1),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.yes,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: myText(SingingCharacter.no.name.toString(), AllSizes.queryTxtSize, 1),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.no,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    )
    );
  }
}


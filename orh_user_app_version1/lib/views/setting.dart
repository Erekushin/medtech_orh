import 'package:flutter/material.dart';

import '../MyWidgets/my_dropdown.dart';

class Setting extends StatelessWidget {
  const Setting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
              'Setting',
              style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black.withOpacity(.4),
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
        ),
        body: Column(
          children: [
            Container(
              // child: MyDropdown(dropDownHint: "Хэл Солих", w: 5, listitems: [], currentValue: 5, mark: "",)
            ),
            
          ],
        ),
      ),
    );
  }
}
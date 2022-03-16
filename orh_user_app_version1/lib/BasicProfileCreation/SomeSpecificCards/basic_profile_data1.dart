import 'package:flutter/material.dart';

class BasicProfileData1 extends StatefulWidget {
  const BasicProfileData1({Key? key}) : super(key: key);

  @override
  _BasicProfileData1 createState() => _BasicProfileData1();
}

class _BasicProfileData1 extends State<BasicProfileData1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/user_default.png'),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
              child: TextField(
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
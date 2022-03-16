import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.geregeBlue,
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      bottomNavigationBar: const MyBottomNavBar(),
      body: Stack(
        children: [
          Container(),
          Column(
            children: [
               Container(
                 height: GeneralMeasurements.deviceHeight/4,
                 decoration: BoxDecoration(
                   color: CommonColors.geregeBlue,
                   borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), 
                   bottomRight: Radius.circular(40))
                 ),
               ),
              // GridView(gridDelegate: gridDelegate),
              // Column(
              //   children: [
              //     Text('Doctors'),
              //     PageView.builder(itemBuilder: itemBuilder)
              //   ],
              // )
            ],
          )
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';
import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';
import '../Helpers/CreatedGlobalWidgets/waiting_screen.dart';
import 'CreatedWidget/dropdown.dart';
import 'CreatedWidget/radio_btn.dart';
import 'CreatedWidget/text_input.dart';
import 'base_data.dart';
import 'controller.dart';
import 'model.dart';

class Lavlagaa extends StatefulWidget {
  const Lavlagaa({Key? key}) : super(key: key);
  @override
  _LavlagaaState createState() => _LavlagaaState();
}

class _LavlagaaState extends State<Lavlagaa> {
  form1Controller controller = form1Controller();
  int _radioVal = 0;
  List<Views> hh = [Views(name: "fd"), Views(name: "dfdfd")];
  form1Model model = form1Model();
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (){
        return controller.SaveOnBack(context);
      },
      child: Scaffold(
        bottomNavigationBar: MyBottomNavBar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          shadowColor: Colors.black.withOpacity(.5),
          title: Text(
            'Лавлагаа 1',
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
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FutureBuilder<BaseData>(
              future: controller.getdata(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                    return Text('none');
                  case ConnectionState.active:
                    return Text('active');
                  case ConnectionState.waiting:
                    print('waiting rvv orson');
                    print(snapshot.connectionState);
                    return WaitingScreen();
                  case ConnectionState.done:
                    controller.profession.text = form1Controller.ownData.result?.list?[0].profession ?? "";
                    controller.office.text = form1Controller.ownData.result?.list?[0].office ?? "";
                    controller.position.text = form1Controller.ownData.result?.list?[0].position ?? "";
                    controller.phone.text = form1Controller.ownData.result?.list?[0].phone ?? "";
                    controller.nationality.text = form1Controller.ownData.result?.list?[0].nationality ?? "";
                    controller.number_families.text = form1Controller.ownData.result?.list?[0].numberFamilies ?? "";
                    return Column(
                      children: [
                        MyTextField(w: _w, controller: controller.profession, label: "мэргэжил оруулна уу?", hint: "мэргэжил",),
                        MyTextField(w: _w, controller: controller.office, label: "ажилладаг газрын нэр?", hint: "ажил",),
                        myDropDown(dropDownHint: form1Controller.basedata.result?.items?[6].name??
                            "сонголт байхгүй", w: _w, listitems: form1Controller.basedata.result?.items?[6].views,
                          currentValue: form1Controller.ownData.result?.list?[0].workingConditions, ),
                        MyTextField(w: _w, controller: controller.position, label: "албан тушаал?", hint: "албан тушаал",),
                        MyTextField(w: _w, controller: controller.phone, label: "ажлын утас?", hint: "утас",),
                        myDropDown(dropDownHint: form1Controller.basedata.result?.items?[3].name?? "сонголт байхгүй",
                          w: _w, listitems: form1Controller.basedata.result?.items?[3].views, currentValue: form1Controller.ownData.result?.list?[0].reasonNotEmployment,),
                        myDropDown(dropDownHint: form1Controller.basedata.result?.items?[0].name?? "сонголт байхгүй",
                          w: _w, listitems: form1Controller.basedata.result?.items?[0].views, currentValue: form1Controller.ownData.result?.list?[0].employment,),
                        myDropDown(dropDownHint: form1Controller.basedata.result?.items?[1].name?? "сонголт байхгүй",
                          w: _w, listitems: form1Controller.basedata.result?.items?[1].views, currentValue: form1Controller.ownData.result?.list?[0].educationSituation,),
                        // RadioBtn(w: _w, name: form1Controller.basedata.result?.items?[2].name, listitems: form1Controller.basedata.result?.items?[2].views),
                        myDropDown(dropDownHint: form1Controller.basedata.result?.items?[4].name?? "сонголт байхгүй",
                          w: _w, listitems: form1Controller.basedata.result?.items?[4].views, currentValue: form1Controller.ownData.result?.list?[0].maritalStatus,),
                        MyTextField(w: _w, controller: controller.number_families, label: "гэр бүлийн тоо?", hint: "тоо",),
                        MyTextField(w: _w, controller: controller.nationality, label: "яс үндэс?", hint: "яс үндэс",),
                        // RadioBtn(w: _w, name: form1Controller.basedata.result?.items?[2].name, listitems: form1Controller.basedata.result?.items?[2].views),
                        // RadioBtn(w: _w, name: form1Controller.basedata.result?.items?[2].name, listitems: form1Controller.basedata.result?.items?[2].views),
                        // RadioBtn(w: _w, name: form1Controller.basedata.result?.items?[2].name, listitems: form1Controller.basedata.result?.items?[2].views),
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

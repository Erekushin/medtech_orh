import 'package:flutter/material.dart';

import 'created_widgets.dart';

class SidePageForName extends StatefulWidget {
  const SidePageForName({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  _SidePageForName createState() => _SidePageForName();
}

class _SidePageForName extends State<SidePageForName> {
  String? selectvalCity;
  String? selectvalDistrict;
  String? selectvalCommity;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFEAE9ED),
      child: Container(
        margin: const EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: DropdownButton<String>(
                  hint: const Text("Аймаг сонгох (Хот)"),
                  value: selectvalCity,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectvalCity = newValue.toString();
                    });
                  },
                  underline: const SizedBox(width: 1, height: 1,),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: <String>[
                    'Дархан','Өмнө-Говь','Ховд'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: DropdownButton<String>(
                  hint: const Text("Сум сонгох (Дүүрэг)"),
                  value: selectvalDistrict,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectvalDistrict = newValue.toString();
                    });
                  },
                  underline: const SizedBox(width: 1, height: 1,),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: <String>[
                    'Баянзүрх','Хан-уул','Сонгино хайрхан'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: DropdownButton<String>(
                  hint: const Text("Хороо сонгох"),
                  value: selectvalCommity,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectvalCommity = newValue.toString();
                    });
                  },
                  underline: const SizedBox(height: 1, width: 1,),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  items: <String>[
                    '8-р хороо','24-р хороо','5-р хороо'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),

              hospitalsResultList()
            ],
          ),
        ),
      ),
    );
  }
}

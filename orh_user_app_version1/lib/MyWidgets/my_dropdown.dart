import 'package:flutter/material.dart';

import '../Lavlagaa1/base_data.dart';



class MyDropdown extends StatefulWidget {
  MyDropdown({Key? key, required this.dropDownHint, required this.w, 
  required this.listitems,required this.currentValue, required this.mark}) : super(key: key);
  final String? dropDownHint;
  final double w;
  final List<Views>? listitems;
  final int? currentValue;
  final String? mark;
  @override
  _MyDropDownState createState() => _MyDropDownState();
}
class _MyDropDownState extends State<MyDropdown> {
  @override
  void initState() {
    widget.listitems?.forEach((element) {
      if(element.id == widget.currentValue){
        selectval = element.name;
      }
    });
  }

  void transferDataToModul(){

    // switch(widget.mark){
    //   case "боловсрол байдал":
    //     print("case taarsan");
    //     form1Controller.model.education_situation = SelectedID!;
    //     break;
    //   case "хөдөлмөр эрхлэлтийн байдал":
    //     print("case taarsan");
    //     form1Controller.model.employment = SelectedID!;
    //     break;
    //   case "хөдөлмөр эрхлэхгүй шалтгаан":
    //     print("case taarsan");
    //     form1Controller.model.reason_not_employment = SelectedID!;
    //     break;
    //   case "гэр бүлийн байдал":
    //     print("case taarsan");
    //     form1Controller.model.marital_status = SelectedID!;
    //     break;
    //   case "ажлын нөхцөл":
    //     print("case taarsan");
    //     form1Controller.model.working_condition = SelectedID!;
    //     break;
    // }

  }

  String? selectval;
  int? SelectedID;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 0),
        child: DropdownButton<String>(
          hint: Text(widget.dropDownHint!),
          value: selectval,
          onChanged: (String? newValue) {
            setState(() {
              transferDataToModul();
              selectval = newValue.toString();
            });
          },
          underline: const SizedBox(),
          isExpanded: true,
          borderRadius: BorderRadius.circular(5),
          items: widget.listitems?.map((item){
            return DropdownMenuItem(
                onTap: (){
                  SelectedID = item.id!;
                },
                value: item.name,
                child: Text(item.name!)
            );
          }).toList(),
        ),
    );
  }
}
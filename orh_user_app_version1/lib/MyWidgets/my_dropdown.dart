import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/models/aimags.dart';
import 'my_text.dart';


class MyDropdown extends StatefulWidget {
  MyDropdown({Key? key, required this.dropDownHint,
  required this.listitems,required this.currentValue, 
  required this.mark, required this.givenModelType, 
  required this.margint, required this.marginb, required this.marginr,
  required  this.marginl}) : super(key: key);
  final String? dropDownHint;
  final List<dynamic>? listitems;
  final int? currentValue;
  final String? mark;
  final Type givenModelType;
  final double margint;
  final double marginb;
  final double marginr;
  final double marginl;
  @override
  _MyDropDownState createState() => _MyDropDownState();
}
class _MyDropDownState extends State<MyDropdown> {
  @override
  void initState() {
    // widget.listitems?.forEach((element) {
    //   if(element.id == widget.currentValue){
    //     selectval = element.name;
    //   }
    // });
    selectval = null;
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
    List<Aimags> aimagList = [];
    List<Sums> sumList = [];
    List<DropdownMenuItem<String>> Dropitems(){
      switch(widget.givenModelType){
        default: return [];
      }
    }
    switch(widget.givenModelType){
      case Aimags:
        aimagList = List<Aimags>.from(widget.listitems!);
        break;
      case Sums:
        sumList = List<Sums>.from(widget.listitems!);  
    }
    return Container(
      margin: EdgeInsets.only(left: widget.marginl, right: widget.marginr, 
                              top: widget.margint, bottom: widget.marginb),
        child: DropdownButton<String>(
          hint: myText(widget.dropDownHint!, 16, 2),
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
          items: Dropitems()
        ),
    );
  }
}



import 'package:flutter/material.dart';
import '../base_data.dart';
import '../controller.dart';

class myDropDown extends StatefulWidget {
  const myDropDown({Key? key, required this.dropDownHint, required this.w, required this.listitems,required this.currentValue}) : super(key: key);
  final String? dropDownHint;
  final double w;
  final List<Views>? listitems;
  final int? currentValue;
  @override
  _DropDownState createState() => _DropDownState();
}
class _DropDownState extends State<myDropDown> {
  @override
  void initState() {
    widget.listitems?.forEach((element) {
      if(element.id == widget.currentValue){
        selectval = element.name;
      }
    });
  }

  void transferDataToModul(){
    switch(widget.dropDownHint){
      case "боловсрол байдал":
        print("case taarsan");
        form1Controller.model.education_situation = SelectedID!;
        break;
      case "хөдөлмөр эрхлэлтийн байдал":
        print("case taarsan");
        form1Controller.model.employment = SelectedID!;
        break;
      case "хөдөлмөр эрхлэхгүй шалтгаан":
        print("case taarsan");
        form1Controller.model.reason_not_employment = SelectedID!;
        break;
      case "гэр бүлийн байдал":
        print("case taarsan");
        form1Controller.model.marital_status = SelectedID!;
        break;
      case "ажлын нөхцөл":
        print("case taarsan");
        form1Controller.model.working_condition = SelectedID!;
        break;
    }

  }

  String? selectval;
  int? SelectedID;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: widget.w / 40, left: 10, right: 10, top: widget.w/40),
        height: widget.w / 4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButton<String>(
          hint: Text(widget.dropDownHint!),
          value: selectval,
          onChanged: (String? newValue) {
            setState(() {
              transferDataToModul();
              selectval = newValue.toString();
            });
          },
          underline: SizedBox(),
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
        )
    );
  }
}
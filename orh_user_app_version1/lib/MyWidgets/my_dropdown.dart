import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Controllers/query_controller.dart';
import '../models/childHeartQueryRelated/childheartquey.dart';
import 'my_text.dart';
import 'package:get/get.dart';


class MyDropdown extends StatefulWidget {
  MyDropdown({Key? key, required this.dropDownHint,
  required this.listitems,required this.currentValue, 
  required this.mark, required this.givenModelType, 
  required this.margint, required this.marginb, required this.marginr,
  required  this.marginl, this.questionID, required this.answerIndex}) : super(key: key);
  final String? dropDownHint;
  final List<Options>? listitems;
  final int? questionID;
  final int? currentValue;
  final String? mark;
  final Type givenModelType;
  final double margint;
  final double marginb;
  final double marginr;
  final double marginl;
  final int answerIndex;
  @override
  _MyDropDownState createState() => _MyDropDownState();
}
class _MyDropDownState extends State<MyDropdown> {
  final queryController = Get.find<SurveyController>();
  @override
  void initState() {
    // widget.listitems?.forEach((element) {
    //   if(element.id == widget.currentValue){
    //     selectval = element.name;
    //   }
    // });
    // queryController.dropvalueList[widget.answerIndex].value  =  null;
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

  // String? selectval;
  int? SelectedID;
  @override
  Widget build(BuildContext context) {
    // switch(widget.givenModelType){
    //   case Options:
    //     otionList = List<Options>.from(widget.listitems!);
    //     break;  
    // }
    List<DropdownMenuItem<String>> dropitems(List<Options> otionList){
      switch(widget.givenModelType){
        case Options:
         return otionList.map((item){
           return DropdownMenuItem(
             value: item.id.toString(),
             child: Text(item.optionText!),
             onTap: (){
               queryController.queryAnswer.answers![widget.answerIndex].questionId = widget.questionID;
               queryController.queryAnswer.answers![widget.answerIndex].optionId = item.id; 
             },
             );
           }).toList();
        default: return const [DropdownMenuItem(child: Text('Хоосон утга'))] ;   
      }
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        margin: EdgeInsets.only(left: widget.marginl, right: widget.marginr, 
                              top: widget.margint, bottom: widget.marginb),
        padding: const EdgeInsets.only(left: 10, right: 0, top:5, bottom: 0),                      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myText(widget.dropDownHint!, 11, 1, FontWeight.bold),
            DropdownButton<String>(
          hint: myText(widget.dropDownHint?? '', 16, 1),
          value: queryController.dropvalueList[widget.answerIndex].value,
          onChanged: (String? newValue) {
            setState(() {
              transferDataToModul();
              queryController.dropvalueList[widget.answerIndex].value = newValue.toString();
            });
          },
          underline: const SizedBox(),
          isExpanded: true,
          borderRadius: BorderRadius.circular(5),
          items: dropitems(widget.listitems!)
        )
          ],
        ),
    );
  }
}



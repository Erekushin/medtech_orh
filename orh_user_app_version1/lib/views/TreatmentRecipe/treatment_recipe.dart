import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../../Controllers/sql_controller.dart';
import '../../Helpers/logging.dart';
import '../../Models/TreatmentRecipe/treatment_recipe.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TreatmentRecipe extends StatefulWidget {
  const TreatmentRecipe({ Key? key }) : super(key: key);

  @override
  State<TreatmentRecipe> createState() => _TreatmentRecipeState();
}

class _TreatmentRecipeState extends State<TreatmentRecipe> {
  var sqlController = Get.find<SqlController>();
  var recipeTextController = TextEditingController();
  final log = logger(TreatmentRecipe);
  bool isLoading = false;
  int recipeFormColor = 0xFFFFFFFF;
  bool red = false;
  bool orange = false;
  bool blue = false;
  bool purple = false;
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
   Future addNote() async {
    final recipe = Recipies(
      text: recipeTextController.text,
      color: recipeFormColor,
      title: '',
      dateStart: currentDate.toString(),
      dateEnd: selectedDate.toString(),
      picture: '',
      personId: ''
    );
    await sqlController.create(recipe);
  }

  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white24,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            shadowColor: Colors.black.withOpacity(.5),
            title: Text(
              'Жор',
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
        body: Stack(
          children: [
            GetX<SqlController>(builder: (sqlControllerBuilder){
              return Container(
          height: GeneralMeasurements.deviceHeight*.8,
          margin: const EdgeInsets.all(12),
          child:  MasonryGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              itemCount: sqlControllerBuilder.recipeList.value!.length,
              itemBuilder: (context, index) {
                final item = sqlControllerBuilder.recipeList.value![index];
                return Container(
                  padding:  const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(item.color!),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(15))
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                        width: 100,
                        child: Text(item.text.toString())
                        ), 
                        Column(
                          children: [
                            Text(item.dateStart.toString().substring(5,10)),
                            const Text('|'),
                            const Text('v'),
                            Text(item.dateEnd.toString().substring(5,10)),
                          ],
                        )
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('дотор'), CircleAvatar()],
                        )
                    ],
                  )
                );
              },
              ),
        );
            }),
        Container(
          margin: const EdgeInsets.only(bottom: 80, right: 20),
          child: Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: (){
                recipeFormColor = 0xFFFFFFFF;
                blue =false;
                red = false;
                purple = false;
                orange = false;
                selectedDate = DateTime.now();
                showDialog(
                  context: context,
                  builder: (context)=> SingleChildScrollView(
                      child: StatefulBuilder(
                        builder: (contextt, setState) => AlertDialog(
                          backgroundColor: Color(recipeFormColor),
                    shape: RoundedRectangleBorder(
		                  borderRadius: BorderRadius.circular(30),
	                  ),
                    title: const Text('Шинэ тэмдэглэл'),
                    content: SizedBox(
                    height: GeneralMeasurements.deviceHeight*.71,
                    child: Column(
                    children: [
                      Container(
                        height: GeneralMeasurements.deviceHeight*.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: TextField(
                          controller: recipeTextController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                        ),
                        )
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(currentDate.toString().substring(5,10)),
                            const Text('-->'),
                            Text(selectedDate.toString().substring(5,10)),
                            InkWell(
                              onTap: () async{
                                 final DateTime? picked = await showDatePicker(
                                 context: context,
                                 initialDate: selectedDate,
                                 initialDatePickerMode: DatePickerMode.day,
                                 firstDate: DateTime(2015),
                                 lastDate: DateTime(2101));
                                 if (picked != null) {
                                 setState(() {
                                   selectedDate = picked;
                                 });
                                }
                              },
                              child: myBtn(CommonColors.geregeBlue, 50, 30, CommonColors.geregeBlue, Colors.white, 'огноо'),
                            )
                          ],
                        ),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ 
                             InkWell(
                              onTap: (){
                                setState((){recipeFormColor = 0xFF2979FF;  blue = true;
                                red = false;
                                purple = false;
                                orange = false;
                                });
                              },
                              child: Container(
                                 margin: const EdgeInsets.all(5),
                                 width: 30,
                                 height: 30,
                                 decoration: const BoxDecoration(
                                 color: Colors.blue,
                                 shape: BoxShape.circle
                                 ),
                                 child:  Visibility(
                                  visible: blue,
                                  child: Icon(
                                    Icons.check,
                                    size: GeneralMeasurements.deviceHeight/100*4,
                                    color: Colors.green,
                                  ),
                                 )
                               ),
                            ),
                             InkWell(
                              onTap: (){
                                setState((){recipeFormColor = 0xFFE040FB; purple = true;
                                red = false;
                                blue = false;
                                orange = false;});
                              },
                              child: Container(
                                 margin: const EdgeInsets.all(5),
                                 width: 30,
                                 height: 30,
                                 decoration: const BoxDecoration(
                                 color: Colors.purple,
                                 shape: BoxShape.circle
                                 ),
                                 child:  Visibility(
                                  visible: purple,
                                  child: Icon(
                                    Icons.check,
                                    size: GeneralMeasurements.deviceHeight/100*4,
                                    color: Colors.green,
                                  ),
                                 )
                               ),
                            ),
                             InkWell(
                              onTap: (){
                                setState((){recipeFormColor = 0xFFFF5252; red = true;
                                purple = false;
                                blue = false;
                                orange = false;});
                              },
                              child: Container(
                                 margin: const EdgeInsets.all(5),
                                 width: 30,
                                 height: 30,
                                 decoration: const BoxDecoration(
                                 color: Colors.red,
                                 shape: BoxShape.circle
                                 ),
                                 child:  Visibility(
                                  visible: red,
                                  child: Icon(
                                    Icons.check,
                                    size: GeneralMeasurements.deviceHeight/100*4,
                                    color: Colors.green,
                                  ),
                                 )
                               ),
                            ),
                             InkWell(
                              onTap: (){
                                setState((){recipeFormColor = 0xFFFFAB40; orange = true;
                                red = false;
                                blue = false;
                                purple = false;});
                              },
                              child: Container(
                                 margin: const EdgeInsets.all(5),
                                 width: 30,
                                 height: 30,
                                 decoration: const BoxDecoration(
                                 color: Colors.orange,
                                 shape: BoxShape.circle
                                 ),
                                 child:  Visibility(
                                  visible: orange,
                                  child: Icon(
                                    Icons.check,
                                    size: GeneralMeasurements.deviceHeight/100*4,
                                    color: Colors.green,
                                  ),
                                 )
                               ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                           if(recipeTextController.text != ''){
                          addNote();
                          recipeTextController.clear();
                          sqlController.readAllNotes();
                        }
                        Navigator.pop(context, true);
                        },
                        child: myBtn(CommonColors.geregeBlue, 100, 30, CommonColors.geregeBlue, Colors.white, 'Хадаглах'),)
                      ],
                  ),
                  ),
                  
                  ),
                      )
                    )
                );
                // addNote();
              },
              child: myBtn(CommonColors.geregeBlue, 50, 50, CommonColors.geregeBlue, Colors.white, '+')
              )
              ),
        ),
          ],
        ),
      ),
    );
  }
}

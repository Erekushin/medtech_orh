import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import '../../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../../MyWidgets/my_button.dart';
import '../../../global_constant.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
// ignore: implementation_imports, library_prefixes
import 'package:flutter_treeview/src/models/node.dart' as treeChild;
import 'package:flutter/cupertino.dart';


class SurveyInfoCheck extends StatefulWidget {
  const SurveyInfoCheck({ Key? key }) : super(key: key);

  @override
  State<SurveyInfoCheck> createState() => _SurveyInfoCheckState();
}

class _SurveyInfoCheckState extends State<SurveyInfoCheck> {
  var sCCont = Get.find<CreationCont>();
  var loginController = Get.find<AuthController>();
  late TreeViewController treVCont;
  late List<treeChild.Node> _nodes;
  String? _selectedNode;
  bool docsOpen = false;
  ExpanderType _expanderType = ExpanderType.caret;
  ExpanderModifier _expanderModifier = ExpanderModifier.none;
  ExpanderPosition _expanderPosition = ExpanderPosition.start;
  @override
  void initState() {
    super.initState();
     _nodes = [
      treeChild.Node(
        label: 'documents',
        key: 'docs',
        expanded: docsOpen,
        icon: docsOpen ? Icons.folder_open : Icons.folder,
        children: [
          treeChild.Node(
            label: 'personal',
            key: 'd3',
            icon: Icons.input,
            iconColor: Colors.red,
            children: [
              treeChild.Node(
                label: 'Poems.docx',
                key: 'pd1',
                icon: Icons.insert_drive_file,
              ),
            ],
          ),
        ],
      ),
    ];
     treVCont = TreeViewController(
      children: _nodes,
      selectedKey: _selectedNode,
    );
  }
  @override
  Widget build(BuildContext context) {
      TreeViewTheme _treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
          type: _expanderType,
          modifier: _expanderModifier,
          position: _expanderPosition,
          // color: Colors.grey.shade800,
          size: 20,
          color: Colors.blue),
      labelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w800,
        color: Colors.blue.shade700,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                const SizedBox(height:40,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны нэр:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 160,
                    child: myText(sCCont.surveyNametxtCont.text == ''? 
                          'Нэр оруулаагүй байна':sCCont.surveyNametxtCont.text, 15, 1),
                  )
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('огноо:  ', 15, 1, (FontWeight.bold)),
                  myText(sCCont.surveyCreationbody.surveyCreatedDate, 15, 1),
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны тоо:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 150,
                    child: myText(sCCont.counttypeStr?? 'тооны төрлийг сонгоогүй байна.', 15, 1))
                ],),
                 const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Судалгааны төрөл:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 150,
                    child: myText(sCCont.torolStr?? 'төрлийг сонгоогүй байна.', 15, 1))
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Privacy level:  ', 15, 1, (FontWeight.bold)),
                  SizedBox(
                    width: 200,
                    child: myText(sCCont.levelStr?? 'Нууцлалын түвшинг сонгоогүй байна', 15, 1))
                ],),
                const SizedBox(height: 20,),
                Row(children: [
                  const SizedBox(width: 20,),
                  myText('Асуултын тоо:  ', 15, 1, (FontWeight.bold)),
                  myText(sCCont.newQuestionList.length.toString(), 15, 1),
                ],),
                const SizedBox(height: 20,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('Тусгай асуултын тоо:  ', 15, 1, (FontWeight.bold)),
                  myText(sCCont.toolQuestionCount.value.toString(), 15, 1),
                ],),
                 const SizedBox(height: 20,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('судалгааны арын өнгө:  ', 15, 1, (FontWeight.bold)),
                  Container(
                       margin: const EdgeInsets.all(5),
                       width: 30,
                       height: 30,
                       decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                       color: Color(int.parse(sCCont.surveyCreationbody.surveyClr?? '0xFFFFFFFF')),
                       shape: BoxShape.circle
                         ),
                       ),
                ],),
                 const SizedBox(height: 20,),
                 Row(children: [
                   const SizedBox(width: 20,),
                  myText('Зураглал харах: ', 15, 1, (FontWeight.bold)),
                  TextButton(
                        onPressed: (){
                          
                        //  showDialog(context: context, builder: (context) => SingleChildScrollView(
                        //   child: StatefulBuilder(
                        //     builder: (contextt, setState) => AlertDialog(
                        //       backgroundColor: Colors.white,
                        //       shape: RoundedRectangleBorder(
		                    //         borderRadius: BorderRadius.circular(30),
	                      //       ),
                        //       title: const Text('Зураглал'),
                        //       content: Container(
                        //            color: Colors.white,
                        //            width: GeneralMeasurements.deviceWidth*.8,
                        //            height: GeneralMeasurements.deviceHeight*.6,
                        //            child: TreeView(
                        //              controller: treVCont,
                        //              onNodeDoubleTap: (string){
                        //               print('object');
                        //              },
                        //               onNodeTap: (key) {
                        //                  debugPrint('Selected: $key');
                        //                  setState(() {
                        //                   docsOpen = true;
                        //                    _selectedNode = key;
                        //                    treVCont =
                        //                        treVCont.copyWith(selectedKey: key);
                        //                  });
                        //                },
                        //                theme: _treeViewTheme,
                        //            ),
                        //            )
                        //     ),
                        //   ),
                        //  ));
                        },
                        child: const Text('харах'),
                      ),
                ],)
                  ],
                ),
                Column(
                  children: [
              InkWell(
                onTap: (){
                  sCCont.surveyCreate("variationup");
                },
                child: myBtn(CommonColors.deepPink, 200, 50, CommonColors.deepPink, Colors.white, 'Хувилбар нэмэх'),
              ),
              InkWell(
                onTap: (){
                  sCCont.surveyCreate("levelup");
                },
                child: myBtn(CommonColors.geregeBlue, 200, 50, CommonColors.geregeBlue, Colors.white, 'Дараагийн шат'),
              ),
              InkWell(
                onTap: (){
                  sCCont.surveyCreate("save");
                },
                child: myBtn(CommonColors.yellow, 200, 50, CommonColors.yellow, Colors.white, 'Судалгааг хадаглах'),
              ),
              const SizedBox(height: 20,)
                  ],
                ),
              ],
            );
  }
}







// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TreeView Example',
//       home: MyHomePage(title: 'TreeView Example'),
//       theme: ThemeData().copyWith(
//         accentColor: Colors.deepPurple,
//         hoverColor: Colors.red.shade100,
//         colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.red),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _selectedNode;
//   List<Node> _nodes;
//   TreeViewController _treeViewController;
//   bool docsOpen = true;
//   bool deepExpanded = true;
//   final Map<ExpanderPosition, Widget> expansionPositionOptions = const {
//     ExpanderPosition.start: Text('Start'),
//     ExpanderPosition.end: Text('End'),
//   };
//   final Map<ExpanderType, Widget> expansionTypeOptions = {
//     ExpanderType.none: Container(),
//     ExpanderType.caret: Icon(
//       Icons.arrow_drop_down,
//       size: 28,
//     ),
//     ExpanderType.arrow: Icon(Icons.arrow_downward),
//     ExpanderType.chevron: Icon(Icons.expand_more),
//     ExpanderType.plusMinus: Icon(Icons.add),
//   };
//   final Map<ExpanderModifier, Widget> expansionModifierOptions = const {
//     ExpanderModifier.none: ModContainer(ExpanderModifier.none),
//     ExpanderModifier.circleFilled: ModContainer(ExpanderModifier.circleFilled),
//     ExpanderModifier.circleOutlined:
//         ModContainer(ExpanderModifier.circleOutlined),
//     ExpanderModifier.squareFilled: ModContainer(ExpanderModifier.squareFilled),
//     ExpanderModifier.squareOutlined:
//         ModContainer(ExpanderModifier.squareOutlined),
//   };
//   ExpanderPosition _expanderPosition = ExpanderPosition.start;
//   ExpanderType _expanderType = ExpanderType.caret;
//   ExpanderModifier _expanderModifier = ExpanderModifier.none;
//   bool _allowParentSelect = false;
//   bool _supportParentDoubleTap = false;

//   @override
//   void initState() {
//     _nodes = [
//       Node(
//         label: 'documents',
//         key: 'docs',
//         expanded: docsOpen,
//         icon: docsOpen ? Icons.folder_open : Icons.folder,
//         children: [
//           Node(
//             label: 'personal',
//             key: 'd3',
//             icon: Icons.input,
//             iconColor: Colors.red,
//             children: [
//               Node(
//                 label: 'Poems.docx',
//                 key: 'pd1',
//                 icon: Icons.insert_drive_file,
//               ),
//               Node(
//                 label: 'Job Hunt',
//                 key: 'jh1',
//                 icon: Icons.input,
//                 children: [
//                   Node(
//                     label: 'Resume.docx',
//                     key: 'jh1a',
//                     icon: Icons.insert_drive_file,
//                   ),
//                   Node(
//                     label: 'Cover Letter.docx',
//                     key: 'jh1b',
//                     icon: Icons.insert_drive_file,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Node(
//             label: 'Inspection.docx',
//             key: 'd1',
// //          icon: Icons.insert_drive_file),
//           ),
//           Node(label: 'Invoice.docx', key: 'd2', icon: Icons.insert_drive_file),
//         ],
//       ),
//       Node(
//           label: 'MeetingReport.xls',
//           key: 'mrxls',
//           icon: Icons.insert_drive_file),
//       Node(
//           label: 'MeetingReport.pdf',
//           key: 'mrpdf',
//           iconColor: Colors.green.shade300,
//           selectedIconColor: Colors.white,
//           icon: Icons.insert_drive_file),
//       Node(label: 'Demo.zip', key: 'demo', icon: Icons.archive),
//       Node(
//         label: 'empty folder',
//         key: 'empty',
//         parent: true,
//       ),
//     ];
//     _treeViewController = TreeViewController(
//       children: _nodes,
//       selectedKey: _selectedNode,
//     );

//     super.initState();
//   }

//   ListTile _makeExpanderPosition() {
//     return ListTile(
//       title: Text('Expander Position'),
//       dense: true,
//       trailing: CupertinoSlidingSegmentedControl(
//         children: expansionPositionOptions,
//         groupValue: _expanderPosition,
//         onValueChanged: (ExpanderPosition newValue) {
//           setState(() {
//             _expanderPosition = newValue;
//           });
//         },
//       ),
//     );
//   }

//   SwitchListTile _makeAllowParentSelect() {
//     return SwitchListTile.adaptive(
//       title: Text('Allow Parent Select'),
//       dense: true,
//       value: _allowParentSelect,
//       onChanged: (v) {
//         setState(() {
//           _allowParentSelect = v;
//         });
//       },
//     );
//   }

//   SwitchListTile _makeSupportParentDoubleTap() {
//     return SwitchListTile.adaptive(
//       title: Text('Support Parent Double Tap'),
//       dense: true,
//       value: _supportParentDoubleTap,
//       onChanged: (v) {
//         setState(() {
//           _supportParentDoubleTap = v;
//         });
//       },
//     );
//   }

//   ListTile _makeExpanderType() {
//     return ListTile(
//       title: Text('Expander Style'),
//       dense: true,
//       trailing: CupertinoSlidingSegmentedControl(
//         children: expansionTypeOptions,
//         groupValue: _expanderType,
//         onValueChanged: (ExpanderType newValue) {
//           setState(() {
//             _expanderType = newValue;
//           });
//         },
//       ),
//     );
//   }

//   ListTile _makeExpanderModifier() {
//     return ListTile(
//       title: Text('Expander Modifier'),
//       dense: true,
//       trailing: CupertinoSlidingSegmentedControl(
//         children: expansionModifierOptions,
//         groupValue: _expanderModifier,
//         onValueChanged: (ExpanderModifier newValue) {
//           setState(() {
//             _expanderModifier = newValue;
//           });
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     TreeViewTheme _treeViewTheme = TreeViewTheme(
//       expanderTheme: ExpanderThemeData(
//           type: _expanderType,
//           modifier: _expanderModifier,
//           position: _expanderPosition,
//           // color: Colors.grey.shade800,
//           size: 20,
//           color: Colors.blue),
//       labelStyle: TextStyle(
//         fontSize: 16,
//         letterSpacing: 0.3,
//       ),
//       parentLabelStyle: TextStyle(
//         fontSize: 16,
//         letterSpacing: 0.1,
//         fontWeight: FontWeight.w800,
//         color: Colors.blue.shade700,
//       ),
//       iconTheme: IconThemeData(
//         size: 18,
//         color: Colors.grey.shade800,
//       ),
//       colorScheme: Theme.of(context).colorScheme,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         elevation: 0,
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: Container(
//           padding: EdgeInsets.all(20),
//           height: double.infinity,
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 160,
//                 child: Column(
//                   children: <Widget>[
//                     _makeExpanderPosition(),
//                     _makeExpanderType(),
//                     _makeExpanderModifier(),
// //                    _makeAllowParentSelect(),
// //                    _makeSupportParentDoubleTap(),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: EdgeInsets.all(10),
//                   child: TreeView(
//                     controller: _treeViewController,
//                     allowParentSelect: _allowParentSelect,
//                     supportParentDoubleTap: _supportParentDoubleTap,
//                     onExpansionChanged: (key, expanded) =>
//                         _expandNode(key, expanded),
//                     onNodeTap: (key) {
//                       debugPrint('Selected: $key');
//                       setState(() {
//                         _selectedNode = key;
//                         _treeViewController =
//                             _treeViewController.copyWith(selectedKey: key);
//                       });
//                     },
//                     theme: _treeViewTheme,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   debugPrint('Close Keyboard');
//                   FocusScope.of(context).unfocus();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.only(top: 20),
//                   alignment: Alignment.center,
//                   child: Text(_treeViewController.getNode(_selectedNode) == null
//                       ? ''
//                       : _treeViewController.getNode(_selectedNode).label),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         top: false,
//         child: ButtonBar(
//           alignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             CupertinoButton(
//               child: Text('Node'),
//               onPressed: () {
//                 setState(() {
//                   _treeViewController = _treeViewController.copyWith(
//                     children: _nodes,
//                   );
//                 });
//               },
//             ),
//             CupertinoButton(
//               child: Text('JSON'),
//               onPressed: () {
//                 setState(() {
//                   _treeViewController =
//                       _treeViewController.loadJSON(json: US_STATES_JSON);
//                 });
//               },
//             ),
// //            CupertinoButton(
// //              child: Text('Toggle'),
// //              onPressed: _treeViewController.selectedNode != null &&
// //                      _treeViewController.selectedNode.isParent
// //                  ? () {
// //                      setState(() {
// //                        _treeViewController = _treeViewController
// //                            .withToggleNode(_treeViewController.selectedKey);
// //                      });
// //                    }
// //                  : null,
// //            ),
//             CupertinoButton(
//               child: Text('Deep'),
//               onPressed: () {
//                 String deepKey = 'jh1b';
//                 setState(() {
//                   if (deepExpanded == false) {
//                     List<Node> newdata =
//                         _treeViewController.expandToNode(deepKey);
//                     _treeViewController =
//                         _treeViewController.copyWith(children: newdata);
//                     deepExpanded = true;
//                   } else {
//                     _treeViewController =
//                         _treeViewController.withCollapseToNode(deepKey);
//                     deepExpanded = false;
//                   }
//                 });
//               },
//             ),
//             CupertinoButton(
//               child: Text('Edit'),
//               onPressed: () {
//                 TextEditingController editingController = TextEditingController(
//                     text: _treeViewController.selectedNode.label);
//                 showCupertinoDialog(
//                     context: context,
//                     builder: (context) {
//                       return CupertinoAlertDialog(
//                         title: Text('Edit Label'),
//                         content: Container(
//                           height: 80,
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.all(10),
//                           child: CupertinoTextField(
//                             controller: editingController,
//                             autofocus: true,
//                           ),
//                         ),
//                         actions: <Widget>[
//                           CupertinoDialogAction(
//                             child: Text('Cancel'),
//                             isDestructiveAction: true,
//                             onPressed: () => Navigator.of(context).pop(),
//                           ),
//                           CupertinoDialogAction(
//                             child: Text('Update'),
//                             isDefaultAction: true,
//                             onPressed: () {
//                               if (editingController.text.isNotEmpty) {
//                                 setState(() {
//                                   Node _node = _treeViewController.selectedNode;
//                                   _treeViewController =
//                                       _treeViewController.withUpdateNode(
//                                           _treeViewController.selectedKey,
//                                           _node.copyWith(
//                                               label: editingController.text));
//                                 });
//                                 debugPrint(editingController.text);
//                               }
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _expandNode(String key, bool expanded) {
//     String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
//     debugPrint(msg);
//     Node node = _treeViewController.getNode(key);
//     if (node != null) {
//       List<Node> updated;
//       if (key == 'docs') {
//         updated = _treeViewController.updateNode(
//             key,
//             node.copyWith(
//               expanded: expanded,
//               icon: expanded ? Icons.folder_open : Icons.folder,
//             ));
//       } else {
//         updated = _treeViewController.updateNode(
//             key, node.copyWith(expanded: expanded));
//       }
//       setState(() {
//         if (key == 'docs') docsOpen = expanded;
//         _treeViewController = _treeViewController.copyWith(children: updated);
//       });
//     }
//   }
// }

// class ModContainer extends StatelessWidget {
//   final ExpanderModifier modifier;

//   const ModContainer(this.modifier, {Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double _borderWidth = 0;
//     BoxShape _shapeBorder = BoxShape.rectangle;
//     Color _backColor = Colors.transparent;
//     Color _backAltColor = Colors.grey.shade700;
//     switch (modifier) {
//       case ExpanderModifier.none:
//         break;
//       case ExpanderModifier.circleFilled:
//         _shapeBorder = BoxShape.circle;
//         _backColor = _backAltColor;
//         break;
//       case ExpanderModifier.circleOutlined:
//         _borderWidth = 1;
//         _shapeBorder = BoxShape.circle;
//         break;
//       case ExpanderModifier.squareFilled:
//         _backColor = _backAltColor;
//         break;
//       case ExpanderModifier.squareOutlined:
//         _borderWidth = 1;
//         break;
//     }
//     return Container(
//       decoration: BoxDecoration(
//         shape: _shapeBorder,
//         border: _borderWidth == 0
//             ? null
//             : Border.all(
//                 width: _borderWidth,
//                 color: _backAltColor,
//               ),
//         color: _backColor,
//       ),
//       width: 15,
//       height: 15,
//     );
//   }
// }

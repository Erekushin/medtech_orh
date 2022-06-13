import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
/// Package import
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class SurveyResponses extends StatefulWidget {
  const SurveyResponses({ Key? key }) : super(key: key);

  @override
  State<SurveyResponses> createState() => _SurveyResponsesState();
}

class _SurveyResponsesState extends State<SurveyResponses> {
  var surveyCont = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: [
           Stack(
        children: [
          ListView.builder(
      itemCount: surveyCont.surveyResponses.result?.length?? 0,
      itemBuilder: (c, i){
        var item = surveyCont.surveyResponses.result![i];
        String? c = item.creartedDate;
        String? n =item.researcherName;
        return Container(
                  margin: EdgeInsets.all(GeneralMeasurements.deviceWidth*.02),
                  height: GeneralMeasurements.deviceHeight*.08,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff040039).withOpacity(.15),
                      blurRadius: 99,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          surveyCont.responseAnswersGet(c!);
                        },
                        child: SizedBox(
                                          width: GeneralMeasurements.deviceWidth*.7,
                                          child: myText('$c $n', 17, 1, FontWeight.w700),
                                        ),
                      )
                    ],
                  )
            ); 
      },
    ),
     Visibility(
                visible: surveyCont.surveyResponses.result == null? true : false,
                child: Image.asset('assets/images/empty_box.jpg')
                )
        ],
      ),
          //  const ResponsesStatistic()
        ],
      ) 

     );
  }
}








// class ResponsesStatistic extends StatefulWidget {
//   const ResponsesStatistic({Key? key}) : super(key: key);

//   @override
//   _ResponsesStatisticState createState() => _ResponsesStatisticState();
// }

// class _ResponsesStatisticState extends State<ResponsesStatistic> {
//   var sCont = Get.find<SurveyController>();
// List<double> firstDots = [];
// Map _data1 = <double, double>{};
//    GlobalKey<ScaffoldState> sidePageKey = GlobalKey<ScaffoldState>();
//    static bool _showGrid = true;
//   static bool _isCurved = false;
//   static bool _showBelowArea = false;
//   static bool _showDot = true;
//   static bool _showBorder = true;

//   // late double minXvalue;
//   // double maxXvalue = 0;
//   late double minYvalue;
//   double maxYvalue = 0;
//   var spots1;
//   @override
//   void initState() {
//     super.initState();
//       minYvalue = sCont.statisticAnswer.result![0].answers![0].numberAnswer!.toDouble();
//       for(int a = 0; a<sCont.statisticAnswer.result!.length; a++){
//       firstDots.add(sCont.statisticAnswer.result![a].answers![0].numberAnswer!.toDouble());
//       if(sCont.statisticAnswer.result![a].answers![0].numberAnswer! > maxYvalue){
//         maxYvalue = sCont.statisticAnswer.result![a].answers![0].numberAnswer!.toDouble();
//       }
//       if(sCont.statisticAnswer.result![a].answers![0].numberAnswer! < minYvalue){
//         minYvalue = sCont.statisticAnswer.result![a].answers![0].numberAnswer!.toDouble();
//       }
//     }
//     _data1 = firstDots.asMap();
//     spots1 = <FlSpot>[
//       for (final entry in _data1.entries) FlSpot(entry.key.toDouble(), entry.value)
//     ];
//   }
//   @override
//   Widget build(BuildContext context) {
//     final lineChartData = LineChartData(
//       minX: 0,
//       maxX: 5,
//       minY: minYvalue,
//       maxY: maxYvalue,
//       lineBarsData: [
//         LineChartBarData(
//           spots: spots1,
//           color: Colors.purple,
//           barWidth: 4,
//           isCurved: _isCurved,
//           dotData: FlDotData(show: _showDot),
//           belowBarData:
//               BarAreaData(show: _showBelowArea, color: Colors.blue[200]),
//         ),
//       ],
//       lineTouchData: LineTouchData(
//         touchTooltipData: LineTouchTooltipData(
//           tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
//         ),
//         touchCallback: (_, __) {},
//         handleBuiltInTouches: true,
//       ),
//       borderData: FlBorderData(
//         show: _showBorder,
//         border: const Border(
//           bottom: BorderSide(color: Colors.greenAccent, width: 4),
//           left: BorderSide(color: Colors.transparent),
//           right: BorderSide(color: Colors.transparent),
//           top: BorderSide(color: Colors.transparent),
//         ),
//       ),
//       gridData: FlGridData(show: _showGrid),
//       // ! Title and ticks in the axis
//       titlesData: FlTitlesData(
//         rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//         topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             reservedSize: 22,
//             showTitles: true,
//             getTitlesWidget: (double val, _){
//               int indx;
//               if((val * 10 %10) == 0){
//                 indx = val.toInt();
//               }
//               else{
//                 indx = 0;
//               }
//               switch(val.toInt()){
//                 case 0:
//                 return const Text('none');
//                 case 1:
//                 return Text(sCont.surveyResponses.result![indx].creartedDate.toString().substring(6,11));
//                 case 2:
//                 return Text(sCont.surveyResponses.result![indx].creartedDate.toString().substring(6,11));
//                 case 3:
//                 return Text(sCont.surveyResponses.result![indx].creartedDate.toString().substring(6,11));
//                 case 4:
//                 return Text(sCont.surveyResponses.result![indx].creartedDate.toString().substring(6,11));
//                 case 5:
//                 return Text(sCont.surveyResponses.result![indx].creartedDate.toString().substring(6,11));
//               }
//               return Text('');
//             }
                
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: (double val, _) {
//               if((val * 10 %10) == 0){
//                 var a = val.toInt();
//                 return Text(a.toString());
//               }
//               return const Text('');
//             },
//           ),
//         ),
//       ),
//     );
//     return Scaffold(
//       key: sidePageKey,
//       endDrawer: sidebar(),
//       body: SafeArea(
//         child: Column(
//           children: [
//              SizedBox(
//                   height: GeneralMeasurements.deviceHeight/100*5,
//                   child: Row(//navbar deer bgaa row
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                          Icons.arrow_back,
//                         color: Colors.black,
//                         ),
//                         onPressed: () => Navigator.maybePop(context),
//                       ),
//                        SizedBox(
//                          width: 50,
//                          child: InkWell( // menu btn
//                                          highlightColor: Colors.transparent,
//                                          splashColor: Colors.transparent,
//                                          onTap: () {
//                                            sidePageKey.currentState?.openEndDrawer();
//                                          },
//                                          child: Icon(
//                               Icons.menu,
//                               size: GeneralMeasurements.deviceWidth / 17,
//                               color: Colors.black,
//                             ),
//                                        ),
//                        ),
//                     ],
//                   ),
//                 ),
//             SizedBox(
//               height: GeneralMeasurements.deviceHeight/100*80,
//               child: SfCartesianChart(
//                 title: ChartTitle(text: 'fdfdfd'),
//                 legend: Legend(isVisible: true),
//                 series: <ChartSeries>[],
//               )
              
              
              
              
              
              
              
//               //Padding(
//               //   padding: const EdgeInsets.all(15),
//               //   child: LineChart(lineChartData),
//               // ),
//             ),
//           ],
//         ),
//       ),
//     );

    
//   }
//   Widget sidebar(){
//     return SizedBox(
//       width: GeneralMeasurements.deviceWidth*0.7,
//       child: ListView(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: const BorderRadius.all(Radius.circular(15))
//             ),
//             child: SwitchListTile(
//               title: const Text('Curved'),
//               onChanged: (bool val) => setState(() => _isCurved = val),
//               value: _isCurved,
//             ),
//           ),
//           Container(
//              margin: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: const BorderRadius.all(Radius.circular(15))
//             ),
//             child: SwitchListTile(
//               title: const Text('ShowGrid'),
//               onChanged: (bool val) => setState(() => _showGrid = val),
//               value: _showGrid,
//             ),
//           ),
//           Container(
//              margin: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: const BorderRadius.all(Radius.circular(15))
//             ),
//             child: SwitchListTile(
//               title: const Text('ShowBorder'),
//               onChanged: (bool val) => setState(() => _showBorder = val),
//               value: _showBorder,
//             ),
//           ),
//           Container(
//              margin: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: const BorderRadius.all(Radius.circular(15))
//             ),
//             child: SwitchListTile(
//               title: const Text('ShowBelowArea'),
//               onChanged: (bool val) => setState(() => _showBelowArea = val),
//               value: _showBelowArea,
//             ),
//           ),
//           Container(
//              margin: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: const BorderRadius.all(Radius.circular(15))
//             ),
//             child: SwitchListTile(
//               title: const Text('ShowDot'),
//               onChanged: (bool val) => setState(() => _showDot = val),
//               value: _showDot,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class ResponsesStatistic extends StatefulWidget {
//   const ResponsesStatistic({ Key? key }) : super(key: key);

//   @override
//   State<ResponsesStatistic> createState() => _ResponsesStatisticState();
// }

// class _ResponsesStatisticState extends State<ResponsesStatistic> {
//   TrackballBehavior? _trackballBehavior;
//   List<double>? yValues;
//   bool isWebFullView = true;
//   @override
//   void initState() {
    
//     yValues = <double>[
//       30.87,
//       31.25,
//       28.31,
//       26.15,
//       27.74,
//       25.38,
//       33.87,
//       30.23,
//       30.6,
//       28.75,
//       31.25,
//       28.6,
//       25.7,
//       30.26,
//       29.8,
//       27.26,
//       29.6,
//       30.39,
//       30.63,
//       29.7,
//       30.33,
//       31.7,
//       34.96,
//       30.62,
//       33.03,
//       26.31,
//       30.44,
//       30.14,
//       32.75,
//       28.27,
//       29.96,
//       33.86,
//       34.76,
//       31.4,
//       29.97,
//       31.38,
//       29.01,
//       25.9,
//       29.05,
//       32.17,
//       32.44,
//       31.26,
//       32.62,
//       30.62,
//       32.69,
//       33.7,
//       31.86,
//       33.89,
//       28.47,
//       28.22,
//       29.02,
//       29.05,
//       30.51,
//       33.25,
//       30.08,
//       29.82,
//       29.18,
//       31.24,
//       32.3,
//       31.37,
//       30.1,
//     ];
//     _trackballBehavior = TrackballBehavior(
//       enable: true,
//       lineType: TrackballLineType.none,
//       activationMode: ActivationMode.singleTap,
//       tooltipSettings: const InteractiveTooltip(canShowMarker: false),
//     );
//     super.initState();
 
// }
//  @override
//   Widget build(BuildContext context) {
//     return _buildLineZoneChart(context);
//   }
//  SfCartesianChart _buildLineZoneChart(BuildContext context) {
//     final Orientation orientation = MediaQuery.of(context).orientation;
//     final double containerWidth = kIsWeb
//         ? 80
//         : orientation == Orientation.portrait
//             ? 80
//             : 60;
//     final double containerHeight = kIsWeb
//         ? 60
//         : orientation == Orientation.portrait
//             ? 60
//             : 42;
//     final double fontSize = 14 / MediaQuery.of(context).textScaleFactor;
//     final double size = 13 / MediaQuery.of(context).textScaleFactor;
//     return SfCartesianChart(
//       plotAreaBorderWidth: 0,
//       title: ChartTitle(
//           text: 'Average annual rainfall of United Kingdom'),
//       primaryXAxis: DateTimeAxis(
//           edgeLabelPlacement: isWebFullView
//               ? EdgeLabelPlacement.shift
//               : EdgeLabelPlacement.none,
//           intervalType: DateTimeIntervalType.years,
//           dateFormat: DateFormat.y(),
//           interval: kIsWeb ? 5 : 10,
//           majorGridLines: const MajorGridLines(width: 0)),
//       primaryYAxis: NumericAxis(
//           labelFormat: '{value}mm',
//           minimum: 24,
//           maximum: 36,
//           interval: 2,
//           axisLine: const AxisLine(width: 0),
//           majorTickLines: const MajorTickLines(color: Colors.transparent)),
//       series: _getLineZoneSeries(),
//       trackballBehavior: _trackballBehavior,
//       onTrackballPositionChanging: (TrackballArgs args) {
//         args.chartPointInfo.label =
//             args.chartPointInfo.header! + ' : ' + args.chartPointInfo.label!;
//       },

//       /// To set the annotation content for chart.
//       annotations: <CartesianChartAnnotation>[
//         CartesianChartAnnotation(
//             widget: SizedBox(
//                 height: containerHeight,
//                 width: containerWidth,
//                 child: Column(
//                   // ignore: prefer_const_literals_to_create_immutables
//                   children: <Widget>[
//                     Row(children: <Widget>[
//                       Icon(Icons.circle,
//                           color: const Color.fromRGBO(4, 8, 195, 1),
//                           size: size),
//                       Text(' High', style: TextStyle(fontSize: fontSize)),
//                     ]),
//                     Row(children: <Widget>[
//                       Icon(Icons.circle,
//                           color: const Color.fromRGBO(26, 112, 23, 1),
//                           size: size),
//                       Text(' Medium', style: TextStyle(fontSize: fontSize))
//                     ]),
//                     Row(children: <Widget>[
//                       Icon(Icons.circle,
//                           color: const Color.fromRGBO(229, 11, 10, 1),
//                           size: size),
//                       Text(' Low', style: TextStyle(fontSize: fontSize))
//                     ]),
//                   ],
//                 )),
//             coordinateUnit: CoordinateUnit.percentage,
//             x: kIsWeb ? '95%' : '85%',
//             y: kIsWeb
//                 ? '19%'
//                 : orientation == Orientation.portrait
//                     ? '14%'
//                     : '17%')
//       ],
//     );
//   }

//   List<CartesianSeries<_ChartData, DateTime>> _getLineZoneSeries() {
//     return <CartesianSeries<_ChartData, DateTime>>[
//       LineSeries<_ChartData, DateTime>(
//         animationDuration: 2500,
//         dataSource: getData(),
//         onCreateShader: (ShaderDetails details) {
//           return ui.Gradient.linear(
//               details.rect.topCenter, details.rect.bottomCenter, <Color>[
//             const Color.fromRGBO(4, 8, 195, 1),
//             const Color.fromRGBO(4, 8, 195, 1),
//             const Color.fromRGBO(26, 112, 23, 1),
//             const Color.fromRGBO(26, 112, 23, 1),
//             const Color.fromRGBO(229, 11, 10, 1),
//             const Color.fromRGBO(229, 11, 10, 1),
//           ], <double>[
//             0,
//             0.333333,
//             0.333333,
//             0.666666,
//             0.666666,
//             0.999999,
//           ]);
//         },
//         xValueMapper: (_ChartData sales, _) => sales.x,
//         yValueMapper: (_ChartData sales, _) => sales.y,
//         width: 2,
//       ),
//     ];
//   }

//   List<_ChartData> getData() {
//     final List<_ChartData> data = <_ChartData>[];
//     for (int i = 0; i < yValues!.length; i++) {
//       data.add(_ChartData(DateTime(i + 1950), yValues![i]));
//     }
//     return data;
//   }

//   @override
//   void dispose() {
//     yValues!.clear();
//     super.dispose();
//   }
// }

// class _ChartData {
//   _ChartData(this.x, this.y);
//   final DateTime x;
//   final double y;
// }


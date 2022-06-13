import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';


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
        onPageChanged: (indx){
          surveyCont.responseStatisticGet();
        },
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
           const ResponsesStatistic()
        ],
      ) 

     );
  }
}








/// !!Step1: prepare the data to plot.
final _data1 = <double, double>{1: 2, 2: 3, 3: 4};

class ResponsesStatistic extends StatefulWidget {
  const ResponsesStatistic({Key? key}) : super(key: key);

  @override
  _ResponsesStatisticState createState() => _ResponsesStatisticState();
}

class _ResponsesStatisticState extends State<ResponsesStatistic> {
   GlobalKey<ScaffoldState> sidePageKey = GlobalKey<ScaffoldState>();
   static bool _showGrid = true;
  static bool _isCurved = false;
  static bool _showBelowArea = false;
  static bool _showDot = true;
  static bool _showBorder = true;
  @override
  Widget build(BuildContext context) {
    final spots1 = <FlSpot>[
      for (final entry in _data1.entries) FlSpot(entry.key, entry.value)
    ];
    final lineChartData = LineChartData(
      minX: 0,
      maxX: 5,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: spots1,
          color: Colors.purple,
          barWidth: 5,
          isCurved: _isCurved,
          dotData: FlDotData(show: _showDot),
          belowBarData:
              BarAreaData(show: _showBelowArea, color: Colors.blue[200]),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (_, __) {},
        handleBuiltInTouches: true,
      ),
      borderData: FlBorderData(
        show: _showBorder,
        border: const Border(
          bottom: BorderSide(color: Colors.greenAccent, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      gridData: FlGridData(show: _showGrid),
      // ! Title and ticks in the axis
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 22,
            showTitles: true,
            getTitlesWidget: (double val, _){
              switch(val.toInt()){
                case 1:
                return Text('6/22');
                case 2:
                return Text('6/23');
                case 3:
                return Text('6/24');
                case 4:
                return Text('6/25');
                case 5:
                return Text('6/25');
              }
              return Text('');
            }
                
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double val, _) {
              return Text(val.toString());
            },
          ),
        ),
      ),
    );
    return Scaffold(
      key: sidePageKey,
      endDrawer: sidebar(),
      body: SafeArea(
        child: Column(
          children: [
             SizedBox(
                  height: GeneralMeasurements.deviceHeight/100*5,
                  child: Row(//navbar deer bgaa row
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                         Icons.arrow_back,
                        color: Colors.black,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                       SizedBox(
                         width: 50,
                         child: InkWell( // menu btn
                                         highlightColor: Colors.transparent,
                                         splashColor: Colors.transparent,
                                         onTap: () {
                                           sidePageKey.currentState?.openEndDrawer();
                                         },
                                         child: Icon(
                              Icons.menu,
                              size: GeneralMeasurements.deviceWidth / 17,
                              color: Colors.black,
                            ),
                                       ),
                       ),
                    ],
                  ),
                ),
            SizedBox(
              height: GeneralMeasurements.deviceHeight/100*80,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: LineChart(lineChartData),
              ),
            ),
          ],
        ),
      ),
    );

    
  }
  Widget sidebar(){
    return SizedBox(
      width: GeneralMeasurements.deviceWidth*0.7,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
            child: SwitchListTile(
              title: const Text('Curved'),
              onChanged: (bool val) => setState(() => _isCurved = val),
              value: _isCurved,
            ),
          ),
          Container(
             margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
            child: SwitchListTile(
              title: const Text('ShowGrid'),
              onChanged: (bool val) => setState(() => _showGrid = val),
              value: _showGrid,
            ),
          ),
          Container(
             margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
            child: SwitchListTile(
              title: const Text('ShowBorder'),
              onChanged: (bool val) => setState(() => _showBorder = val),
              value: _showBorder,
            ),
          ),
          Container(
             margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
            child: SwitchListTile(
              title: const Text('ShowBelowArea'),
              onChanged: (bool val) => setState(() => _showBelowArea = val),
              value: _showBelowArea,
            ),
          ),
          Container(
             margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
            child: SwitchListTile(
              title: const Text('ShowDot'),
              onChanged: (bool val) => setState(() => _showDot = val),
              value: _showDot,
            ),
          ),
        ],
      ),
    );
  }
}

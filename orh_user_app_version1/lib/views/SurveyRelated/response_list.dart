import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

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
        String? c = item.createdDate;
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


class ResponsesStatistic extends StatefulWidget {
  const ResponsesStatistic({ Key? key }) : super(key: key);

  @override
  State<ResponsesStatistic> createState() => _ResponsesStatisticState();
}



class _ResponsesStatisticState extends State<ResponsesStatistic> {
  TrackballBehavior? _trackballBehavior;
  bool isWebFullView = true;
   var sCont = Get.find<SurveyController>();
     late double minYvalue;
     double maxYvalue = 0;
     double l_interval = 1;
  @override
  void initState() {
      minYvalue = sCont.statisticAnswer.result![0].answers![0].numberAnswer!.toDouble();
      for(int a = 0; a<sCont.statisticAnswer.result!.length; a++){
      if(sCont.statisticAnswer.result![a].answers![0].numberAnswer! > maxYvalue){
        maxYvalue = sCont.statisticAnswer.result![a].answers![0].numberAnswer!.toDouble();
      }
      if(sCont.statisticAnswer.result![a].answers![0].numberAnswer! < minYvalue){
        minYvalue = sCont.statisticAnswer.result![a].answers![0].numberAnswer!.toDouble();
      }
    }
    for(int b = 0; b < sCont.surveyResponses.result!.length; b++){
    }
    l_interval = (maxYvalue-minYvalue)/20;
    _trackballBehavior = TrackballBehavior(
    //   builder: (BuildContext context, TrackballDetails trackballDetails) {
    //   return Container(
    //     width: 70,
    //     decoration:
    //       const BoxDecoration(color: Color.fromARGB(255, 41, 92, 69)),
    //     child: Text('${trackballDetails.point?.cumulativeValue}')
    //   );
    // },
      lineColor: Colors.blue,
      enable: true,
      lineType: TrackballLineType.horizontal,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(canShowMarker: false),
    );
    super.initState();
 
}
 @override
  void dispose() {
    super.dispose();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        padding: const EdgeInsets.only(bottom: 80),
        child: _buildLineZoneChart(context)));
  }
 SfCartesianChart _buildLineZoneChart(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double containerWidth = kIsWeb
        ? 80
        : orientation == Orientation.portrait
            ? 80
            : 60;
    final double containerHeight = kIsWeb
        ? 60
        : orientation == Orientation.portrait
            ? 60
            : 42;
    final double fontSize = 14 / MediaQuery.of(context).textScaleFactor;
    final double size = 13 / MediaQuery.of(context).textScaleFactor;
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        textStyle: const TextStyle(
          color: Colors.white
        ),
          text: 'Сахарын хэмжилтийн үр дүн'),
      primaryXAxis: CategoryAxis(

      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          minimum: minYvalue,
          maximum: maxYvalue,
          interval: l_interval,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getLineZoneSeries(),
      trackballBehavior: _trackballBehavior,
      onTrackballPositionChanging: (TrackballArgs args) {
        args.chartPointInfo.label =
            args.chartPointInfo.header! + ' : ' + args.chartPointInfo.label!;
      },

      /// To set the annotation content for chart.
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: SizedBox(
                height: containerHeight,
                width: containerWidth,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                     Row(children: <Widget>[
                      Icon(Icons.circle,
                          color: const Color.fromRGBO(229, 11, 10, 1),
                          size: size),
                      Text(' Low', style: TextStyle(color: Colors.white, fontSize: fontSize))
                    ]),
                     Row(children: <Widget>[
                      Icon(Icons.circle,
                          color: const Color.fromRGBO(26, 112, 23, 1),
                          size: size),
                      Text(' Medium', style: TextStyle(color: Colors.white, fontSize: fontSize))
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.circle,
                          color: const Color.fromRGBO(4, 8, 195, 1),
                          size: size),
                      Text(' High', style: TextStyle(color: Colors.white, fontSize: fontSize)),
                    ]),
                  ],
                )),
            coordinateUnit: CoordinateUnit.percentage,
            x: kIsWeb ? '95%' : '85%',
            y: kIsWeb
                ? '19%'
                : orientation == Orientation.portrait
                    ? '14%'
                    : '17%')
      ],
    );
  }

  List<CartesianSeries<_ChartData, String>> _getLineZoneSeries() {
    return <CartesianSeries<_ChartData, String>>[
      LineSeries<_ChartData, String>(
        animationDuration: 2500,
        dataSource: getData(),
        onCreateShader: (ShaderDetails details) {
          return ui.Gradient.linear(
              details.rect.topCenter, details.rect.bottomCenter, <Color>[
            const Color.fromRGBO(229, 11, 10, 1),
            const Color.fromRGBO(229, 11, 10, 1),
            const Color.fromRGBO(26, 112, 23, 1),
            const Color.fromRGBO(26, 112, 23, 1),
            const Color.fromRGBO(4, 8, 195, 1),
            const Color.fromRGBO(4, 8, 195, 1),
          ], <double>[
            0,
            0.333333,
            0.333333,
            0.666666,
            0.666666,
            0.999999,
          ]);
        },
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 5,
      ),
    ];
  }

  List<_ChartData> getData() {
    final List<_ChartData> data = <_ChartData>[];
    for (int i = 0; i < sCont.statisticAnswer.result!.length; i++) {
      data.add(_ChartData(sCont.statisticAnswer.result![i].answers![0].createdDate!.toString().substring(6,16), 
                          sCont.statisticAnswer.result![i].answers![0].numberAnswer!.toDouble()));
    }
    return data;
  }

}
class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}



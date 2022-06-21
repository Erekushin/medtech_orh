import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';


List<Color> lineColors = [Colors.red, Colors.blue, Colors.purple, Colors.orange, Colors.green];
class ResStatistic extends StatefulWidget {
  const ResStatistic({ Key? key }) : super(key: key);
  @override
  State<ResStatistic> createState() => _ResStatisticState();
}

class _ResStatisticState extends State<ResStatistic> {
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
        for(int w = 0; w < sCont.statisticAnswer.result![a].answers!.length; w++){
           if(sCont.statisticAnswer.result![a].answers![w].numberAnswer! > maxYvalue){
            maxYvalue = sCont.statisticAnswer.result![a].answers![w].numberAnswer!.toDouble();
           }
           if(sCont.statisticAnswer.result![a].answers![w].numberAnswer! < minYvalue){
           minYvalue = sCont.statisticAnswer.result![a].answers![w].numberAnswer!.toDouble();
           }
        }
    }
    for(int b = 0; b < sCont.surveyResponses.result!.length; b++){
    }
    l_interval = (maxYvalue-minYvalue)/20;
    _trackballBehavior = TrackballBehavior(
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
  GlobalKey<ScaffoldState> sidePageKey = GlobalKey<ScaffoldState>();
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sidePageKey,
      endDrawer: const Sidebar(),
      body: Stack(
        children : [ Container(
          color: Colors.black87,
          padding: const EdgeInsets.only(bottom: 80),
          child: _buildLineZoneChart(context)),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  sidePageKey.currentState?.openEndDrawer();
                },
                child: const Icon(Icons.menu, color: Colors.white,),
              ),
            ),
          )
          ]
      ));
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
          text: 'Хавтгай дээрх үзүүлэлт'),
          primaryXAxis: CategoryAxis(

      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          minimum: minYvalue,
          maximum: maxYvalue,
          interval: l_interval,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getlines(),
      trackballBehavior: _trackballBehavior,
      onTrackballPositionChanging: (TrackballArgs args) {
        args.chartPointInfo.label =
            args.chartPointInfo.header! + ' : ' + args.chartPointInfo.label!;
      },
    );
  }
  
  List<CartesianSeries<_ChartData, String>> getlines() {
    List<CartesianSeries<_ChartData, String>> lines = [];
    for(int q = 0; q < sCont.statisticAnswer.result![0].answers!.length;  q++){
      lines.add(LineSeries<_ChartData, String>(
        animationDuration: 2500,
        dataSource: getData(q),
        color: lineColors[q],
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 5,
      ));
    }
    return lines;
  }

  List<_ChartData> getData(int index) {
    final List<_ChartData> data = <_ChartData>[];
    for (int i = 0; i < sCont.statisticAnswer.result!.length; i++) {
      data.add(_ChartData(sCont.statisticAnswer.result![i].answers![index].createdDate!.toString().substring(6,18), 
                          sCont.statisticAnswer.result![i].answers![index].numberAnswer!.toDouble(),));
    }
    return data;
  }
}
class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  var sCont = Get.find<SurveyController>();
  Widget titles(Color cl, String txt){
  return Row(children: <Widget>[
             Icon(Icons.circle,
             color: cl,
             size: 12),
             const SizedBox(width: 10,),
             Container(
              margin: const EdgeInsets.all(5),
              width: GeneralMeasurements.deviceWidth*.5,
               child: Text(txt,
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(height: 1, fontWeight: FontWeight.bold, fontSize: 15,
                    color: Colors.white),),
             )
]);
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GeneralMeasurements.deviceWidth*.6,
      child: ListView.builder(
                    itemCount: sCont.statisticAnswer.result![0].answers!.length,
                    itemBuilder: (c,i){
                      var item  = sCont.statisticAnswer.result![0].answers![i];
                    return titles(lineColors[i], item.question!); 
                  }),
    );
  }
}
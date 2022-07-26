import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/SurveyRelated/response.dart';
import '../../../Models/SurveyRelated/statistic_answer.dart';
import '../../../MyWidgets/my_text.dart';
import '../../../global_constant.dart';
import '../../../MyWidgets/waiting_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//level 1
class ResMain extends StatefulWidget {
  const ResMain({Key? key}) : super(key: key);
  @override
  State<ResMain> createState() => _ResMainState();
}

class _ResMainState extends State<ResMain> {
  var resCont = Get.find<ResCont>();
  staView() {
    //list ee null bishvvdiig ni oor list rvv avii
    for (int a = 0; a < resCont.statisticAnswer.result!.length; a++) {
      if (resCont.statisticAnswer.result![a].answers != null) {
        resCont.lineChartValueList.add(resCont.statisticAnswer.result![a]);
      }
    }
    if (resCont.lineChartValueList.length > 1) {
      return const ResSta();
    } else {
      return const WaitingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PageView(
      children: [const ResList(), staView()],
    ));
  }
}

//level 2
class ResList extends StatefulWidget {
  const ResList({Key? key}) : super(key: key);

  @override
  State<ResList> createState() => _ResListState();
}

class _ResListState extends State<ResList> {
  var resCont = Get.find<ResCont>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ListView.builder(
          itemCount: resCont.surveyResponses.result?.length ?? 0,
          itemBuilder: (c, i) {
            var item = resCont.surveyResponses.result![i];
            String? c = item.createdDate;
            String? n = item.researcherName;
            return InkWell(
                onTap: () {
                  resCont.answers(c!);
                },
                child: Container(
                    margin:
                        EdgeInsets.all(GeneralMeasurements.deviceWidth * .02),
                    height: GeneralMeasurements.deviceHeight * .08,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: GeneralMeasurements.deviceWidth * .7,
                          child: myText('$c $n', 17, 1, FontWeight.w700),
                        ),
                      ],
                    )));
          },
        ),
        Visibility(
            visible: resCont.surveyResponses.result!.isEmpty ? true : false,
            child: Image.asset('assets/images/empty_box.jpg'))
      ],
    ));
  }
}

//level 3
class ResSta extends StatefulWidget {
  const ResSta({Key? key}) : super(key: key);
  @override
  State<ResSta> createState() => _ResStaState();
}

class _ResStaState extends State<ResSta> {
  TrackballBehavior? _trackballBehavior;
  bool isWebFullView = true;
  var resCont = Get.find<ResCont>();
  late double minYvalue;
  double maxYvalue = 0;
  double l_interval = 1;
  @override
  void initState() {
    //doorh hesegt min bolon max value aa olj bgaa
    minYvalue =
        resCont.lineChartValueList[0].answers![0].numberAnswer!.toDouble();
    for (int a = 0; a < resCont.lineChartValueList.length; a++) {
      for (int w = 0; w < resCont.lineChartValueList[a].answers!.length; w++) {
        if (resCont.lineChartValueList[a].answers![w].numberAnswer! >
            maxYvalue) {
          maxYvalue = resCont.lineChartValueList[a].answers![w].numberAnswer!
              .toDouble();
        }
        if (resCont.lineChartValueList[a].answers![w].numberAnswer! <
            minYvalue) {
          minYvalue = resCont.lineChartValueList[a].answers![w].numberAnswer!
              .toDouble();
        }
      }
    }
    if (maxYvalue == minYvalue) {
      maxYvalue = minYvalue + minYvalue;
    }
    for (int b = 0; b < resCont.surveyResponses.result!.length; b++) {}
    l_interval = (maxYvalue - minYvalue) / 20;
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
        body: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                    height: GeneralMeasurements.deviceHeight * 0.5,
                    width: GeneralMeasurements.deviceWidth,
                    color: Colors.black87,
                    padding: const EdgeInsets.only(bottom: 80),
                    child: _buildLineZoneChart(context))
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  sidePageKey.currentState?.openEndDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]));
  }

  SfCartesianChart _buildLineZoneChart(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior:
          ZoomPanBehavior(enablePanning: true, enablePinching: true),
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          textStyle: const TextStyle(color: Colors.white),
          text: 'Хавтгай дээрх үзүүлэлт'),
      primaryXAxis: CategoryAxis(),
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
    for (int q = 0; q < resCont.lineChartValueList[0].answers!.length; q++) {
      lines.add(LineSeries<_ChartData, String>(
        animationDuration: 2500,
        dataSource: getData(q),
        color: CommonColors.chartColors[q],
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 5,
      ));
    }
    return lines;
  }

  List<_ChartData> getData(int index) {
    final List<_ChartData> data = <_ChartData>[];
    for (int i = 0; i < resCont.lineChartValueList.length; i++) {
      data.add(_ChartData(
        resCont.lineChartValueList[i].answers![index].createdDate!
            .toString()
            .substring(6, 18),
        resCont.lineChartValueList[i].answers![index].numberAnswer!.toDouble(),
      ));
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
  var resCont = Get.find<ResCont>();
  Widget titles(Color cl, String txt) {
    return Row(children: <Widget>[
      Icon(Icons.circle, color: cl, size: 12),
      const SizedBox(
        width: 10,
      ),
      Container(
        margin: const EdgeInsets.all(5),
        width: GeneralMeasurements.deviceWidth * .5,
        child: Text(
          txt,
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.openSans(
              height: 1,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GeneralMeasurements.deviceWidth * .6,
      child: ListView.builder(
          itemCount: resCont.lineChartValueList[0].answers!.length,
          itemBuilder: (c, i) {
            var item = resCont.lineChartValueList[0].answers![i];
            return titles(CommonColors.chartColors[i], item.question!);
          }),
    );
  }
}

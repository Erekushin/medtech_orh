import 'package:flutter/material.dart';

import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';
import 'CreatedWidgets/circle_day_presenter.dart';
import 'CreatedWidgets/time_squence_cell.dart';
class DoctorTimeSequence extends StatefulWidget {
  const DoctorTimeSequence({Key? key}) : super(key: key);
  @override
  _DoctorTimeSequenceState createState() => _DoctorTimeSequenceState();
}

class _DoctorTimeSequenceState extends State<DoctorTimeSequence> {
  GenerateDateBasedColumns(){
    List<DataColumn> DateColumns = <DataColumn>[];
    DateColumns.add(DataColumn(label: Container(child: Text('өдөр'),)));
    for(int i = 8; i < 16; i++){
      DateColumns.add(DataColumn(
          label: Text('        $i        ')));
    }
    return DateColumns;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text(
          'Цагийн хуваарь',
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
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(margin: EdgeInsets.all(10), width: 20, height: 20,
                          decoration: BoxDecoration(color: Colors.pinkAccent,
                              borderRadius: BorderRadius.all(Radius.circular(10))),),
                        Text('Сонгох боломжтой цаг')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(margin: EdgeInsets.all(10), width: 20, height: 20,
                          decoration: BoxDecoration(color: Colors.yellow,
                              borderRadius: BorderRadius.all(Radius.circular(10))),),
                        Text('Таны сонгосон цаг')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(margin: EdgeInsets.all(10), width: 20, height: 20,
                          decoration: BoxDecoration(color: Color(0xFFE6E7E8),
                              borderRadius: BorderRadius.all(Radius.circular(10))),),
                        Text('Сонгох боломжгүй цаг')
                      ],
                    )
                  ],
                ),
              ),
              PaginatedDataTable(
                columnSpacing: 10,
                horizontalMargin: 10,
                rowsPerPage: 9,
                showCheckboxColumn: false,
                columns: GenerateDateBasedColumns(),
                source: DessertDataSource(),
              ),
            ]
        ),
      ),
    );
  }
}

class CellClass{
  CellClass(this.Day, this.Hour, this.Status);
  String Day;
  String Hour;
  int Status;
}

class RowData {
  RowData(this.TimeSequence, this.hour1, this.hour2, this.hour3, this.hour4,
      this.hour5, this.hour6, this.hour7, this.hour8, this.hour9);
  final Widget TimeSequence;
  final CellClass hour1;
  final CellClass hour2;
  final CellClass hour3;
  final CellClass hour4;
  final CellClass hour5;
  final CellClass hour6;
  final CellClass hour7;
  final CellClass hour8;
  final CellClass hour9;
  bool selected = false;
}
class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;
  List<RowData> HourStatuses = <RowData>[
    RowData(CircleDayPresenter(HourText: "9/5",), CellClass("day4", "Create hour", 2),
        CellClass("day5", "Hour4", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1)),
    RowData(CircleDayPresenter(HourText: "9/6",), CellClass("day4", "Create hour", 1),
        CellClass("day5", "Hour4", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1)),
    RowData(CircleDayPresenter(HourText: "9/7",), CellClass("day4", "Create hour", 1),
        CellClass("day5", "Hour4", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1)),
    RowData(CircleDayPresenter(HourText: "9/8",), CellClass("day4", "Create hour", 1),
        CellClass("day5", "Hour4", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 0), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1),
        CellClass("day4", "Create hour", 1), CellClass("day4", "Create hour", 1)),

  ];
  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= HourStatuses.length) return null;
    final RowData dessert = HourStatuses[index];
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,

      cells: <DataCell>[
        DataCell(Container(child: dessert.TimeSequence,)),
        DataCell(TimeSequenceCell(CellData: dessert.hour1)),
        DataCell(TimeSequenceCell(CellData: dessert.hour2)),
        DataCell(TimeSequenceCell(CellData: dessert.hour3)),
        DataCell(TimeSequenceCell(CellData: dessert.hour4)),
        DataCell(TimeSequenceCell(CellData: dessert.hour5)),
        DataCell(TimeSequenceCell(CellData: dessert.hour6)),
        DataCell(TimeSequenceCell(CellData: dessert.hour7)),
        DataCell(TimeSequenceCell(CellData: dessert.hour8)),
      ],
    );
  }
  @override
  int get rowCount => HourStatuses.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => _selectedCount;
}

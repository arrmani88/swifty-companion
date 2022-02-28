import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:swifty_companion/globals/globals.dart';

// final gridColor = Theme.of(context).secondaryHeaderColor;
// const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffe15665);
const artColor = Color(0xff63e7e5);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Colors.white70;
const offRoadColor = Color(0xFFFFF59D);

class Skills extends StatelessWidget {
  Skills({Key? key}) : super(key: key);

  final List<RadarEntry> skillsValues = [];
  List<RadarEntry> getDataEntries() {
    user.skills['42cursus']?.forEach((key, value) => skillsValues.add(RadarEntry(value: value)));
    return skillsValues;
  }
  // final List<RadarDataSet> dataSets = [
  //   RadarDataSet(
  //     fillColor: null,
  //     borderColor: const Color(0xff167676),
  //     dataEntries: getDataEntries(),
  //     // const [
  //     //   RadarEntry(value: 1),
  //     //   RadarEntry(value: 2),
  //     //   RadarEntry(value: 4),
  //     //   RadarEntry(value: 9),
  //     //   RadarEntry(value: 9),
  //     // ]
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        titleTextStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
        gridBorderData: BorderSide(color: Theme.of(context).secondaryHeaderColor, width: 2),
        tickBorderData: const BorderSide(color: Colors.transparent),
        ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
        // tickCount: null,
        radarBorderData: const BorderSide(color: Colors.transparent),
        borderData: FlBorderData(show: false), // contour dial the whole widget
        radarBackgroundColor: Colors.transparent,
        getTitle: (index) => user.skills['42cursus']?.keys.elementAt(index) ?? '',
        dataSets: [
          RadarDataSet(
            fillColor: null,
            borderColor: const Color(0xff167676),
            dataEntries: getDataEntries(),
            // const [
            //   RadarEntry(value: 1),
            //   RadarEntry(value: 2),
            //   RadarEntry(value: 4),
            //   RadarEntry(value: 9),
            //   RadarEntry(value: 9),
            // ]
          ),
        ]
      ),
    );
  }
}
 // 14, 1, 16, 5, 7, 2, 10,
import 'dart:io';
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

class Skills extends StatefulWidget {
  const Skills({Key? key}) : super(key: key);
  @override State<Skills> createState() => _SkillsState();
}
class _SkillsState extends State<Skills> {
  List<RadarEntry> skillsValues = [];
  List<RadarDataSet>? dataSets = [];

  @override
  setData() {
    skillsValues.clear();
    dataSets?.clear();
    user.skills[selectedCursus]?.forEach((key, value) => skillsValues.add(RadarEntry(value: value)));
    dataSets = [
      RadarDataSet(
        fillColor: null,
        borderColor: const Color(0xff167676),
        dataEntries: skillsValues,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    setData();
    return RadarChart(
      RadarChartData(
        titleTextStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
        gridBorderData: BorderSide(color: Theme.of(context).secondaryHeaderColor, width: 2),
        tickBorderData: const BorderSide(color: Colors.transparent),
        ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
        tickCount: null,
        radarBorderData: const BorderSide(color: Colors.transparent),
        borderData: FlBorderData(show: false), // contour dial the whole widget (malay9 lwalo)
        radarBackgroundColor: Colors.transparent,
        getTitle: (index) {
          if (index < (user.skills[selectedCursus]?.keys.length)!)
            return (user.skills[selectedCursus]?.keys.elementAt(index))!;
          return '-001';
        },
        dataSets: dataSets
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:swifty_companion/globals/globals.dart';

class Skills extends StatefulWidget {
  const Skills({Key? key}) : super(key: key);
  @override State<Skills> createState() => _SkillsState();
}
class _SkillsState extends State<Skills> {
  List<RadarEntry> skillsValues = [];
  List<RadarDataSet> dataSets = [];

  setData() {
    print('@@@@@@@@@ setting data @@@@@@@@@');
    skillsValues.clear();
    dataSets.clear();
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

    print('-------------------------- debug');
    for (RadarEntry re in skillsValues) print(re.value);
    for (String str in (user.skills[selectedCursus]?.keys)!) print(str);
    print('debug --------------------------');

    return RadarChart(
      RadarChartData(
        titleTextStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 8),
        gridBorderData: BorderSide(color: Theme.of(context).secondaryHeaderColor, width: 2),
        tickBorderData: const BorderSide(color: Colors.transparent),
        ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
        tickCount: null,
        radarBorderData: const BorderSide(color: Colors.transparent),
        borderData: FlBorderData(show: false), // contour dial the whole widget (malay9 lwalo)
        radarBackgroundColor: Colors.transparent,
        getTitle: (index) {
          if (index < (user.skills[selectedCursus]?.keys.length)!) {
            return (user.skills[selectedCursus]?.keys.elementAt(index))!;
          }
          return '';
        },
        dataSets: dataSets
      ),
    );
  }
}

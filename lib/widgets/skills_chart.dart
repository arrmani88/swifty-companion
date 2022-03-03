import 'package:flutter/material.dart';
import 'package:radar_chart/radar_chart.dart';
import 'dart:math';

// class RadarChartExample extends StatefulWidget {
//   const RadarChartExample({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override _RadarChartExampleState createState() => _RadarChartExampleState();
// }
// class _RadarChartExampleState extends State<RadarChartExample> {
//   int _counter = 5;
//   List<double> values1 = [0.4, 0.8, 0.65, 0.55, 0.12];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         RadarChart(
//           length: _counter,
//           radius: 150,
//           initialAngle: 0,
//           backgroundColor: Colors.transparent,
//           borderStroke: 2,
//           borderColor: Colors.grey.shade300,
//           radialStroke: 2,
//           radialColor: Colors.grey.shade300,
//           radars: [
//             RadarTile(
//               values: values1,
//               borderStroke: 2,
//               borderColor: Colors.yellow,
//               backgroundColor: Colors.yellow.withOpacity(0.4),
//             ),
//           ],
//           vertices: const [
//             RadarVertex(
//               radius: 30,
//               textOffset: Offset(0, 0),
//               title: '111',
//             ),
//             RadarVertex(
//               radius: 30,
//               textOffset: Offset(0, 0),
//               title: '222',
//             ),
//             RadarVertex(
//                 radius: 30,
//                 textOffset: Offset(20, 20),
//                 title: '333'
//             ),
//             RadarVertex(
//                 radius: 30,
//                 textOffset: Offset(0, 0),
//                 title: '444'
//             ),
//             RadarVertex(
//                 radius: 30,
//                 textOffset: Offset(0, 0),
//                 title: '444'
//             ),
//           ],
//         ),
//         // RadarChart(
//         //   length: 3,
//         //   radius: 100,
//         //   initialAngle: 0,
//         //   backgroundColor: Colors.white,
//         //   borderStroke: 2,
//         //   borderColor: Colors.grey.shade300,
//         //   radialStroke: 1,
//         //   radialColor: Colors.grey.shade300,
//         //   vertices: [
//         //     for (int i = 0; i < 3; i++)
//         //       RadarVertex(
//         //         radius: 15,
//         //         textOffset: Offset(0, 0),
//         //         text: Text('$i'),
//         //       ),
//         //   ],
//         //   radars: [
//         //     RadarTile(
//         //       radialColor: Colors.green,
//         //       values: values1,
//         //       borderStroke: 2,
//         //       borderColor: Colors.yellow,
//         //       backgroundColor: Colors.yellow.withOpacity(0.4),
//         //     ),
//         //     RadarTile(
//         //       radialColor: Colors.red,
//         //       values: values1,
//         //       borderStroke: 2,
//         //       borderColor: Colors.yellow,
//         //       backgroundColor: Colors.yellow.withOpacity(0.4),
//         //     ),
//         //     RadarTile(
//         //       radialColor: Colors.red,
//         //       values: values1,
//         //       borderStroke: 2,
//         //       borderColor: Colors.yellow,
//         //       backgroundColor: Colors.yellow.withOpacity(0.4),
//         //     ),
//         //   ],
//         // ),
//       ],
//     );
//   }
// }
//
// class RadarVertex extends StatelessWidget with PreferredSizeWidget {
//   const RadarVertex({required this.radius, this.textOffset, this.title});
//   final double radius;
//   final Offset? textOffset;
//   final String? title;
//   @override
//   Size get preferredSize => Size.fromRadius(radius);
//
//   @override
//   Widget build(BuildContext context) {
//     // Widget tree = CircleAvatar(
//     //   radius: 10,
//     //   backgroundColor: Colors.redAccent,
//     // );
//     // if (title != null) {
//     //   tree = Stack(
//     //     children: [
//     //       tree,
//     //       Center(
//     //         child: Text(title!, style: TextStyle(color: Colors.white),),
//     //       )
//     //     ],
//     //   );
//     // }
//     return Text(title!, style: TextStyle(color: Colors.white),);
//   }
// }

/******************************/

class RadarChartExample extends StatefulWidget {
  const RadarChartExample({Key? key, required this.title}) : super(key: key);
  final String title;
  @override _RadarChartExampleState createState() => _RadarChartExampleState();
}
class _RadarChartExampleState extends State<RadarChartExample> {
  int _counter = 3;
  List<double> values1 = [0.4, 0.8, 0.65];
  List<double> values2 = [0.5, 0.3, 0.85];
  late List<PreferredSizeWidget> vertices2;

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      vertices: const [
        RadarVertex(
          radius: 30,
          textOffset: Offset(0, 0),
          text: Text('111',)
        ),
        RadarVertex(
          radius: 30,
          textOffset: Offset(0, 0),
          text: Text('222',)
        ),
        RadarVertex(
            radius: 30,
            textOffset: Offset(20, 20),
            text: Text('333')
        ),
        RadarVertex(
            radius: 30,
            textOffset: Offset(0, 0),
            text: Text('444')
        ),
        RadarVertex(
            radius: 30,
            textOffset: Offset(0, 0),
            text: Text('444')
        ),
      ],
      length: _counter,
      radius: 150,
      initialAngle: 0,
      backgroundColor: Colors.white,
      borderStroke: 2,
      borderColor: Colors.grey.shade300,
      radialStroke: 2,
      radialColor: Colors.grey.shade300,
      radars: [
        RadarTile(
          values: values1,
          borderStroke: 2,
          borderColor: Colors.yellow,
          backgroundColor: Colors.yellow.withOpacity(0.4),
        ),
      ],
    );
  }
}

class RadarVertex extends StatelessWidget with PreferredSizeWidget {
  const RadarVertex({
    required this.radius,
    this.text,
    this.textOffset,
  });

  final double radius;
  final Widget? text;
  final Offset? textOffset;

  @override
  Size get preferredSize => Size.fromRadius(radius);

  @override
  Widget build(BuildContext context) {
    Widget tree = CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
    );
    if (text != null) {
      tree = Stack(
        children: [
          tree,
          Center(
            child: text,
          )
        ],
      );
    }
    return tree;
  }
}
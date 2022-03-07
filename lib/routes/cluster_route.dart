import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
class ClusterRoute extends StatefulWidget {
  const ClusterRoute({Key? key}) : super(key: key);

  @override
  _ClusterRouteState createState() => _ClusterRouteState();
}
class _ClusterRouteState extends State<ClusterRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: Row(
          children: [

          ],
        ),
      ),
    );
  }
}

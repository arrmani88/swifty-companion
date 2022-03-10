import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/functions/get_clusters.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import '../providers/cluster_provider.dart';
import 'package:swifty_companion/widgets/workstation.dart';

class ClustersRoute extends StatefulWidget {
  const ClustersRoute({Key? key}) : super(key: key);

  @override
  _ClustersRouteState createState() => _ClustersRouteState();
}
class _ClustersRouteState extends State<ClustersRoute> {
  late Future futureCluster;

  @override
  void initState() {
    futureCluster = getClusters(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: SafeArea(
          child: (context.watch<ClustersProvider>().isClustersLoading == true)
            ? const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 25.0, right: 25.0),
              child: SizedBox(width: 500, child: LoadingPopUp()),
            )
            : Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: <Widget>[
                    for (List<Widget> range in ((context.watch<ClustersProvider>().e1WidgetsList) as List<List<Widget>>))
                      Row(children: range),
                  ]
                ),
              ),
            ),
          ),
        ),
    );
  }
}




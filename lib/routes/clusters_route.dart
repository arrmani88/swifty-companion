import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/functions/get_clusters.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import 'package:swifty_companion/globals/globals.dart';
import '../providers/cluster_provider.dart';

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
        child: (context.watch<ClustersProvider>().isClustersLoading == true)
          ? const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 25.0, right: 25.0),
            child: SizedBox(width: 500, child: LoadingPopUp()),
          )
          : const Center(child: Text('text')),
      ),
    );
  }
}





/*
VERSION DIAL FutureBuilder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: FutureBuilder(
          initialData: context.read<ClustersProvider>().didGetClusters,
          future: futureCluster,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
            // if (context.read<ClustersProvider>().didGetClusters == true) {
            // if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              print(':::::::::::::::::::::::::::::::::::');
              print(context.read<ClustersProvider>().clustersList);
              print(':::::::::::::::::::::::::::::::::::');
              return Row(
                children: const [
                  Center(child: Text('text')),
                ],
              );
            }
            return const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 25.0, right: 25.0),
              child: SizedBox(width: 500, child: LoadingPopUp()),
            );
          }
        ),
      ),
    );
  }

*/
import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/functions/get_cluster.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import 'package:swifty_companion/globals/globals.dart';

class ClustersRoute extends StatefulWidget {
  const ClustersRoute({Key? key}) : super(key: key);

  @override
  _ClustersRouteState createState() => _ClustersRouteState();
}
class _ClustersRouteState extends State<ClustersRoute> {
  late Future futureCluster;

  Future loadCluster() async => await getCluster();

  @override
  void initState() {
    futureCluster = loadCluster();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: FutureBuilder(
          future: futureCluster,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print('<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>');
              print(response1);
              print('<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>');
              print(response2);
              print('<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>');
              print(response3);
              print('<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>');
              return Row(
                children: const [
                  Text('text'),
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
}

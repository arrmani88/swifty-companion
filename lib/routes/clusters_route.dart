import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import '../providers/cluster_provider.dart';
import 'package:switcher_button/switcher_button.dart';

class ClustersRoute extends StatefulWidget {
  const ClustersRoute({Key? key}) : super(key: key);

  @override
  _ClustersRouteState createState() => _ClustersRouteState();
}
class _ClustersRouteState extends State<ClustersRoute> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_){
      context.read<ClustersProvider>().getClusters(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingButtons(parentContext: context),
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              child: (context.watch<ClustersProvider>().areClustersLoading == true)
                ? const SizedBox(width: 500, child: LoadingPopUp())
                : Center(
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.only(bottom: 80.0),
                    minScale: 0000.1,
                    maxScale: 8.0,
                    constrained: false,
                      child: Column(
                        children: <Widget>[
                          for (List<Widget> range
                            in (context.watch<ClustersProvider>().isE1Selected == true
                                ? (context.watch<ClustersProvider>().isClusterRotated ? context.read<ClustersProvider>().e1WidgetsList.reversed : context.read<ClustersProvider>().e1WidgetsList)
                                : (context.watch<ClustersProvider>().isClusterRotated ? context.read<ClustersProvider>().e2WidgetsList.reversed : context.read<ClustersProvider>().e2WidgetsList)))
                            Row(children: context.watch<ClustersProvider>().isClusterRotated ? range.reversed.toList() : range),
                        ]
                      ),
                ),
              ),
            ),
          )
          ),
        ),
    );
  }
}


class FloatingButtons extends StatefulWidget {
  BuildContext parentContext;
  FloatingButtons({Key? key, required this.parentContext}) : super(key: key);

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}
class _FloatingButtonsState extends State<FloatingButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            color: Theme.of(context).secondaryHeaderColor,
            child: IconButton(padding: const EdgeInsets.all(2.0),
              onPressed: () => context.read<ClustersProvider>().getClusters(widget.parentContext),
              icon: Icon(Icons.refresh, size: 35.0, color: Theme.of(context).scaffoldBackgroundColor,),
            ),
          ),
          const SizedBox(width: 9.0),
          Container(
            height: 40.0,
            width: 40.0,
            color: Theme.of(context).secondaryHeaderColor,
            child: IconButton(padding: const EdgeInsets.all(2.0),
              onPressed: () => context.read<ClustersProvider>().rotateCluster(),
              icon: Icon(Icons.rotate_90_degrees_ccw, size: 29.0, color: Theme.of(context).scaffoldBackgroundColor,),
            ),
          ),
          const SizedBox(width: 9.0),
          Container(
            height: 40.0,
            color: Theme.of(context).secondaryHeaderColor,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top :3.0),
                    child: Text('E1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  ),
                  const SizedBox(width: 2.0),
                  SwitcherButton(
                    size: 40.0,
                    value: !context.watch<ClustersProvider>().isE1Selected,
                    onColor: Colors.blueGrey,
                    offColor: Theme.of(context).scaffoldBackgroundColor,
                    onChange: (_) => context.read<ClustersProvider>().switchCluster(),
                  ),
                  const SizedBox(width: 8.0),
                  const Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text('E2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


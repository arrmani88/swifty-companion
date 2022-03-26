import 'package:flutter/material.dart';
import 'package:notifier_42/providers/ranking_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/pop_ups/loading_pop_up.dart';
import '../widgets/select_generations.dart';

class RankingsRoute extends StatefulWidget {
  const RankingsRoute({Key? key}) : super(key: key);

  @override
  State<RankingsRoute> createState() => _RankingsRouteState();
}
class _RankingsRouteState extends State<RankingsRoute> with TickerProviderStateMixin {
  late ScrollController scrollController;
  // bool isScrollToTopDisplayed = false;
  // bool isScrollToBottomDisplayed = true;
  late final AnimationController _controllerLeft = AnimationController(duration: const Duration(milliseconds: 500), vsync: this,);
  late final AnimationController _controllerRight = AnimationController(duration: const Duration(milliseconds: 500), vsync: this,);
  late final Animation<double> _animationLeft = CurvedAnimation(parent: _controllerLeft, curve: Curves.fastOutSlowIn);
  late final Animation<double> _animationRight = CurvedAnimation(parent: _controllerRight, curve: Curves.fastOutSlowIn);

  scrollToTop() => scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  scrollToBottom() => scrollController.animateTo(scrollController.position.maxScrollExtent,  duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() => setState(() {
        scrollController.offset > 600 ? _controllerLeft.forward() : _controllerLeft.reverse();
        scrollController.position.maxScrollExtent - 600 > scrollController.offset ? _controllerRight.forward() : _controllerRight.reverse();
      }));
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<RankingProvider>().setDropDownList();
      context.read<RankingProvider>().setRanking(context);
      _controllerRight.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: Center(
          child: (context.watch<RankingProvider>().isLoading == true)
              ? const SizedBox(width: 500, child: LoadingPopUp())
              : Stack(
                children: [
                  Column(
                    children: [
                      const SelectGeneration(),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: context.read<RankingProvider>().widgetsList,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(width: 15.0),
                        // if (isScrollToTopDisplayed == true)
                          SizeTransition(
                          sizeFactor: _animationLeft,
                          axis: Axis.horizontal,
                          axisAlignment: -1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            height: 40.0,
                            width: 40.0,
                            color: Theme.of(context).secondaryHeaderColor,
                            child: IconButton(padding: const EdgeInsets.all(2.0),
                              onPressed: scrollToTop,
                              icon: Icon(Icons.arrow_upward, size: 35.0, color: Theme.of(context).scaffoldBackgroundColor,),
                            ),
                          ),
                        ),
                        // if (isScrollToTopDisplayed == true)
                        //   const SizedBox(width: 5.0),
                        // if (isScrollToBottomDisplayed == true)
                          SizeTransition(
                            sizeFactor: _animationRight,
                            axis: Axis.horizontal,
                            axisAlignment: -1,
                            child: Container(
                            height: 40.0,
                            width: 40.0,
                            color: Theme.of(context).secondaryHeaderColor,
                            child: IconButton(padding: const EdgeInsets.all(2.0),
                              onPressed: scrollToBottom,
                              icon: Icon(Icons.arrow_downward, size: 29.0, color: Theme.of(context).scaffoldBackgroundColor,),
                            ),
                        ),
                          ),
                      ],),
                  )
                ],
              )
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

}


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
class _RankingsRouteState extends State<RankingsRoute> with TickerProviderStateMixin{
  late ScrollController scrollController;
  bool isScrollToTopDisplayed = false;
  bool isScrollToBottomDisplayed = true;

  scrollToTop() => scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() => setState(() {
        if (scrollController.offset >= 400) {
          isScrollToTopDisplayed = true;
        } else {
          isScrollToTopDisplayed = false;
        }
      }));
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<RankingProvider>().setDropDownList();
      context.read<RankingProvider>().setRanking();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(children: [
        FloatingActionButton(onPressed: scrollToTop, child: const Icon(Icons.arrow_upward),)
      ],),
      body: Container(
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: Center(
          child: (context.watch<RankingProvider>().isLoading == true)
              ? const SizedBox(width: 500, child: LoadingPopUp())
              : Column(
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

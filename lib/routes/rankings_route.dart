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
  scrollToBottom() => scrollController.animateTo(scrollController.position.maxScrollExtent,  duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() => setState(() {
          print('...${scrollController.offset}...');
          print(scrollController.position.maxScrollExtent);
          isScrollToTopDisplayed = scrollController.offset >= 600 ? true : false;
          isScrollToBottomDisplayed = scrollController.position.maxScrollExtent - 600 > scrollController.offset ? true : false;
        }
      ));
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<RankingProvider>().setDropDownList();
      context.read<RankingProvider>().setRanking();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 15.0),
            // if (isScrollToTopDisplayed == true)
              Container(
              height: 40.0,
              width: 40.0,
              color: Theme.of(context).secondaryHeaderColor,
              child: IconButton(padding: const EdgeInsets.all(2.0),
                onPressed: scrollToTop,
                icon: Icon(Icons.arrow_upward, size: 35.0, color: Theme.of(context).scaffoldBackgroundColor,),
              ),
            ),
            const SizedBox(width: 5.0),
            // if (isScrollToBottomDisplayed == true)
              Container(
              height: 40.0,
              width: 40.0,
              color: Theme.of(context).secondaryHeaderColor,
              child: IconButton(padding: const EdgeInsets.all(2.0),
                onPressed: scrollToBottom,
                icon: Icon(Icons.arrow_downward, size: 29.0, color: Theme.of(context).scaffoldBackgroundColor,),
              ),
            ),
        ],),
      ),
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


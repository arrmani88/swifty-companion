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
class _RankingsRouteState extends State<RankingsRoute> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<RankingProvider>().setRanking();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (context.watch<RankingProvider>().isLoading == true)
        ? const SizedBox(width: 500, child: LoadingPopUp())
        : Column(
          children: [
            const SelectGeneration(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: context.read<RankingProvider>().widgetsList[context.watch<RankingProvider>().selectedGeneration]!,
                ),
              ),
            ),
          ],
        ),
    );
  }
}

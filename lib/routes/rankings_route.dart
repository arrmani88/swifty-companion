import 'package:flutter/material.dart';
import 'package:notifier_42/providers/ranking_provider.dart';
import 'package:provider/provider.dart';

class RankingsRoute extends StatelessWidget {
  const RankingsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RankingProvider>().getAllGenerations();
    return Container();
  }
}

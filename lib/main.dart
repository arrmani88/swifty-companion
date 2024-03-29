import 'package:flutter/material.dart';
import 'package:notifier_42/providers/pop_up_provider.dart';
import 'package:notifier_42/providers/ranking_provider.dart';
import 'package:notifier_42/routes/search_route.dart';
import 'package:notifier_42/routes/authorization_route.dart';
import 'package:notifier_42/routes/profile_route.dart';
import 'package:notifier_42/constants/constants.dart';
import 'globals/globals.dart';
import 'routes/splash_route.dart';
import 'routes/routes_holder.dart';
import 'routes/projects_route.dart';
import 'package:provider/provider.dart';
import 'package:notifier_42/providers/user_provider.dart';
import 'package:notifier_42/providers/cluster_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'providers/target_provider.dart';
import 'providers/processes_organizer_provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(targetedItemsBoxName);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PopUpProvider()),
      ChangeNotifierProvider(create: (_) => ProcessesOrganizerProvider()),
      // ChangeNotifierProvider(create: (_) => UserProvider(null)),
      ChangeNotifierProxyProvider<ProcessesOrganizerProvider, UserProvider>(
          create: (_) => UserProvider(null),
          update: (_, organizer, userProvider) => userProvider!
      ),
      ChangeNotifierProxyProvider<ProcessesOrganizerProvider, ClustersProvider>(
          create: (_) => ClustersProvider(null),
          update: (_, organizer, clustersProvider) => clustersProvider!
      ),
      ChangeNotifierProxyProvider<ProcessesOrganizerProvider, TargetProvider>(
          create: (_) => TargetProvider(null),
          update: (_, organizer, targetProvider) => targetProvider!
      ),
      // ChangeNotifierProxyProvider<ProcessesOrganizerProvider, RankingProvider>(
      //     create: (_) => RankingProvider(null),
      //     update: (_, organizer, rankingProvider) => rankingProvider!
      // ),
      ChangeNotifierProvider(create: (_) => RankingProvider())
    ],
    child: const Notifier42()
  ));
}

class Notifier42 extends StatefulWidget {
  const Notifier42({Key? key}) : super(key: key);
  @override
  State<Notifier42> createState() => _Notifier42State();
}

class _Notifier42State extends State<Notifier42> {

  @override
  void initState() {
    super.initState();
    setScreenDimensions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'weiss',
        scaffoldBackgroundColor: const Color(0xff042925),
        splashColor: const Color(0xff167676),
        secondaryHeaderColor: const Color(0xff79AB98),
        canvasColor: const Color(0xffE5E5E5),
        // beige: const Color(0xffe8e4d1),
      ),
      initialRoute: 'splash_route',
      routes: {
        'splash_route': (context) => const SplashRoute(),
        'authorization_route': (context) => AuthorizationRoute(),
        'home_route': (context) => SearchRoute(),
        'profile_route': (context) => ProfileRoute(),
        'routes_holder': (context) => RoutesHolder(),
        'projects': (context) => ProjectsRoute(),
      },
    );
  }
}

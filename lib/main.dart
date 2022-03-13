import 'package:flutter/material.dart';
import 'package:swifty_companion/providers/pop_up_provider.dart';
import 'package:swifty_companion/routes/home_route.dart';
import 'package:swifty_companion/routes/authorization_route.dart';
import 'package:swifty_companion/routes/profile_route.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'routes/splash_route.dart';
import 'routes/routes_holder.dart';
import 'routes/projects_route.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/providers/user_provider.dart';
import 'package:swifty_companion/providers/cluster_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => PopUpProvider()),
      ChangeNotifierProvider(create: (_) => ClustersProvider())
    ],
    child: SwiftyCompanion()
  ));
}
class SwiftyCompanion extends StatefulWidget {
  const SwiftyCompanion({Key? key}) : super(key: key);
  @override
  State<SwiftyCompanion> createState() => _SwiftyCompanionState();
}
class _SwiftyCompanionState extends State<SwiftyCompanion> {

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
        'splash_route': (context) => SplashRoute(),
        'authorization_route': (context) => AuthorizationRoute(),
        'home_route': (context) => HomeRoute(),
        'profile_route': (context) => ProfileRoute(),
        'routes_holder': (context) => RoutesHolder(),
        'projects': (context) => ProjectsRoute(),
      },
    );
  }
}


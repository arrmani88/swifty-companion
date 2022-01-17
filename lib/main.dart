import 'package:flutter/material.dart';
import 'package:swifty_companion/routes/home_route.dart';
import 'routes/profile_route.dart';
import 'package:swifty_companion/constants/constants.dart';

void main() {
  runApp(const SwiftyCompanion());
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
      initialRoute: 'profile_route',
      routes: {
        'home_route': (context) => HomeRoute(),
        'profile_route': (context) => ProfileRoute()
      },
    );
  }
}

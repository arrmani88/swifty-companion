import 'package:flutter/material.dart';
import 'package:swifty_companion/routes/home_route.dart';
import 'routes/profile_route.dart';

void main() {
  runApp(SwiftyCompanion());
}
class SwiftyCompanion extends StatelessWidget {
  const SwiftyCompanion({Key? key}) : super(key: key);

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
      initialRoute: 'home_route',
      routes: {
        'home_route': (context) => HomeRoute(),
        'profile_route': (context) => ProfileRoute()
      },
    );
  }
}

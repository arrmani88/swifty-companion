import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/routes/profile_route.dart';
import 'package:swifty_companion/routes/projects_route.dart';

class RoutesHolder extends StatefulWidget {
  const RoutesHolder({Key? key}) : super(key: key);

  @override
  State<RoutesHolder> createState() => _RoutesHolderState();
}
class _RoutesHolderState extends State<RoutesHolder> {
  late PageController _pageController;
  int selectedIndex = 0;

  List<BarItem> navBarItems = [
    BarItem(title: 'Profile', icon: Icons.account_box_sharp),
    BarItem(title: 'Projects', icon: Icons.task_sharp)
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: PageView(
          controller: _pageController,
          children: [
            ProfileRoute(),
            ProjectsRoute()
          ],
        ),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        iconSize: 25.0,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        onButtonPressed: (int index) {
          setState(() => selectedIndex = index);
          _pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 600), curve: Curves.easeOutQuad);
        },
        barItems: navBarItems,
        activeColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: selectedIndex,
      ),
    );
  }
}


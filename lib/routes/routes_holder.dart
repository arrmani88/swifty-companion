import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/routes/profile_route.dart';
import 'package:swifty_companion/routes/projects_route.dart';
import 'package:swipedetector/swipedetector.dart';

class RoutesHolder extends StatefulWidget {
  const RoutesHolder({Key? key}) : super(key: key);

  @override
  State<RoutesHolder> createState() => _RoutesHolderState();
}
class _RoutesHolderState extends State<RoutesHolder> {
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  int swipeDirection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: Listener(
          onPointerMove: (moveEvent) {
            if (moveEvent.delta.dx > 0)
              swipeDirection = -1;
            if (moveEvent.delta.dx < 0)
              swipeDirection =  1;
          },
          onPointerUp: (_) {
            if (selectedIndex > -1 && selectedIndex < 2) {
              _pageController.animateToPage(selectedIndex + swipeDirection,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad);
            }
          },
          child: PageView(
            controller: _pageController,
            children: [
              ProfileRoute(),
              ProjectsRoute()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: Container(
          width: 500.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Theme.of(context).secondaryHeaderColor,
          ),
          child: SalomonBottomBar(

            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
            itemPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            currentIndex: selectedIndex,
            onTap: (i) => setState(() {
              _pageController.animateToPage(i, duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
              selectedIndex = i;
            }),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.account_box_sharp),
                title: const Text('Porfile'),
                selectedColor: Theme.of(context).splashColor,
              ),
              SalomonBottomBarItem(
                icon:  const Icon(Icons.task_sharp),
                title:  const Text('Projects'),
                selectedColor: Theme.of(context).splashColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Icons.account_box_sharp
Icons.task_sharp
* */

/*
SlidingClippedNavBar(
        iconSize: 25.0,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        onButtonPressed: (int index) {
          setState(() => selectedIndex = index);
          _pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 600), curve: Curves.easeOutQuad);
        },
        barItems: navBarItems,
        activeColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: selectedIndex,
      )
* */
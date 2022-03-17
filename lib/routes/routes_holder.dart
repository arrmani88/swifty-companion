import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/routes/profile_route.dart';
import 'package:swifty_companion/routes/projects_route.dart';
import 'package:swifty_companion/routes/clusters_route.dart';
import 'package:swifty_companion/routes/target_route.dart';
import 'package:swifty_companion/routes/rankings_route.dart';
import 'package:swifty_companion/widgets/keep_widget_alive.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/routes/notifications_route.dart';

class RoutesHolder extends StatefulWidget {
  const RoutesHolder({Key? key}) : super(key: key);

  @override
  State<RoutesHolder> createState() => _RoutesHolderState();
}
class _RoutesHolderState extends State<RoutesHolder> {
  int selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            KeepWidgetAlive(child: const ProfileRoute()),
            KeepWidgetAlive(child: ProjectsRoute()),
            KeepWidgetAlive(child: const ClustersRoute()),
            KeepWidgetAlive(child: const RankingsRoute()),
            KeepWidgetAlive(child: const TargetRoute()),
            KeepWidgetAlive(child: const NotificationsRoute())
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: Container(
          width: 500.0,
          decoration: BoxDecoration(color: Theme.of(context).secondaryHeaderColor,),
          child: SalomonBottomBar(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            itemPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            currentIndex: selectedIndex,
            onTap: (i) => setState(() {
              pageController.animateToPage(i, duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
              selectedIndex = i;
            }),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.account_box_sharp),
                title: const Text('Porfile'),
                selectedColor: Theme.of(context).splashColor,
                unselectedColor: Theme.of(context).scaffoldBackgroundColor
              ),
              SalomonBottomBarItem(
                icon:  const Icon(Icons.task_sharp),
                title:  const Text('Projects'),
                selectedColor: Theme.of(context).splashColor,
                unselectedColor: Theme.of(context).scaffoldBackgroundColor
              ),
              SalomonBottomBarItem(
                icon:  const ImageIcon(AssetImage('assets/icons/compass_icon.png'), size: 25.0,),
                title:  const Text('Clusters'),
                selectedColor: Theme.of(context).splashColor,
                unselectedColor: Theme.of(context).scaffoldBackgroundColor
              ),
              SalomonBottomBarItem(
                icon:  const Icon(Icons.format_list_numbered_sharp),
                title:  const Text('Rankings'),
                selectedColor: Theme.of(context).splashColor,
                unselectedColor: Theme.of(context).scaffoldBackgroundColor
              ),
              SalomonBottomBarItem(
                  icon:  const ImageIcon(AssetImage('assets/icons/target_icon.png'), size: 25.0,),
                  title:  const Text('Target'),
                  selectedColor: Theme.of(context).splashColor,
                  unselectedColor: Theme.of(context).scaffoldBackgroundColor
              ),
              SalomonBottomBarItem(
                  icon:  const Icon(Icons.notifications),
                  title:  const Text('Notifs'),
                  selectedColor: Theme.of(context).splashColor,
                  unselectedColor: Theme.of(context).scaffoldBackgroundColor
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
    pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 600), curve: Curves.easeOutQuad);
  },
  barItems: navBarItems,
  activeColor: Theme.of(context).scaffoldBackgroundColor,
  selectedIndex: selectedIndex,
      )
* */
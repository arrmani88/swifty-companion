import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/providers/target_provider.dart';

import '../widgets/targeted_item.dart';

class TargetSection extends StatefulWidget {
  final String title;
  final List<Widget> children;
  const TargetSection({Key? key, required this.title, required this.children}) : super(key: key);
  @override
  _TargetSectionState createState() => _TargetSectionState();
}
class _TargetSectionState extends State<TargetSection> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.key} ===> ${widget.children}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              isOpened = !isOpened;
              isOpened == true ? controller.forward() : controller.reverse();
            }),
            child: Container(
              color: Theme.of(context).secondaryHeaderColor,
              width: 500.0,
              height: 60.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 5.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title, style: const TextStyle(fontSize: 30.0)),
                    (isOpened == false) ? const Icon(Icons.arrow_downward) : const Icon(Icons.arrow_upward)
                  ],
                ),
              )
            ),
          ),
          Container(
            width: 500.0,
            color: Colors.black.withOpacity(0.4),
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: -1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.children,
              ),
            )
          )
        ],
      ),
    );
  }
}

class TargetRoute extends StatelessWidget {
  const TargetRoute({Key? key}) : super(key: key);

  List<Widget> getWidgetsList(BuildContext context, String key) {
    List<Widget> ret = [];
    for (Map<String, dynamic> item in context.watch<TargetProvider>().targetedItemsData[key]!) {
      ret.add(TargetedItem(item: item, targetedIsAUser: key == 'targeted_users' ? true : false));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 15.0),
            TargetSection(title: 'Targeted workstations', children: getWidgetsList(context, 'targeted_hosts')),
            TargetSection(title: 'Targeted users', children: getWidgetsList(context, 'targeted_users')),
          ],
        ),
      ),
    );
  }
}
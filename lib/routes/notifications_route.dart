import 'package:flutter/material.dart';

import '../widgets/targeted_item.dart';

class NotificationTab extends StatefulWidget {
  final String title;
  const NotificationTab({Key? key, required this.title}) : super(key: key);
  @override
  _NotificationTabState createState() => _NotificationTabState();
}
class _NotificationTabState extends State<NotificationTab> with SingleTickerProviderStateMixin {
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
                children: [
                  TargetedItem(item: {'login': 'anel-bou'}),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}

class NotificationsRoute extends StatelessWidget {
  const NotificationsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: const [
            SizedBox(height: 15.0),
            NotificationTab(title: 'Targeted users'),
            NotificationTab(title: 'Targeted workstations')
          ],
        ),
      ),
    );
  }
}

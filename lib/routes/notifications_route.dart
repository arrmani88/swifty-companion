import 'package:flutter/material.dart';

class NotificationTab extends StatefulWidget {
  final String title;
  const NotificationTab({Key? key, required this.title}) : super(key: key);
  @override
  _NotificationTabState createState() => _NotificationTabState();
}
class _NotificationTabState extends State<NotificationTab> with SingleTickerProviderStateMixin {
  final AnimationController controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  final Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: Theme.of(context).secondaryHeaderColor,
      width: 500.0,
      height: 60.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 5.0, 20.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 27.0)),
            Icon(Icons.arrow_downward)
          ],
        ),
      )
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
            const SizedBox(height: 15.0),
            NotificationTab(title: 'Targeted users'),
            NotificationTab(title: 'Targeted workstations')
          ],
        ),
      ),
    );
  }
}

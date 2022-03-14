import 'package:flutter/material.dart';

class KeepWidgetAlive extends StatefulWidget {
  Widget child;
  KeepWidgetAlive({Key? key, required this.child}) : super(key: key);

  @override
  _KeepWidgetAliveState createState() => _KeepWidgetAliveState();
}
class _KeepWidgetAliveState extends State<KeepWidgetAlive> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notifier_42/classes/project.dart';
import 'package:notifier_42/functions/parse_project_status.dart';
import 'package:notifier_42/widgets/project_mark_box.dart';
import 'package:notifier_42/widgets/marquee_widget.dart';

class ItemProject extends StatefulWidget {
  Project project;
  ItemProject({Key? key, required this.project}) : super(key: key);

  @override
  State<ItemProject> createState() => _ItemProjectState();
}
class _ItemProjectState extends State<ItemProject> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 00.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 500.0,
        // height: 105.0,
        color: Colors.black.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 170.0,
                  child: MarqueeWidget(child: Text(widget.project.title, style: TextStyle(color: Colors.white, fontSize: 25),)),
                ),
                Text(parseProjectStatus(widget.project.status), style: TextStyle(color: Colors.white60))
              ],
            ),
            ProjectMarkBox(project: widget.project)
          ],
        ),
      ),
    );
  }
}

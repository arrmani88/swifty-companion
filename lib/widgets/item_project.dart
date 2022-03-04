import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swifty_companion/classes/project.dart';
import 'package:swifty_companion/functions/parse_project_status.dart';
import 'package:swifty_companion/widgets/project_mark_box.dart';

class ItemProject extends StatelessWidget {

  Project project;
  ItemProject({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 500.0,
        height: 100.0,
        color: Colors.black.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title, style: TextStyle(color: Colors.white, fontSize: 30),),
                Text(parseProjectStatus(project.status), style: TextStyle(color: Colors.white60))
              ],
            ),
            ProjectMarkBox(project: project)
          ],
        ),
      ),
    );
  }
}

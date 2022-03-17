import 'package:flutter/material.dart';
import 'package:notifier_42/globals/globals.dart';
import 'package:notifier_42/classes/project.dart';
import 'package:notifier_42/constants/constants.dart';

class ProjectMarkBox extends StatelessWidget {
  Project project;
  ProjectMarkBox({Key? key, required this.project}) : super(key: key);

  Color getColor(var status) {
    switch (status) {
      case(Status.validated): return kValidatedColor;
      case(Status.failed): return kFailedColor;
    }
    return kSubscribedColor;
  }

  Icon getIcon(var status) {
    switch (status) {
      case(Status.validated): return const Icon(Icons.check, size: 35.0,);
      case(Status.failed): return const Icon(Icons.close, size: 35.0,);
    }
    return const Icon(Icons.flash_on_rounded, size: 35.0,);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, right: 3.0),
      color: getColor(project.status),
      height: 60.0,
      width: 115.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getIcon(project.status),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                project.finalMark != null ? project.finalMark.toString() : '...',
                style: const TextStyle(color: Colors.black, fontSize: 30.0)
              ),
              const Text('/100', style: TextStyle(color: Colors.black, fontSize: 13.0))
            ],
          ),
        ],
      ),
    );
  }
}

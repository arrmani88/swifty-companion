import 'package:flutter/material.dart';
import 'package:notifier_42/constants/constants.dart';
import 'package:notifier_42/widgets/item_project.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:notifier_42/globals/globals.dart';
import 'package:notifier_42/classes/project.dart';
import 'package:provider/provider.dart';
import 'package:notifier_42/providers/user_provider.dart';

class ProjectsRoute extends StatelessWidget {
  ProjectsRoute({Key? key}) : super(key: key);
  final OutlineInputBorder border = OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(0.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: kScreenHeight,
          width: kScreenWidth,
          decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30.0),
            child: Column(
              children: [
                Expanded(
                  child: SearchableList<Project>(
                    initialList: context.watch<UserProvider>().projectsList,
                    builder: (dynamic project) => ItemProject(project: project),
                    filter: (search) {
                      return context.read<UserProvider>().projectsList.where((element) {
                        return element.title.toLowerCase().contains(search) || element.status.toString().contains(search);
                      }).toList();
                    },
                    inputDecoration: InputDecoration(
                      label: const Text('Enter login', style: TextStyle(color: Colors.white)),
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

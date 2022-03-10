import 'package:flutter/material.dart';

class WorkStation extends StatelessWidget {
  final bool isVacant;
  const WorkStation({Key? key, required this.isVacant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isVacant == true)
    ? Container(height: 10.0, width: 5.0, decoration: BoxDecoration(border: Border.all(color: Theme.of(context).secondaryHeaderColor)),)
    : Container();
  }
}

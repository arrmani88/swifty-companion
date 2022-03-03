import 'package:flutter/material.dart';

class IntraInfo extends StatelessWidget {
  final String title;
  final String value;
  const IntraInfo({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Theme.of(context).secondaryHeaderColor)),
            ),
          ),
          const SizedBox(width: 7.0),
          Expanded(
            child:Text(value, style: const TextStyle(fontSize: 20.0, color: Colors.white))
          ),
        ],
      ),
    );
  }
}

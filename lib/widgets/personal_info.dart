import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  final IconData icon;
  final String value;
  const PersonalInfo({Key? key, required this.icon, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).secondaryHeaderColor,),
          const SizedBox(width: 8.0),
          Text(value, style: TextStyle(fontSize: 20.0, color: Colors.white))
        ],
      ),
    );
  }
}

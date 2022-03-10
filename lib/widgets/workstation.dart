import 'package:flutter/material.dart';

class WorkStation extends StatelessWidget {
  final String host;
  final List userData;
  const WorkStation({Key? key, required this.host, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (userData.isEmpty)
          ? Container(height: 10.0, width: 5.0, decoration: BoxDecoration(border: Border.all(color: Theme.of(context).secondaryHeaderColor)),)
          : Image.network(
            userData[1],
            fit: BoxFit.fitHeight,
            errorBuilder: (context, exception, stackTrace) {
              return Image.asset('assets/images/blank_profile_picture.png');
            }
          ),
        Text(host, style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),)
      ],
    );
  }
}

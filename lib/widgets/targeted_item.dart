import 'package:flutter/material.dart';

class TargetedItem extends StatelessWidget {
  Map<String, dynamic> item;
  TargetedItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
            height: 50.0,
            width: 50.0,
            child: Image.network(
              'https://cdn.intra.42.fr/users/anel-bou.jpg',
              fit: BoxFit.fitWidth,
              errorBuilder: (context, exception, stackTrace) {
                return Image.asset('assets/images/blank_profile_picture.png');
              },
            )
          ),
          Text(item['login'], style: const TextStyle(color: Colors.white, fontSize: 20.0),)
        ],
      ),
    );
  }
}

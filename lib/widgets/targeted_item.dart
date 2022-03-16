import 'package:flutter/material.dart';

class TargetedItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool targetedIsAUser;
  const TargetedItem({Key? key, required this.item, required this.targetedIsAUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (targetedIsAUser == true)
                    ? Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(2.0),
                    margin: const EdgeInsets.fromLTRB(20.0, 0, 15.0, 0),
                    child: Container(
                        height: 50.0,
                        width: 50.0,
                        child: Image.network(
                          'https://cdn.intra.42.fr/users/${item['login']}.jpg',
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, exception, stackTrace) {
                            return Image.asset('assets/images/blank_profile_picture.png');
                          },
                        )
                    ),
                  )
                  : Padding(child: Image.asset('assets/images/imac_image.png', width: 50.0), padding: const EdgeInsets.fromLTRB(20.0, 0, 15.0, 0),),
                  Text(item[targetedIsAUser == true ? 'login' : 'host'], style: const TextStyle(color: Colors.white, fontSize: 20.0),)
                ],
              ),
              const Padding(child: Icon(Icons.delete_sharp, color: Colors.white), padding: EdgeInsets.only(right: 18.0),)
            ],
          ),
        ),
        Padding(child: Divider(color: Theme.of(context).splashColor, height: 0), padding: const EdgeInsets.symmetric(horizontal: 40.0),)
      ],
    );
  }
}

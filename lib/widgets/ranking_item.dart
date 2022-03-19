import 'package:flutter/material.dart';

class RankingItem extends StatelessWidget {
  final int rank;
  const RankingItem({Key? key, required this.rank}) : super(key: key);

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
                  const SizedBox(width: 20.0),
                  Text(rank.toString(), style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold, color: Theme.of(context).secondaryHeaderColor)),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(2.0),
                    margin: const EdgeInsets.fromLTRB(20.0, 0, 15.0, 0),
                    child: SizedBox(
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
                  ),
                  Text('anel-bou', style: const TextStyle(color: Colors.white, fontSize: 20.0),)
                ],
              ),
              InkWell(
                  onTap: () {},
                  child: const Padding(child: Text('18.89', style: TextStyle(color: Colors.white, fontSize: 18.0),), padding: EdgeInsets.only(right: 50.0),)
              )
            ],
          ),
        ),
        Padding(child: Divider(color: Theme.of(context).splashColor, height: 0), padding: const EdgeInsets.symmetric(horizontal: 40.0),)
      ],
    );
  }
}

import 'package:flutter/material.dart';

class RankingItem extends StatelessWidget {
  final int rank;
  final String login;
  final double level;
  const RankingItem({Key? key, required this.rank, required this.login, required this.level}) : super(key: key);

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
                  const SizedBox(width: 10.0),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 68.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: Text(rank.toString(), style: TextStyle(height: 0.8, fontSize: 40.0, fontWeight: FontWeight.bold, color: Theme.of(context).secondaryHeaderColor)),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(2.0),
                    margin: const EdgeInsets.fromLTRB(7.0, 0, 15.0, 0),
                    child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Image.network(
                          'https://cdn.intra.42.fr/users/$login.jpg',
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, exception, stackTrace) {
                            return Image.asset('assets/images/blank_profile_picture.png');
                          },
                        )
                    ),
                  ),
                  Text(login, style: const TextStyle(color: Colors.white, fontSize: 20.0),)
                ],
              ),
              InkWell(
                  onTap: () {},
                  child: Padding(child: Text(level.toStringAsFixed(2), style: const TextStyle(color: Colors.white, fontSize: 18.0),), padding: EdgeInsets.only(right: 50.0),)
              )
            ],
          ),
        ),
        SizedBox(width: 150.0, child: Divider(color: Theme.of(context).splashColor, height: 0))
      ],
    );
  }
}

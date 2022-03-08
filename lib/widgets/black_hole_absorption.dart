import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/providers/user_provider.dart';

class BlackHoleAbsorption extends StatelessWidget {
  const BlackHoleAbsorption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final String text =
    'Black hole: '
    + (context.read<UserProvider>().blackHoleAbsorption[context.watch<UserProvider>().selectedCursus])!.toString()
    + ' days left';
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(const AssetImage('assets/icons/black_hole.png'), color: Theme.of(context).secondaryHeaderColor,),
          const SizedBox(width: 8.0),
          Text(text, style: const TextStyle(fontSize: 20.0, color: Colors.white))
        ],
      ),
    );
  }
}

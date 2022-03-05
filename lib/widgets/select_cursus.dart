import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swifty_companion/classes/user.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/providers/user_provider.dart';

class SelectCursus extends StatefulWidget {
  const SelectCursus({Key? key}) : super(key: key);
  @override _SelectCursusState createState() => _SelectCursusState();
}
class _SelectCursusState extends State<SelectCursus> {
  List<DropdownMenuItem<String>>? cursuses = [];

  @override
  void initState() {
    for (String cursus in context.read<UserProvider>().cursusNames) {
      cursuses!.add(DropdownMenuItem(value: cursus, child: FittedBox(child: Text(cursus), fit: BoxFit.fitWidth,),));
    }
    super.initState();
  }

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
              child: Text('Cursus', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Theme.of(context).secondaryHeaderColor)),
            ),
          ),
          const SizedBox(width: 7.0),
          Expanded(
            child: SizedBox(
              width: 1,
              child: DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                underline: Container(height: 2, color: Theme.of(context).secondaryHeaderColor,),
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_downward, color: Colors.white,),
                value: context.watch<UserProvider>().selectedCursus,
                items: cursuses,
                onChanged: (newValue) => setState(() {
                  context.read<UserProvider>().updateSelectedCursus(newValue!);
                  context.read<UserProvider>().parseUserVariableData();
                }),
              ),
            )
          ),
        ],
      ),
    );
  }
}

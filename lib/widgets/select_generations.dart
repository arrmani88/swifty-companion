import 'package:flutter/material.dart';
import 'package:notifier_42/providers/ranking_provider.dart';
import 'package:provider/provider.dart';

class SelectGeneration extends StatefulWidget {
  const SelectGeneration({Key? key}) : super(key: key);

  @override
  _SelectGenerationState createState() => _SelectGenerationState();
}
class _SelectGenerationState extends State<SelectGeneration> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 7,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('Generation', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Theme.of(context).secondaryHeaderColor)),
            ),
          ),
          const SizedBox(width: 7.0),
          Expanded(
            flex: 4,
              child: SizedBox(
                width: 1,
                child: DropdownButton<String>(
                  dropdownColor: Theme.of(context).secondaryHeaderColor,
                  isDense: true,
                  isExpanded: true,
                  underline: Container(height: 2, color: Theme.of(context).secondaryHeaderColor,),
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_downward, color: Colors.white,),
                  value: context.watch<RankingProvider>().selectedGeneration,
                  items: context.read<RankingProvider>().dropDownList,
                  onChanged: (newValue) => setState(() {
                    context.read<RankingProvider>().updateSelectedGeneration(newValue!);
                  }),
                ),
              )
          ),
        ],
      ),
    );
  }
}


/*
      value: 'text1',
      items: const [
        DropdownMenuItem(value: 'text1', child: Text('text1')),
        DropdownMenuItem(value: 'text2', child: Text('text2'))
      ],
*/
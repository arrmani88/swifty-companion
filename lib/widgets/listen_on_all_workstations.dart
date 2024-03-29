import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/target_provider.dart';
import '../providers/user_provider.dart';

class ListenOnAllWorkstations extends StatefulWidget {
  const ListenOnAllWorkstations({Key? key}) : super(key: key);
  @override _ListenOnAllWorkstationsState createState() => _ListenOnAllWorkstationsState();
}
class _ListenOnAllWorkstationsState extends State<ListenOnAllWorkstations> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
      child: (context.watch<TargetProvider>().areAllWorkstationsTargeted == false)
        ? InkWell(
          onTap: () {
            context.read<TargetProvider>().detargetAllWorkstations();
          },
          child: Container(
            width: 500.0,
            color: Colors.black.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_off_outlined, color: Colors.white,),
                  const SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Click to get notified when any workstations are free',
                      style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 15.0),),
                  ),
                ],
              ),
            ),
          ),
        )
        : InkWell(
          onTap: () {
            context.read<TargetProvider>().detargetAllWorkstations();
          },
          child: Container(
            width: 500.0,
            color: Theme.of(context).secondaryHeaderColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_active_sharp, color: Colors.black.withOpacity(0.4),),
                  const SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Click to cancel notification if any workstations are free',
                      style: TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w800, fontSize: 15.0),),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

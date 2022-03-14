import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class GetNotified extends StatefulWidget {
  const GetNotified({Key? key}) : super(key: key);

  @override
  _GetNotifiedState createState() => _GetNotifiedState();
}
class _GetNotifiedState extends State<GetNotified> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
      child: (context.watch<UserProvider>().isUserTargeted == false)
          ? InkWell(
            onTap: () => context.read<UserProvider>().targetThisUser(),
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
                          (context.watch<UserProvider>().location != null)
                              ? 'Click to get notified when this workstation is free'
                              : 'Click to get notified when this user logs in',
                          style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 15.0),),
                      ),
                    ],
                  ),
                ),
              ),
          )
          : InkWell(
              onTap: () => context.read<UserProvider>().detargetThisUser(),
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
                          (context.watch<UserProvider>().location != null)
                              ? 'Click to cancel notification for this workstation'
                              : 'Click to cancel notification for this user',
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


/*
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: 500.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (context.watch<UserProvider>().isUserTargeted)
              ? const Icon(Icons.notifications_active_sharp, color: Colors.white,)
              : const Icon(Icons.notifications_off_outlined, color: Colors.white),
            const SizedBox(width: 5.0),
            Text(
              (context.watch<UserProvider>().isUserTargeted)
                ? 'Click to get notified when this work station is free'
                : 'Click to cancel notification for this work station',
              style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
*/
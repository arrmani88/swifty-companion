import 'package:flutter/material.dart';
import 'package:swifty_companion/globals/globals.dart';

class WorkStation extends StatelessWidget {
  final String? host;
  final List? userData;
  final PushWorkStationTo pushWorkStationTo;
  final bool isDoorFacing;

  const WorkStation({Key? key, this.host, this.userData, required this.pushWorkStationTo, required this.isDoorFacing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 1.0,
          right: 1.0,
          bottom: (pushWorkStationTo == PushWorkStationTo.top && isDoorFacing == true ? 30.0 : 0.0),
          top: (pushWorkStationTo == PushWorkStationTo.bottom && isDoorFacing == true ? 30.0 : 0.0),
        ),
        child: (host == null)
          ? const SizedBox(height: 55.0, width: 45.0,)
          : Column(
              children: [
                Container(
                  height: 55.0,
                  width: 45.0,
                  decoration: BoxDecoration(border: Border.all(color: Theme.of(context).secondaryHeaderColor)),
                  child: (userData == null)
                    ? const SizedBox(height: 10.0, width: 5.0)
                    : Image.network(
                      userData![1],
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset('assets/images/blank_profile_picture.png', fit: BoxFit.fitHeight,);
                      }
                    ),
                ),
                SizedBox(
                  width: 45.0,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(host!, style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),)
                  ),
                )
              ],
          )
    );
  }
}

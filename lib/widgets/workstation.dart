import 'package:flutter/material.dart';

class WorkStation extends StatelessWidget {
  final String? host;
  final List? userData;

  const WorkStation({Key? key, this.host, this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: (host == null)
          ? const SizedBox(height: 55.0, width: 45.0,)
          : Column(
              children: [
                SizedBox(
                  height: 55.0,
                  width: 45.0,
                  child: (userData == null)
                    ? Container(height: 10.0, width: 5.0, decoration: BoxDecoration(border: Border.all(color: Theme.of(context).secondaryHeaderColor)),)
                    : Image.network(
                      userData![1],
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset('assets/images/blank_profile_picture.png', fit: BoxFit.fitHeight,);
                      }
                    ),
                ),
                Text(host!, style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),)
              ],
          )
    );
  }
}

/*

    Column(
      children: [
        Container(
          height: 55.0,
          width: 45.0,
          child: (userData.isEmpty)
          ? Container(height: 10.0, width: 5.0, decoration: BoxDecoration(border: Border.all(color: Theme.of(context).secondaryHeaderColor)),)
          : Image.network(
            userData[1],
            fit: BoxFit.fitWidth,
            errorBuilder: (context, exception, stackTrace) {
              return Image.asset('assets/images/blank_profile_picture.png', fit: BoxFit.fitHeight,);
            }
          ),
        ),
        Text(host!, style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),)
      ],
    )

*/

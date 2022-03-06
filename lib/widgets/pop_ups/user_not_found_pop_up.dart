import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../../providers/pop_up_provider.dart';


class UserNotFoundPopUp extends StatelessWidget {
  const UserNotFoundPopUp({Key? key}) : super(key: key);
  final String titleMessage = 'Oops! User not found ...';
  final String descriptionMessage = 'The user that you are looking for doesn\'t exists.';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<PopUpProvider>().hideUserNotFoundPopUp(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.6),
              // height: 200.0,
              width: 500.0,
              child: Stack(
                children: [
                  Positioned(child: Image.asset('assets/images/not_found.png', height: 110.0), left: 15, bottom: 12.0,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        width: 425.0,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(titleMessage, style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 125.0, right: 13.0),
                        child: Text(descriptionMessage, style: const TextStyle(color: Color(0xffa3a3a3), fontSize: 15.0), textAlign: TextAlign.start,),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                          width: 100.0,
                          color: Colors.black,
                          child: const Center(child:
                          Padding(
                            padding: EdgeInsets.only(top: 1.5),
                            child: Text(
                              'OK',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, height: 1.5, fontSize: 20),
                            ),
                          ),
                          )
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

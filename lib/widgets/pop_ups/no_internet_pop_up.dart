import 'package:flutter/material.dart';
import 'dart:ui';

class NoInternetPopUp extends StatelessWidget {
  final Function closePopUp;
  const NoInternetPopUp({Key? key, required this.closePopUp}) : super(key: key);
  final String descriptionMessage = 'Either your device isn\'t connected to the internet, or the server that you are looking for is down';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => closePopUp(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.6),
              height: 200.0,
              width: 500.0,
              child: Stack(
                children: [
                  Positioned(child: Image.asset('assets/icons/broken_robot.png', height: 140.0), left: 10, bottom: 0,),
                  Column(
                    children: [
                      const SizedBox(height: 30.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        width: 425.0,
                        child: const FittedBox(
                          fit: BoxFit.fill,
                          child: Text('Oops, something went wrong!', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 110.0, right: 13.0),
                        child: Text(descriptionMessage, style: const TextStyle(color: Color(0xffa3a3a3), fontSize: 15.0), textAlign: TextAlign.end,),
                      )
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

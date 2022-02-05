import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:ui';

class LoadingPopUp extends StatelessWidget {
  const LoadingPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.black.withOpacity(0.6),
            height: 200.0,
            width: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Loading ...', style: TextStyle(color: Colors.white, fontSize: 25.0)),
                const SizedBox(height: 20.0),
                LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*

        Container(
          color: Colors.black.withOpacity(0.7),
          height: 200.0,
          width: 500.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Loading ...', style: TextStyle(color: Colors.white, fontSize: 25.0)),
              const SizedBox(height: 20.0),
              LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 100.0),
            ],
          ),
        )

*/
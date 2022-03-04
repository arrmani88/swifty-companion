import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class VerticalBlurContainer extends StatelessWidget {
  final List<Widget> children;
  const VerticalBlurContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 500.0,
        color: Colors.black.withOpacity(0.4),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

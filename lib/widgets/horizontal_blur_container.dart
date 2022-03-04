import 'package:flutter/material.dart';

class HorizontalBlurContainer extends StatelessWidget {
  final List<Widget> children;
  const HorizontalBlurContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 500.0,
        height: 100.0,
        color: Colors.black.withOpacity(0.4),
        child: Row(
          children: children,
        ),
      ),
    );
  }
}

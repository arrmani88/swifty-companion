import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swifty_companion/widgets/horizontal_blur_container.dart';

class Projects extends StatelessWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            autoPlay: false,
          ),
          items: [
            HorizontalBlurContainer(children: []),
            HorizontalBlurContainer(children: []),
            HorizontalBlurContainer(children: []),
            HorizontalBlurContainer(children: []),
            HorizontalBlurContainer(children: []),
          ],
        ),
      ),
    );
  }
}

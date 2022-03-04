import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swifty_companion/widgets/item_project.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/classes/project.dart';

// class Projects extends StatelessWidget {
//   const Projects({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: kScreenHeight,
//         width: kScreenWidth,
//         decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
//         child: CarouselSlider(
//           options: CarouselOptions(
//             pageSnapping: true,
//             scrollDirection: Axis.vertical,
//             viewportFraction: 0.12,
//             enableInfiniteScroll: false,
//             autoPlay: false,
//             enlargeCenterPage: false,
//             // enlargeStrategy: CenterPageEnlargeStrategy.height,
//             disableCenter: true,
//           ),
//           items: const [
//             HorizontalBlurContainer(children: [Text('AAAa')]),
//             HorizontalBlurContainer(children: [Text('bbb')]),
//             HorizontalBlurContainer(children: [Text('ccc')]),
//             HorizontalBlurContainer(children: [Text('ddd')]),
//             HorizontalBlurContainer(children: [Text('eee')]),
//             HorizontalBlurContainer(children: [Text('fff')]),
//             HorizontalBlurContainer(children: [Text('ggg')]),
//             HorizontalBlurContainer(children: [Text('ggg')]),
//             HorizontalBlurContainer(children: [Text('ggg')]),
//             HorizontalBlurContainer(children: [Text('ggg')]),
//             HorizontalBlurContainer(children: [Text('ggg')]),
//             HorizontalBlurContainer(children: [Text('ggg')]),
//             HorizontalBlurContainer(children: [Text('ggg')]),
//           ],
//         ),
//       ),
//     );
//   }
// }
/*
CarouselSlider(
          options: CarouselOptions(
            pageSnapping: true,
            scrollDirection: Axis.vertical,
            viewportFraction: 0.12,
            enableInfiniteScroll: false,
            autoPlay: false,
            enlargeCenterPage: false,
            // enlargeStrategy: CenterPageEnlargeStrategy.height,
            disableCenter: true,
          ),
          items: const [
            HorizontalBlurContainer(children: [Text('AAAa')]),
            HorizontalBlurContainer(children: [Text('bbb')]),
            HorizontalBlurContainer(children: [Text('ccc')]),
            HorizontalBlurContainer(children: [Text('ddd')]),
            HorizontalBlurContainer(children: [Text('eee')]),
            HorizontalBlurContainer(children: [Text('fff')]),
            HorizontalBlurContainer(children: [Text('ggg')]),
            HorizontalBlurContainer(children: [Text('ggg')]),
            HorizontalBlurContainer(children: [Text('ggg')]),
            HorizontalBlurContainer(children: [Text('ggg')]),
            HorizontalBlurContainer(children: [Text('ggg')]),
            HorizontalBlurContainer(children: [Text('ggg')]),
            HorizontalBlurContainer(children: [Text('ggg')]),
          ],
        )
*/
// class Projects extends StatelessWidget {
//   const Projects({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: kScreenHeight,
//         width: kScreenWidth,
//         decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
//         child: AnimationLimiter(
//           child: ListView.builder(
//             itemCount: 1,
//             itemBuilder: (BuildContext context, int index) {
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 duration: const Duration(seconds: 1),
//                 child: SlideAnimation(
//                   verticalOffset: 100,
//                   child: FadeInAnimation(
//                     child: Column(
//                       children: const [
//                         HorizontalBlurContainer(children: [Text('AAAa')]),
//                         HorizontalBlurContainer(children: [Text('bbb')]),
//                         HorizontalBlurContainer(children: [Text('ccc')]),
//                         HorizontalBlurContainer(children: [Text('ddd')]),
//                         HorizontalBlurContainer(children: [Text('eee')]),
//                         HorizontalBlurContainer(children: [Text('fff')]),
//                         HorizontalBlurContainer(children: [Text('ggg')]),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class Projects extends StatelessWidget {
  Projects({Key? key}) : super(key: key);
  final OutlineInputBorder border = OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(0.0));
  List<Project> projectsList = [
    Project(title: 'Project 1', status: Status.failed, finalMark: 100),
    Project(title: 'Project 2', status: Status.subscribed, finalMark: 200),
    Project(title: 'Project 3', status: Status.validated, finalMark: 300),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: kScreenHeight,
          width: kScreenWidth,
          decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: SearchableList<Project>(
                    initialList: projectsList,
                    builder: (dynamic project) => ItemProject(project: project),
                    filter: _filterUserList,
                    inputDecoration: InputDecoration(
                      label: const Text('Enter login', style: TextStyle(color: Colors.white)),
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Project> _filterUserList(search) {
    return projectsList.where((element) {
      return element.title.toLowerCase().contains(search) || element.status.toString().contains(search);
    }).toList();
  }
}

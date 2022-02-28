import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/widgets/blur_container.dart';
import 'package:swifty_companion/widgets/intra_info.dart';
import 'package:swifty_companion/widgets/cover_and_profile_pictures.dart';
import 'package:swifty_companion/widgets/personal_info.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/widgets/skills.dart';
//
// class ProfileRoute extends StatelessWidget {
//   ProfileRoute({Key? key}) : super(key: key);
//
//   final List<RadarDataSet> dataSets = [
//     RadarDataSet(
//       fillColor: null,
//       borderColor: Colors.blue,
//       dataEntries: const [
//         RadarEntry(value: 1),
//         RadarEntry(value: 2),
//         RadarEntry(value: 4),
//         RadarEntry(value: 9),
//         RadarEntry(value: 9),
//       ]
//     ),
//     // RadarDataSet(
//     //   fillColor: null,
//     //   borderColor: Colors.yellow,
//     //   dataEntries: const [
//     //     RadarEntry(value: 9),
//     //     RadarEntry(value: 3),
//     //     RadarEntry(value: 9),
//     //     RadarEntry(value: 9),
//     //     RadarEntry(value: 5),
//     //   ]
//     // ),
//     // RadarDataSet(
//     //   fillColor: null,
//     //   borderColor: Colors.red,
//     //   dataEntries: const [
//     //     RadarEntry(value: 9),
//     //     RadarEntry(value: 9),
//     //     RadarEntry(value: 4),
//     //     RadarEntry(value: 4),
//     //     RadarEntry(value: 5),
//     //   ]
//     // ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           RadarChartSample1(),
//           SizedBox(
//             height: 450.0,
//             child: RadarChart(
//               RadarChartData(
//                   titleTextStyle: const TextStyle(color: titleColor, fontSize: 14),
//                   gridBorderData: const BorderSide(color: gridColor, width: 2),
//                   tickBorderData: const BorderSide(color: Colors.transparent),
//                   ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
//                 // tickCount: null,
//                 radarBorderData: const BorderSide(color: Colors.transparent),
//                 borderData: FlBorderData(show: false), // contour dial the whole widget
//                 radarBackgroundColor: Colors.transparent,
//                 getTitle: (index) {
//                   switch (index) {
//                     case (0): return 'str1';
//                     case (1): return 'str2';
//                     case (2): return 'str3';
//                     case (3): return 'str4';
//                     case (4): return 'str5';
//                   }
//                   return '';
//                 },
//                 dataSets: dataSets
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProfileRoute extends StatelessWidget {
  const ProfileRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor],
              center: const Alignment(0, -0.05),
              radius: 0.8
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CoverAndProfilePictures(profilePicture: user.imageURL,),
              const SizedBox(height: 25.0),
              Text(user.displayName, style: const TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
              Text('@'+user.login, style: const TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
              BlurContainer(
                children: [
                  IntraInfo(title: 'Wallet', value: user.wallet.toString() + ' \$'),
                  IntraInfo(title: 'Evaluation points', value: user.correctionPoint.toString()),
                  const IntraInfo(title: 'Cursus', value: 'ADD DRP DWN'),
                  const IntraInfo(title: 'Grade', value: 'CHANGE THIS'),
                  const IntraInfo(title: 'ETEC', value: 'UPDATE THIS'),
                ],
              ),
              BlurContainer(
                children: [
                  PersonalInfo(icon: Icons.location_on, value: user.location + ', '+ user.campus,),
                  PersonalInfo(icon: Icons.alternate_email, value: user.email),
                  const PersonalInfo(icon: Icons.local_phone, value: 'ADD MOBILE'),
                  const SizedBox(height: 10.0),
                  LinearPercentIndicator(
                    progressColor: Theme.of(context).secondaryHeaderColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    animation: true,
                    animationDuration: 3000,
                    lineHeight: 30.0,
                    percent: 0.5,
                    center: const Text('Level: 9.7', style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              BlurContainer(
                children: [
                  SizedBox(height: 300, child: Skills()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


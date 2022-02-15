import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/widgets/blur_container.dart';
import 'package:swifty_companion/widgets/intra_info.dart';
import 'package:swifty_companion/widgets/cover_and_profile_pictures.dart';
import 'package:swifty_companion/widgets/personal_info.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:swifty_companion/routes/widget.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileRoute extends StatelessWidget {
  ProfileRoute({Key? key}) : super(key: key);

  final List dataSets = [
    RadarDataSet(
      dataEntries: const [RadarEntry(value: 2), RadarEntry(value: 2), RadarEntry(value: 2), RadarEntry(value: 2)]
    ),
    RadarDataSet(
      dataEntries: const [RadarEntry(value: 4), RadarEntry(value: 4), RadarEntry(value: 4), RadarEntry(value: 4)]
    ),
    RadarDataSet(
      dataEntries: const [RadarEntry(value: 6), RadarEntry(value: 6), RadarEntry(value: 6), RadarEntry(value: 6)]
    ),

    [2, 2, 2, 2],
    [4, 4, 4, 4],
    [6, 6, 6, 6],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RadarChartSample1(),
          RadarChart(
            RadarChartData(

            )
          )
        ],
      ),
    );
  }
}


class ProfileRoute1 extends StatelessWidget {
  const ProfileRoute1({Key? key}) : super(key: key);

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
                  IntraInfo(title: 'Cursus', value: 'ADD DRP DWN'),
                  IntraInfo(title: 'Grade', value: 'CHANGE THIS'),
                  IntraInfo(title: 'ETEC', value: 'UPDATE THIS'),
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
            ],
          ),
        ),
      ),
    );
  }
}


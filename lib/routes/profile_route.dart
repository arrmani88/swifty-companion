import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/widgets/blur_container.dart';
import 'package:swifty_companion/widgets/intra_info.dart';
import 'package:swifty_companion/widgets/cover_profile_pictures.dart';
import 'package:swifty_companion/widgets/personal_info.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileRoute extends StatelessWidget {
  ProfileRoute({Key? key}) : super(key: key);

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
              CoverProfilePictures(image: 'assets/images/profile_picture.jpeg'),
              const SizedBox(height: 25.0),
              const Text('Anas El boudali', style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
              const Text('@''anel-bou', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
              const BlurContainer(
                children: [
                  IntraInfo(title: 'Wallet', value: '30\$'),
                  IntraInfo(title: 'Evaluation points', value: '2'),
                  IntraInfo(title: 'Cursus', value: '42'), // DROP DOWN BUTTON TO APPLY HERE
                  IntraInfo(title: 'Grade', value: 'Lieutenant'),
                  IntraInfo(title: 'ETEC', value: 'in 8 years'),
                ],
              ),
              BlurContainer(
                children: [
                  const PersonalInfo(icon: Icons.location_on, value: 'e2r7p15, Khouribga',),
                  const PersonalInfo(icon: Icons.alternate_email, value: 'anel-bou@student.1337.ma'),
                  const PersonalInfo(icon: Icons.local_phone, value: '0664646125'),
                  const SizedBox(height: 5.0),
                  FAProgressBar(currentValue: 9, maxValue: 21, displayText: ',7 %', backgroundColor: Theme.of(context).scaffoldBackgroundColor, progressColor: Theme.of(context).secondaryHeaderColor, borderRadius: BorderRadius.circular(0.0)),
                  const SizedBox(height: 20.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}


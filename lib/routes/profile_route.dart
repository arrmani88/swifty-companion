import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/widgets/blur_container.dart';
import 'package:swifty_companion/widgets/intra_info.dart';
import 'package:swifty_companion/widgets/cover_and_profile_pictures.dart';
import 'package:swifty_companion/widgets/personal_info.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/widgets/skills.dart';
import 'package:swifty_companion/widgets/skills_chart.dart';
import 'package:swifty_companion/widgets/select_cursus.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({Key? key}) : super(key: key);
  @override State<ProfileRoute> createState() => _ProfileRouteState();
}
class _ProfileRouteState extends State<ProfileRoute> {

  changeCursus() {
    print('>>>>>>>> PAGE REBUILT <<<<<<<<');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kScreenHeight,
        width: kScreenWidth,
        decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CoverAndProfilePictures(profilePictureURL: user.imageURL,),
              const SizedBox(height: 25.0),
              Text(user.displayName, style: const TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
              Text('@'+user.login, style: const TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
              BlurContainer(
                children: [
                  IntraInfo(title: 'Wallet', value: user.wallet.toString() + ' \$'),
                  IntraInfo(title: 'Evaluation points', value: user.correctionPoint.toString()),
                  SelectCursus(parentSetState: changeCursus),
                  const SizedBox(height: 5.0),
                  IntraInfo(title: 'Grade', value: user.grade[selectedCursus]!),
                  const IntraInfo(title: 'ETEC', value: 'EDIT THIS'),
                ],
              ),
              BlurContainer(
                children: [
                  PersonalInfo(icon: Icons.location_on, value: (user.location ?? 'Unavailable') + ', '+ user.campus,),
                  PersonalInfo(icon: Icons.alternate_email, value: user.email),
                  PersonalInfo(icon: Icons.local_phone, value: user.phone ?? 'Hidden'),
                  const SizedBox(height: 10.0),
                  LinearPercentIndicator(
                    progressColor: Theme.of(context).secondaryHeaderColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    animation: true,
                    animationDuration: 3000,
                    lineHeight: 30.0,
                    percent: user.level[selectedCursus]! / 21,
                    center: Text('Level: ' + user.level[selectedCursus].toString(), style: const TextStyle(color: Colors.white)),
                  )
                ],
              ),
              BlurContainer(
                children: [
                  SizedBox(height: 320, child: Skills()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

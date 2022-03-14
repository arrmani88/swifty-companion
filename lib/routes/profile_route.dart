import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:swifty_companion/widgets/black_hole_absorption.dart';
import 'package:swifty_companion/widgets/blur_container.dart';
import 'package:swifty_companion/widgets/get_notified.dart';
import 'package:swifty_companion/widgets/intra_info.dart';
import 'package:swifty_companion/widgets/cover_and_profile_pictures.dart';
import 'package:swifty_companion/widgets/personal_info.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:swifty_companion/widgets/pop_ups/loading_pop_up.dart';
import 'package:swifty_companion/widgets/select_cursus.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/providers/user_provider.dart';
import 'package:swifty_companion/widgets/skills.dart';

import '../providers/pop_up_provider.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({Key? key}) : super(key: key);
  @override State<ProfileRoute> createState() => _ProfileRouteState();
}
class _ProfileRouteState extends State<ProfileRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: kScreenHeight,
            width: kScreenWidth,
            decoration: BoxDecoration(gradient: RadialGradient(colors: [Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor], center: const Alignment(0, -0.05), radius: 0.8)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CoverAndProfilePictures(),
                  const SizedBox(height: 25.0),
                  Text(context.watch<UserProvider>().displayName, style: const TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('@ '+context.watch<UserProvider>().login, style: const TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
                      Container(margin: const EdgeInsets.symmetric(horizontal: 15.0),width: 2.0, height: 25.0, color: Colors.white),
                      const Icon(Icons.computer, color: Colors.white,),
                      const SizedBox(width: 10.0),
                      Text((context.watch<UserProvider>().location ?? 'Unavailable'), style: const TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                  const GetNotified(),
                  BlurContainer(
                    children: [
                      IntraInfo(title: 'Wallet', value: context.watch<UserProvider>().wallet.toString() + ' \$'),
                      IntraInfo(title: 'Evaluation points', value: context.watch<UserProvider>().correctionPoint.toString()),
                      const SelectCursus(),
                      const SizedBox(height: 5.0),
                      IntraInfo(title: 'Grade', value: context.watch<UserProvider>().grade[context.watch<UserProvider>().selectedCursus]!),
                      const IntraInfo(title: 'ETEC', value: 'EDIT THIS'),
                    ],
                  ),
                  BlurContainer(
                    children: [
                      // PersonalInfo(icon: Icons.location_on, value: (context.watch<UserProvider>().location ?? 'Unavailable') + ', '+ context.watch<UserProvider>().campus,),
                      PersonalInfo(icon: Icons.location_on, value: context.watch<UserProvider>().campus,),
                      PersonalInfo(icon: Icons.alternate_email, value: context.watch<UserProvider>().email),
                      PersonalInfo(icon: Icons.local_phone, value: context.watch<UserProvider>().phone),
                      if (context.read<UserProvider>().blackHoleAbsorption[context.watch<UserProvider>().selectedCursus] != null)
                        const BlackHoleAbsorption(),
                      const SizedBox(height: 10.0),
                      LinearPercentIndicator(
                        progressColor: Theme.of(context).secondaryHeaderColor,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        animation: true,
                        animationDuration: 3000,
                        lineHeight: 30.0,
                        percent: context.watch<UserProvider>().level[context.watch<UserProvider>().selectedCursus]! / 21,
                        center: Text('Level: ' + context.watch<UserProvider>().level[context.watch<UserProvider>().selectedCursus].toString(), style: const TextStyle(color: Colors.white)),
                      ),
                      // const SizedBox(height: 10.0),
                    ],
                  ),
                  // const BlurContainer(
                  //   children: [
                  //     SizedBox(height: 320, child: Skills()),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
          if (context.watch<PopUpProvider>().isProfileLoadingPopUpDisplayed) const LoadingPopUp(),
        ],
      ),
    );
  }
}

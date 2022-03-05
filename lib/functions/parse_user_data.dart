import 'package:swifty_companion/functions/print_user_class.dart';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/classes/project.dart';

getStatusEnum(String str, bool isValidated){
  if (str == 'finished' && isValidated == true) return Status.validated;
  else if (str == 'finished' && isValidated == true) return Status.failed;
  else if (str == 'waiting_for_correction') return Status.waitingForCorrection;
  return Status.subscribed;
}

parseUserData(Response rsp) {
  user.email = (rsp.data as Map<String, dynamic>)['email'];
  user.login = (rsp.data as Map<String, dynamic>)['login'];
  user.phone = (rsp.data as Map<String, dynamic>)['phone'];
  user.displayName = (rsp.data as Map<String, dynamic>)['displayname'];
  user.imageURL = (rsp.data as Map<String, dynamic>)['image_url'];
  user.correctionPoint = (rsp.data as Map<String, dynamic>)['correction_point'];
  user.location = (rsp.data as Map<String, dynamic>)['location'];
  user.wallet = (rsp.data as Map<String, dynamic>)['wallet'];
  user.campus = (((rsp.data as Map<String, dynamic>)['campus'] as List<dynamic>)[0] as Map<String, dynamic>)['name'];
  for (var cursus in ((rsp.data as Map<String, dynamic>)['cursus_users'] as List<dynamic>)) {
    user.cursusNames.add((cursus['cursus'] as Map<String, dynamic>)['name']);
    user.grade[(cursus['cursus'] as Map<String, dynamic>)['name']] = cursus['grade'] ?? 'Novice';
    user.level[(cursus['cursus'] as Map<String, dynamic>)['name']] = cursus['level'];
    user.skills[(cursus['cursus'] as Map<String, dynamic>)['name']] = SplayTreeMap<String, double>();
    for (var skill in cursus['skills']) {
      String key = skill['name'].replaceAll(' ', '\n');
      key = key.replaceAll('\n&\n', '\n& ');
      user.skills[(cursus['cursus'] as Map<String, dynamic>)['name']]![key] = skill['level'];
    }
  }
  selectedCursus = user.cursusNames[user.cursusNames.length - 1];
  for (Map<String, dynamic> project in (rsp.data as Map<String, dynamic>)['projects_users']) {
    user.projectsList.add(Project(
      title: (project['project'] as Map<String, dynamic>)['slug'],
      status: getStatusEnum(project['status'], project['validated?']),
      finalMark: project['final_mark']
    ));
  }



  // user.imageURL = 'https://images.unsplash.com/photo-1526666923127-b2970f64b422?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3572&q=80.jpg';
  // printUSerClass(user);
}
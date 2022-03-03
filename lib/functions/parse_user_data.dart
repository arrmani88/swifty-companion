import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:swifty_companion/functions/print_user_class.dart';
import 'package:swifty_companion/globals/globals.dart';

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

  // printUSerClass(user);
}
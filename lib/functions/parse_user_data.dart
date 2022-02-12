import 'package:dio/dio.dart';
import 'package:swifty_companion/globals/globals.dart';

parseUserData(Response rsp) {
  print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  // user.email = (rsp.data as Map<String, dynamic>)['email'];
  // user.login = (rsp.data as Map<String, dynamic>)['login'];
  // // user.phone = (rsp.data as Map<String, dynamic>)['phone'];
  // user.displayName = (rsp.data as Map<String, dynamic>)['displayname'];
  // user.newImageURL = (rsp.data as Map<String, dynamic>)['new_image_url'];
  // user.correctionPoint = (rsp.data as Map<String, dynamic>)['correction_point'];
  // user.location = (rsp.data as Map<String, dynamic>)['location'];
  // user.wallet = (rsp.data as Map<String, dynamic>)['wallet'];
  // user.grade = ((((rsp.data as Map<String, dynamic>)['cursus_users'] as List<dynamic>)[0]) as Map<String, dynamic>)['grade'];
  for (var cursus in ((rsp.data as Map<String, dynamic>)['cursus_users'] as List<dynamic>)) {
    user.cursus.add(((cursus as Map<String, dynamic>)['cursus'] as Map<String, dynamic>)['name']);
    user.grade[((cursus as Map<String, dynamic>)['cursus'] as Map<String, dynamic>)['name']] = (cursus as Map<String, dynamic>)['grade'] ?? 'Novice';
    user.level[]
  }
  print(user.grade);







  // print('email=>'+ (rsp.data as Map<String, dynamic>)['email']);
  print('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');


}
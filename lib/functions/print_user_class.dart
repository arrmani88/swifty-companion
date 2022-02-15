import 'package:swifty_companion/classes/user.dart';

printUSerClass(User user) {
  print('<<<<<<<< SUMMARY OF THE -User- CLASS >>>>>>>>>>');
  print('email=>>>' + user.email);
  print('login=>>>' + user.login);
  // print('phone=>>>' + user.phone);
  print('displayName=>>>' + user.displayName);
  print('newImageURL=>>>' + user.imageURL);
  print('location=>>>' + user.location);
  // print('etec=>>>' + user.etec);
  print('campus=>>>' + user.campus);
  print('correctionPoint=>>>' + user.correctionPoint.toString());
  print('wallet=>>>' + user.wallet.toString());
  print('cursusNames=>>>' + user.cursusNames.toString());
  print('grade=>>>' + user.grade.toString());
  print('level=>>>' + user.level.toString());
  print('skills=>>>' + user.skills.toString());
}
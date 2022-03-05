import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:swifty_companion/classes/project.dart';
import 'package:swifty_companion/functions/get_status_string_from_enum.dart';
import 'package:dio/dio.dart';

class UserProvider with ChangeNotifier {

  late String email;
  late String login;
  late String phone;
  late String displayName;
  String? imageURL;
  late String? location;
  late String etec;
  late String campus;
  late int correctionPoint;
  late int wallet;
  List cursusNames = [];
  Map<String, int> cursusIds= {};
  Map<String, String> grade = {};
  Map<String, double> level = {};
  Map<String, SplayTreeMap<String, double>> skills = {};
  List<Project> projectsList = [];
  late String selectedCursus;
  late Response response;

  parseUserConstantData(Response rsp) {
    response = rsp;
    email = (rsp.data as Map<String, dynamic>)['email'];
    login = (rsp.data as Map<String, dynamic>)['login'];
    phone = (rsp.data as Map<String, dynamic>)['phone'];
    displayName = (rsp.data as Map<String, dynamic>)['displayname'];
    imageURL = (rsp.data as Map<String, dynamic>)['image_url'];
    location = (rsp.data as Map<String, dynamic>)['location'];
    campus = (((rsp.data as Map<String, dynamic>)['campus'] as List<dynamic>)[0] as Map<String, dynamic>)['name'];
    for (var cursus in ((response.data as Map<String, dynamic>)['cursus_users'] as List<dynamic>)) {
      cursusNames.add((cursus['cursus'] as Map<String, dynamic>)['name']);
      cursusIds[(cursus['cursus'] as Map<String, dynamic>)['name']] = (cursus['cursus'] as Map<String, dynamic>)['id'];      (cursus['cursus'] as Map<String, dynamic>)['id'];
    }
    selectedCursus = cursusNames[cursusNames.length - 1];
    notifyListeners();
  }

  parseUserVariableData() {
    correctionPoint = (response.data as Map<String, dynamic>)['correction_point'];
    wallet = (response.data as Map<String, dynamic>)['wallet'];
    for (var cursus in ((response.data as Map<String, dynamic>)['cursus_users'] as List<dynamic>)) {
      grade[(cursus['cursus'] as Map<String, dynamic>)['name']] = cursus['grade'] ?? 'Novice';
      level[(cursus['cursus'] as Map<String, dynamic>)['name']] = cursus['level'];
      skills[(cursus['cursus'] as Map<String, dynamic>)['name']] = SplayTreeMap<String, double>();
      for (var skill in cursus['skills']) {
        String key = skill['name'].replaceAll(' ', '\n');
        key = key.replaceAll('\n&\n', '\n& ');
        skills[(cursus['cursus'] as Map<String, dynamic>)['name']]![key] = skill['level'];
      }
    }
    projectsList.clear();
    for (Map<String, dynamic> project in (response.data as Map<String, dynamic>)['projects_users']) {
      if ((project['cursus_ids'] as List).contains(cursusIds[selectedCursus])) {
        projectsList.add(Project(
          title: (project['project'] as Map<String, dynamic>)['slug'],
          status: getStatusStringFromEnum(project['status'], project['validated?']),
          finalMark: project['final_mark'])
        );
      }
    }
    notifyListeners();
    // user.imageURL = 'https://images.unsplash.com/photo-1526666923127-b2970f64b422?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3572&q=80.jpg';
    // printUSerClass(user);
  }

  updateSelectedCursus(String newCursus) {
    selectedCursus = newCursus;
    notifyListeners();
  }

}
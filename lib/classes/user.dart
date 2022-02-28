import 'dart:collection';

class User {
  late String email;
  late String login;
  late String phone;
  late String displayName;
  late String imageURL;
  late String location;
  late String etec;
  late String campus;

  late int correctionPoint;
  late int wallet;
  List cursusNames = [];
  Map<String, String> grade = {};
  Map<String, double> level = {};
  Map<String, SplayTreeMap<String, double>> skills = {};
  // Map<String, double> skills = {};
}
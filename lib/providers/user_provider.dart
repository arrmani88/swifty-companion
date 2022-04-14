import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notifier_42/classes/project.dart';
import 'package:notifier_42/functions/get_status_string_from_enum.dart';
import 'package:dio/dio.dart';
import 'package:notifier_42/functions/get_black_hole_absorption.dart';
import 'package:notifier_42/providers/processes_organizer_provider.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../functions/validate_access_token.dart';
import '../globals/globals.dart';

class UserProvider with ChangeNotifier {

  String? imageURL;
  String? location;
  late String email;
  late String login;
  late String phone;
  late String displayName;
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
  Map<String, int?> blackHoleAbsorption = {};
  bool isProfilePageLoading = true;
  List<DropdownMenuItem<String>>? cursusesWidgetsList = [];
  bool isUserTargeted = false;
  late int userId;
  late int campusId;
  final int processId = 4;

  ProcessesOrganizerProvider? processesOrganizer;
  UserProvider(this.processesOrganizer);

  targetThis(String key) {
    isUserTargeted = true;
    notifyListeners();
  }

  detargetThis(String key) {
    isUserTargeted = false;
    notifyListeners();
  }

  destroyUser() {
    cursusNames = [];
    cursusIds= {};
    grade = {};
    level = {};
    skills = {};
    projectsList = [];
    blackHoleAbsorption = {};
    cursusesWidgetsList = [];
    isUserTargeted = false;
  }

  getThisUser(BuildContext context, String userLogin, Map<String, List<Map<String, dynamic>>> targetedItemsData) async {
    try {
      if (await context.read<ProcessesOrganizerProvider>().canIRunThisProcess(processId) == true) {
        context.read<ProcessesOrganizerProvider>().runThisProcess(processId);
        print('<debug>:runProcess(user)');
        await InternetAddress.lookup('api.intra.42.fr');
        await validateAccessToken();
        await Future.delayed(const Duration(seconds: 1));
        Response _response = await dio.get(
          kHostname + '/v2/users/' + userLogin.toLowerCase(),
          options: Options(headers: {'Authorization': 'Bearer ' + accessToken!}),
        );
        if (_response.statusCode! >= 200 && _response.statusCode! <= 299) {
          destroyUser();
          parseUserConstantData(_response, targetedItemsData);
          parseUserVariableData();
          notifyListeners();
          context.read<ProcessesOrganizerProvider>().finishThisProcess(processId);
          return ConnectionStatus.success;
        }
      }
    } catch (e) {
      if (e is SocketException) {
        return ConnectionStatus.noInternet;
      } if (e is DioError && e.response?.statusCode == 404) {
        return ConnectionStatus.notFound;
      } else {
        rethrow ;
      }
    } finally {
      context.read<ProcessesOrganizerProvider>().finishThisProcess(processId);
    }
    print('<debug>:finishProcess(user)');
  }

  parseUserConstantData(Response rsp, Map<String, List<Map<String, dynamic>>> targetedItemsData) {
    int userCampuses = ((rsp.data as Map<String, dynamic>)['campus'] as List<dynamic>).length;

    response = rsp;
    email = (rsp.data as Map<String, dynamic>)['email'];
    login = (rsp.data as Map<String, dynamic>)['login'];
    phone = (rsp.data as Map<String, dynamic>)['phone'];
    displayName = (rsp.data as Map<String, dynamic>)['displayname'];
    imageURL = (rsp.data as Map<String, dynamic>)['image_url'];
    location = (rsp.data as Map<String, dynamic>)['location'];
    campus = (((rsp.data as Map<String, dynamic>)['campus'] as List<dynamic>)[userCampuses - 1] as Map<String, dynamic>)['name'];
    for (var cursus in ((response.data as Map<String, dynamic>)['cursus_users'] as List<dynamic>)) {
      cursusNames.add((cursus['cursus'] as Map<String, dynamic>)['name']);
      cursusIds[(cursus['cursus'] as Map<String, dynamic>)['name']] = (cursus['cursus'] as Map<String, dynamic>)['id'];
      // (cursus['cursus'] as Map<String, dynamic>)['id'];
    }
    selectedCursus = cursusNames[cursusNames.length - 1];
    for (String cursus in cursusNames) {
      cursusesWidgetsList!.add(DropdownMenuItem(value: cursus, child: FittedBox(child: Text(cursus), fit: BoxFit.fitWidth,),));
    }
    userId = int.parse(((((response.data as Map<String, dynamic>)['campus_users'] as List<dynamic>)[0] as Map<String, dynamic>)['user_id']).toString());
    campusId = int.parse(((((response.data as Map<String, dynamic>)['campus_users'] as List<dynamic>)[0] as Map<String, dynamic>)['campus_id']).toString());
    userCampusId = int.parse(((((response.data as Map<String, dynamic>)['campus_users'] as List<dynamic>)[0] as Map<String, dynamic>)['campus_id']).toString());
    targetedItemsData.forEach((key, value) {
      for (Map<String, dynamic> usr in value) {
        if(usr['user_id'] == userId) {
          isUserTargeted = true;
          break ;
        }
      }
    });
  }

  parseUserVariableData() {
    correctionPoint = (response.data as Map<String, dynamic>)['correction_point'];
    wallet = (response.data as Map<String, dynamic>)['wallet'];
    for (var cursus in ((response.data as Map<String, dynamic>)['cursus_users'] as List<dynamic>)) {
      blackHoleAbsorption[(cursus['cursus'] as Map<String, dynamic>)['name']] = getBlackHoleAbsorption(cursus['blackholed_at']);
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
        projectsList.add(
          Project(
            title: (project['project'] as Map<String, dynamic>)['slug'],
            status: getStatusStringFromEnum(project['status'], project['validated?']),
            finalMark: project['final_mark']
          )
        );
      }
    }
  }

  updateSelectedCursus(String newCursus) {
    selectedCursus = newCursus;
    notifyListeners();
  }
}
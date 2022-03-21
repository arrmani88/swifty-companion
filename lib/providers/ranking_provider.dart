import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../globals/globals.dart';
import 'package:notifier_42/constants/campus_relative_data.dart';
import 'package:notifier_42/widgets/ranking_item.dart';
import 'package:notifier_42/extensions/splay_tree_map_extensions.dart';

class RankingProvider with ChangeNotifier {
  // FOR THE DOCUMENTATIONS SEE THE COMMENTS BELOW
  SplayTreeMap<String ,SplayTreeMap<double, List<String>>> generationsMap = SplayTreeMap<String ,SplayTreeMap<double, List<String>>>();
  Map<String, List<Widget>> widgetsList = {};
  List<DropdownMenuItem<String>> dropDownList = <DropdownMenuItem<String>>[];
  Map<String, int> generationsStudentsNumber = {};
  late String selectedGeneration;
  bool isLoading = true;
  int tmp = 0;

  getAllGenerations() async {
    Options options = Options(headers: {'Authorization': 'Bearer ' + accessToken!});
    await Future.wait([
      for (int requestNb = 1, interval = 1000; requestNb <= 8; requestNb++, interval += 700)
        Future.delayed(Duration(milliseconds: interval))
          .then((value) => dio.get(_getPath(pageNum: requestNb), options: options)
          .then((value) => parseUsers(value.data))),
    ]);
    selectedGeneration = generationsMap.keys.elementAt(0);
  }

  bool parseUsers(List response) {
    String generationBeginDate;
    String login;
    double level;
    bool isStaff;

    if (response.isEmpty) {
      print('------- EMPTY RESPONSE ---------');
      return false;
    }
    for (Map student in response) {
      level = student['level'];
      generationBeginDate = getGenerationTitle(student['begin_at']);
      login = (student['user'] as Map<String, dynamic>)['login'];
      isStaff = (student['user'] as Map<String, dynamic>)['staff?'];
      (generationsStudentsNumber[generationBeginDate] ??= 0);
      generationsStudentsNumber[generationBeginDate] = generationsStudentsNumber[generationBeginDate]! + 1;
      if (!isStaff && generationBeginDate.isNotEmpty) {
        (generationsMap[generationBeginDate] ??= SplayTreeMap<double, List<String>>()).addStudent(level, login);
      }
    }
    return true;
  }

  setWidgetsList() {
    int totalRanks;

    generationsMap.forEach((genTitle, gen) {
      totalRanks = generationsStudentsNumber[genTitle]!;
      dropDownList.add(DropdownMenuItem(value: genTitle, child: Text(genTitle)));
      gen.forEach((level, loginsList) {
        for (String login in loginsList) {
          (widgetsList[genTitle] ??= <RankingItem>[]).insert(0, RankingItem(rank: totalRanks--, login: login, level: level));
        }
      });
    });
  }

  setRanking() async {
    await getAllGenerations();
    setWidgetsList();
    isLoading = false;
    notifyListeners();
  }

// ******************************************************************************
  updateSelectedGeneration(String gen) {
    selectedGeneration = gen;
    notifyListeners();
  }

  String getGenerationTitle(String beginAt) {
    String returnValue = '';

    generationsBeginDates[userCampusId]!.forEach((title, datesList) {
      for (String date in datesList) {
        if (beginAt.startsWith(date)) {
          returnValue = title;
          return ;
        }
      }
    });
    return returnValue;
  }

  String _getPath({required int pageNum})  {
    return kHostname +
      '/v2/cursus/21/cursus_users'
        '?page[size]=100'
        '&sort=begin_at'
        '&filter[campus_id]=16'
        '&page[number]=$pageNum';
  }

}


// ******************* generationsMap ******************
// {
//   "Generation 1" : {
//     14.9: ["flane", "usrWithSameLevel"]
//     14.5: ["fertellane", "usrWithSameLevel"]
//   } ,
//   "Generation 2": {
//     9.87: ["benfertellan", "usrWithSameLevel"]
//     9.07: ["korrete", "usrWithSameLevel"]
//   }
// }



import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../globals/globals.dart';
import 'package:notifier_42/constants/campus_relative_data.dart';
import 'package:notifier_42/widgets/ranking_item.dart';

class RankingProvider with ChangeNotifier {
  // FOR THE DOCUMENTATIONS SEE THE COMMENTS BELOW
  SplayTreeMap<String ,SplayTreeMap<double, String>> generationsMap = SplayTreeMap<String ,SplayTreeMap<double, String>>();
  Map<String, List<Widget>> widgetsList = {};
  List<DropdownMenuItem<String>> dropDownList = <DropdownMenuItem<String>>[];
  late String selectedGeneration;
  bool isLoading = true;

  updateSelectedGeneration(String gen) {
    selectedGeneration = gen;
    notifyListeners();
  }

  bool parseUsers(List response) {
    String generationBeginDate;
    String login;
    double level;
    bool isStaff;

    if (response.isEmpty) return false;
    for (Map student in response) {
      level = student['level'];
      generationBeginDate = getGenerationTitle(student['begin_at']);
      login = (student['user'] as Map<String, dynamic>)['login'];
      isStaff = (student['user'] as Map<String, dynamic>)['staff?'];
      if (!isStaff && generationBeginDate.isNotEmpty) {
        if (generationsMap[generationBeginDate] == null) generationsMap[generationBeginDate] = SplayTreeMap<double, String>();
        generationsMap[generationBeginDate]![level] = login;
      }
    }
    return true;
  }

  getAllGenerations() async {
    Options options = Options(headers: {'Authorization': 'Bearer ' + accessToken!});
    await Future.wait([
      for (int requestNb = 0, interval = 1000; requestNb <= 8; requestNb++, interval += 650)
        Future.delayed(Duration(milliseconds: interval)).then((value) => dio.get(_getPath(pageNum: requestNb), options: options).then((value) => parseUsers(value.data))),
    ]);
  }

  setWidgetsList() {
    int rank;
    generationsMap.forEach((genTitle, gen) {
      dropDownList.add(DropdownMenuItem(value: genTitle, child: Text(genTitle)));
      rank = generationsMap[genTitle]!.length;
      gen.forEach((level, login) {
        widgetsList[genTitle] == null ? widgetsList[genTitle] = <RankingItem>[] : 0;
        widgetsList[genTitle]!.insert(0, RankingItem(rank: rank--, login: login, level: level));
      });
    });
  }

  setRanking() async {

    SplayTreeMap<int, String> map = SplayTreeMap<int, String>();
    map[5] = 'player1';
    map[2] = 'player2';
    map[6] = 'player3';
    map[7] = 'player4';
    map[7] = 'player5';
    map[7] = 'player6';
    map.forEach((level, player) {
      print('$player -> $level');
    });

    await getAllGenerations();
    selectedGeneration = generationsMap.keys.elementAt(0);
    setWidgetsList();
    isLoading = false;
    notifyListeners();
  }

// ********************************************************************
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
//     14.9: "flane"
//     14.5: "fertellane"
//   } ,
//   "Generation 2": {
//     9.87: "benfertellan"
//     9.07: "korrete"
//   }
// }

// ******************* widgetsList ******************


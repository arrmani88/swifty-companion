import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../constants/constants.dart';
import '../globals/globals.dart';
import 'package:notifier_42/constants/campus_relative_data.dart';

class RankingProvider with ChangeNotifier {
  // FOR THE DOCUMENTATIONS SEE THE COMMENTS BELOW
  SplayTreeMap<String ,SplayTreeMap<double, String>> generationsMap = SplayTreeMap<String ,SplayTreeMap<double, String>>();
  bool isLoading = true;

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
      for (int requestNb = 0, interval = 1000; requestNb <= 1; requestNb++, interval += 700)
        Future.delayed(Duration(milliseconds: interval)).then((value) => dio.get(_getPath(pageNum: requestNb), options: options).then((value) => parseUsers(value.data))),
    ]);
  }

  getWidgetsList() {

  }

  getRanking() async {
    await getAllGenerations();

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
//   "Promo 1" : {
//     14.9: "flane"
//     14.5: "fertellane"
//   } ,
//   "Promo 2": {
//     9.87: "benfertellan"
//     9.07: "korrete"
//   }
// }


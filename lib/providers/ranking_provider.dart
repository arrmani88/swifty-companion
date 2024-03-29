import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../functions/validate_access_token.dart';
import '../globals/globals.dart';
import 'package:notifier_42/constants/campus_relative_data.dart';
import 'package:notifier_42/widgets/ranking_item.dart';
import 'package:notifier_42/extensions/splay_tree_map_extensions.dart';
import 'package:notifier_42/providers/processes_organizer_provider.dart';

class RankingProvider with ChangeNotifier {
  // FOR THE DOCUMENTATIONS SEE THE COMMENTS BELOW
  SplayTreeMap<double, List<String>> generationStudents = SplayTreeMap<double, List<String>>();
  List<Widget> widgetsList = [];
  List<DropdownMenuItem<String>> dropDownList = <DropdownMenuItem<String>>[];
  // list that contains the number of students of each gen
  Map<String, int> totalStudentsInEachGeneration = {};
  // selectedGeneration has a value of the last generation title
  // String selectedGeneration = generationsBeginDates[userCampusId]!.keys.toList()[generationsBeginDates[userCampusId]!.keys.length - 1];
  String selectedGeneration = '2019 March';
  bool isLoading = true;
  final int processId = 2;

  getGeneration(BuildContext context) async {
    Options options = Options(headers: {'Authorization': 'Bearer ' + accessToken!});
    int gotAllPages = -1;
    try {
      if (await context.read<ProcessesOrganizerProvider>().canIRunThisProcess(processId) == true) {
        context.read<ProcessesOrganizerProvider>().runThisProcess(processId);
        // while gotAllPages != 1, send (repeated) times the request and wait for the (repeated) responses
        // and then check if one of them is empty to finish the operation
        for (int pageNumber = 1; gotAllPages != 1; pageNumber += 3) {
          await Future.wait([
            // send (repeated) times the request and then check if one of the (repeated) requests is empty to finish the operation
            for (int repeated = 0, interval = 1000; repeated < 4; repeated++, interval += 700)
              Future.delayed(Duration(milliseconds: interval))
                .then((value) => dio.get(_getPath(pageNum: pageNumber + repeated), options: options)
                .then((value) {
                // if the app got all parts, the operation finishes here
                if (parseUsers(value.data) == false) gotAllPages = 1;
              })),
          ]);
        }
      }
    } catch (e) {
      rethrow;
    } finally {
      context.read<ProcessesOrganizerProvider>().finishThisProcess(processId);
    }
  }

  bool parseUsers(List response) {
    // if the app got all parts, it returns false , else it returns true
    String generationBeginDate;
    String login;
    double level;
    bool isStaff;

    if (response.isEmpty) {
      return false;
    }
    for (Map student in response) {
      level = student['level'];
      generationBeginDate = getGenerationTitle(student['begin_at']);
      login = (student['user'] as Map<String, dynamic>)['login'];
      isStaff = (student['user'] as Map<String, dynamic>)['staff?'];
      (totalStudentsInEachGeneration[generationBeginDate] ??= 0);
      totalStudentsInEachGeneration[generationBeginDate] = totalStudentsInEachGeneration[generationBeginDate]! + 1;
      if (!isStaff && generationBeginDate.isNotEmpty) {
        generationStudents.addStudent(level, login);
      }
    }
    return true;
  }

  setWidgetsList() {
    int totalRanks;

    print('<debug>: $selectedGeneration');
    print('<debug>: $totalStudentsInEachGeneration');
    totalRanks = totalStudentsInEachGeneration[selectedGeneration]!;
    generationStudents.forEach((level, loginsList) {
      for (String login in loginsList) {
        widgetsList.insert(0, RankingItem(rank: totalRanks--, login: login, level: level));
      }
    });
    widgetsList.add(const SizedBox(height: 40.0));
  }

  setRanking(BuildContext context) async {
    try {
      clearPreviousData();
      await getGeneration(context);
      setWidgetsList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      if (e is DioError && (e.response!.statusCode == 403 || e.response!.statusCode == 401)) {
        await validateAccessToken();
        await setRanking(context);
      } else if (e is DioError && e.response!.statusCode == 429) {
        await setRanking(context);
      } else {
        rethrow ;
      }
    }
  }

  clearPreviousData() {
    totalStudentsInEachGeneration.clear();
    generationStudents.clear();
    widgetsList.clear();
  }

  setDropDownList() {
    generationsBeginDates[userCampusId]!.forEach((genTitle, _) {
      dropDownList.add(DropdownMenuItem(value: genTitle, child: FittedBox(fit: BoxFit.fitWidth, child: Text(genTitle))));
    });
  }

  updateSelectedGeneration(String gen) {
    isLoading = true;
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
    String begin = generationsRanges[userCampusId]![selectedGeneration]![0];
    String end = generationsRanges[userCampusId]![selectedGeneration]![1];

    return kHostname +
      '/v2/cursus/21/cursus_users'
      '?page[size]=100'
      '&sort=begin_at'
      '&filter[campus_id]=16'
      '&page[number]=$pageNum'
      '&range[begin_at]=$begin,$end';
  }

}


// ******************* generationsMap ******************
//   {
//     14.9: ["flane", "usrWithSameLevel"]
//     14.5: ["fertellane", "usrWithSameLevel"]
//   }



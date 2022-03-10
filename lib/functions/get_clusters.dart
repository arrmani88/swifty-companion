import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/functions/validate_access_token.dart';
import '../constants/constants.dart';
import '../globals/globals.dart';
import 'package:flutter/material.dart';

import '../providers/cluster_provider.dart';

String getPath({required int pageNum})  {
  return kHostname +
  '/v2/campus/16/locations'
    '?page[size]=100'
    '&page[number]=$pageNum'
    '&range[host]=e1r1p1,e2r13p5'
    '&sort=host'
    '&filter[active]=true';
}

Future<void> getClusters(BuildContext context) async {
  try {
    await validateAccessToken();
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 1005))
          .then((value) => dio.get(
          getPath(pageNum: 1),
          options: Options(headers: {'Authorization': 'Bearer ' + accessToken}))
          .then((value) => context.read<ClustersProvider>()
          .addClusterPartToClustersList((value.data)))),

      Future.delayed(const Duration(milliseconds: 1005))
        .then((value) => dio.get(
          getPath(pageNum: 2),
          options: Options(headers: {'Authorization': 'Bearer ' + accessToken}))
        .then((value) => context.read<ClustersProvider>()
        .addClusterPartToClustersList((value.data)))),

      Future.delayed(const Duration(milliseconds: 2010))
        .then((value) => dio.get(
          getPath(pageNum: 3),
          options: Options(headers: {'Authorization': 'Bearer ' + accessToken}))
        .then((value) => context.read<ClustersProvider>()
        .addClusterPartToClustersList((value.data)))),

      Future.delayed(const Duration(milliseconds: 2010))
          .then((value) => dio.get(
          getPath(pageNum: 4),
          options: Options(headers: {'Authorization': 'Bearer ' + accessToken}))
          .then((value) => context.read<ClustersProvider>()
          .addClusterPartToClustersList((value.data)))),

    ]);
    context.read<ClustersProvider>().gotClusters();
  } catch (e) {
    rethrow ;
  }
}

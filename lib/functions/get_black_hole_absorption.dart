import 'package:flutter/material.dart';

int? getBlackHoleAbsorption (String? str) {

  return (str == null || DateTime.now().isAfter(DateTime.parse(str))) ? null : DateTime.parse(str).difference(DateTime.now()).inDays;
}